//
//  SendController.m
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/14.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "SendController.h"
#import "QFDatePickerView.h"
#import "NSDate+Tool.h"

@interface SendController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *backTableView;
    NSMutableArray *dataArray;
}

@property (nonatomic ,strong)  QFDatePickerView*picker;

@property (nonatomic ,copy) NSString *startTime;

@property (nonatomic ,copy) NSString *endTime;

@end

@implementation SendController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"已发货"];
    [self setBackBtn];
    
    dataArray = [NSMutableArray arrayWithCapacity:1];
//    [self initTimeWithDate:[NSDate date]];
    
    [self loadData];
    [self drawView];
    [self addRefreshView];
}

#pragma mark - 请求数据

-(void)loadData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:@"2" forKey:@"type"];
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
            
            [MBProgressHUD hideHudToView:nil animated:YES];
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
    [self loadData];
}

#pragma mark - 物流记录
-(void)check:(GiftExchangeModel *)model
{
    CheckLogisticsController *vc = [[CheckLogisticsController alloc]init];
    vc.flowNo = model.flowNo;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 更改物流
-(void)checkLogistics:(GiftExchangeModel *)model
{
    ChangeLogisticsController *vc = [[ChangeLogisticsController alloc]init];
    vc.number = model.flowNo;
    vc.pid = model.pid;
    vc.reloadBlock = ^(NSString *no){
        //更新运单号
        model.flowNo = no;
        [backTableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)rightBtnAction
{
    [self.picker show];

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
    cell.cellType = 1;
    cell.model = [dataArray objectAtIndex:indexPath.section];
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataArray.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
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



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GiftExchangeModel *model = [dataArray objectAtIndex:indexPath.section];
    GiftDetailController *vc = [[GiftDetailController alloc]init];
    vc.url = model.detailUrl;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - initView

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

- (void)addRefreshView{
    KWeakSelf
    backTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
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
            [weakSelf loadData];
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
