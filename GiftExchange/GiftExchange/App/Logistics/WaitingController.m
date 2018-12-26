//
//  WaitingController.m
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/14.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "WaitingController.h"
#import "QFDatePickerView.h"
#import "NSDate+Tool.h"

@interface WaitingController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *backTableView;
    NSMutableArray *dataArray;
}

@property (nonatomic ,strong) QFDatePickerView *picker;

@property (nonatomic ,copy) NSString *startTime;

@property (nonatomic ,copy) NSString *endTime;

@end

@implementation WaitingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"待发货"];
    [self setBackBtn];
    
    dataArray = [NSMutableArray arrayWithCapacity:1];
//    [self initTimeWithDate:[NSDate date]];
    
    [self loadData:NO];
    
    [self drawView];
    [self addRefreshView];
}
#pragma mark - 刷新
- (void)addRefreshView{
    KWeakSelf
    backTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData:NO];
    }];
}

#pragma mark - 加载列表
//fromRecord 是否是更新录入信息
-(void)loadData:(BOOL)fromRecord{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:@"1" forKey:@"type"];
    if (_startTime) {
        [params setObject:_startTime forKey:@"startTime"];
    }
    if (_endTime) {
        [params setObject:_endTime forKey:@"endTime"];
    }
    KWeakSelf
    [MBProgressHUD showMessag:@"" toView:nil];
    [RequestManager postWithURLString:KFlowOrderList parameters:params  success:^(id responseObject) {
        
        if ([responseObject[@"code"] intValue]) {
            dataArray = [GiftExchangeModel mj_objectArrayWithKeyValuesArray:
                         responseObject[@"data"][@"list"]];
            [backTableView reloadData];
            [weakSelf setRightNavigationBarBtnWithTitle:
             [NSString stringWithFormat:@"共%d单",(int)dataArray.count] withImageName:@"日历"];
            [weakSelf showNoResultInView:backTableView hidden:[dataArray count]];
            
            if (fromRecord) {
                [MBProgressHUD showSuccess:@"录入成功！" toView:nil];
            }else{
                [MBProgressHUD hideHudToView:nil animated:YES];
            }
            
        }else{
            
            [MBProgressHUD showError:responseObject[@"msg"] toView:nil];
        }
        [backTableView.mj_header endRefreshing];
        [weakSelf hideNetFailView];
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:nil animated:YES];
        [backTableView.mj_header endRefreshing];
        [weakSelf showNetFailWithFrame:backTableView.frame];
    }];
}

//重新加载
- (void)netFailReload{
    [self loadData:NO];
}

//录入更新物流运单号
- (void)updateFlow:(NSString *)flowNo withModel:(GiftExchangeModel *)model{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:model.pid forKey:@"pid"];
    [params setObject:flowNo forKey:@"flowNo"];
    KWeakSelf
    [MBProgressHUD showMessag:@"" toView:nil];
    [RequestManager postWithURLString:KUpdateFlow parameters:params success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 1) {
            [weakSelf loadData:YES];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"] toView:nil];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:nil animated:YES];
    }];
}

#pragma mark - 扫描录入
-(void)check:(GiftExchangeModel *)model
{
    KWeakSelf
    RecordLogisticsController *vc = [[RecordLogisticsController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.scanBlock = ^(NSString * result){
        [weakSelf updateFlow:result withModel:model];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 手动录入
-(void)checkLogistics:(GiftExchangeModel *)model
{
    KWeakSelf
    WaitingView *view = [[WaitingView alloc]init];
    view.logisticsBlock = ^(NSString*str){
        [weakSelf updateFlow:str withModel:model];
    };
    [view show];
}

-(void)rightBtnAction
{
    [self.picker show];
}

#pragma mark - tableview
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GiftExchangeModel *model = [dataArray objectAtIndex:indexPath.section];
    GiftDetailController *vc = [[GiftDetailController alloc]init];
    vc.url = model.detailUrl;
    [self.navigationController pushViewController:vc animated:YES];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"identifier";
    LogisticsCell *cell = (LogisticsCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[LogisticsCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    cell.cellType = 0;
    cell.model = [dataArray objectAtIndex:indexPath.section];
    return cell;
    
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1 ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [dataArray count];
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    
    if(section == 0)
    {
        return 10;
    }
    else
    {
        return 5;
    }
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}


#pragma mark - 设置分割线从头开始

-(void)drawView
{
    
    backTableView = ({
        UITableView *view = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:view];
        view.estimatedRowHeight = 0;
        view.estimatedSectionHeaderHeight = 0;
        view.estimatedSectionFooterHeight = 0;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
        view.dataSource = self;
        view.delegate = self;
        view.rowHeight = UITableViewAutomaticDimension;
        view.estimatedRowHeight = 325;
        view;
    });
}

- (void)back{
    
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
}

#pragma mark lazy load

- (QFDatePickerView *)picker{
    if (!_picker) {
        KWeakSelf
        _picker = [[QFDatePickerView alloc]initDatePackerWithResponse:^(NSString *str) {
            NSDate *date = [NSDate dateFromString:str withFormat:@"yyyy-MM"];
            [weakSelf initTimeWithDate:date];
            [weakSelf loadData:NO];
        }];
    }
    return _picker;
}


- (void)initTimeWithDate:(NSDate *)date{
    
    NSDate *startDate = [NSDate firstDayInMonth:date];
    NSDate *endDate = [NSDate lastDayInMonth:date];
    
    self.startTime = [NSDate stringFromDate:startDate withFormat:@"yyyy-MM-dd"]?:@"";
    self.endTime = [NSDate stringFromDate:endDate withFormat:@"yyyy-MM-dd"]?:@"";
}



@end
