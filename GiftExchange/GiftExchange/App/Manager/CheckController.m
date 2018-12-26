//
//  CheckController.m
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/14.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "CheckController.h"
#import "QFDatePickerView.h"
#import "NSDate+Tool.h"


@interface CheckController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *backTableView;
    NSMutableArray *dataArray;
}
@property (nonatomic ,strong) QFDatePickerView *picker;

@property (nonatomic ,copy) NSString *startTime;

@property (nonatomic ,copy) NSString *endTime;

@property (nonatomic ,assign) int page;

@property (nonatomic ,assign) BOOL moreData;

@end

@implementation CheckController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"待审核"];
    [self setBackBtn];
    
    self.page = 1;
    dataArray = [NSMutableArray arrayWithCapacity:1];
    [self loadData:YES];
    [self drawView];
    [self addRefreshView];
}

#pragma mark - 请求数据
-(void)loadData:(BOOL)loading{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:@"1" forKey:@"type"];
    [params setObject:@(_page) forKey:@"pageNum"];

    if (_startTime) {
        [params setObject:_startTime forKey:@"startTime"];
    }
    if (_endTime) {
        [params setObject:_endTime forKey:@"endTime"];
    }
    if (loading) {
        [MBProgressHUD showMessag:@"" toView:nil];
    }

    KWeakSelf
    [RequestManager postWithURLString:KGiftAuditList parameters:params success:^(id responseObject) {
        if (loading) {
            [MBProgressHUD hideHudToView:nil animated:YES];
        }
        if ([responseObject[@"code"] intValue]) {
            if (weakSelf.page == 1) {
                [dataArray removeAllObjects];
            }
            NSArray *datas = [GiftExchangeModel mj_objectArrayWithKeyValuesArray:
                              responseObject[@"data"][@"list"]];
            
            [dataArray addObjectsFromArray:datas];
            [backTableView reloadData];
            
            weakSelf.moreData = !(datas.count <KPageSize);
            weakSelf.page += weakSelf.moreData;
            
            [weakSelf setRightNavigationBarBtnWithTitle:
             [NSString stringWithFormat:@"共%d单",(int)dataArray.count] withImageName:@"日历"];
            [weakSelf showNoResultInView:backTableView hidden:[dataArray count]];
        }else{
        
            [MBProgressHUD showError:responseObject[@"msg"] toView:nil];
        }
        
        [weakSelf endRefresh];
        [weakSelf hideNetFailView];
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:nil animated:YES];
        [weakSelf endRefresh];
        [weakSelf showNetFailWithFrame:backTableView.frame];
    }];
}

//重新加载
- (void)netFailReload{
    [self loadData:YES];
}

#pragma mark - 审核
-(void)check:(GiftExchangeModel *)model{
    KWeakSelf
    CheckView *view = [[CheckView alloc]init];
    view.checkBlock = ^(CheckType type){
        NSLog(@"type=%d",(int)type);
        [weakSelf auditOrder:type withModel:model];
    };
    [view show];
}

- (void)auditOrder:(int)type withModel:(GiftExchangeModel *)model{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:@(type) forKey:@"type"];
    [params setObject:model.no forKey:@"no"];
    
    KWeakSelf
    [MBProgressHUD showMessag:@"" toView:nil];
    [RequestManager postWithURLString:KAuditOrder parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHudToView:nil animated:YES];

        if ([responseObject[@"code"] intValue] == 1) {
            [MBProgressHUD showSuccess:@"操作成功！" toView:nil];
            [weakSelf loadData:NO];
        }else{
            [MBProgressHUD hideHudToView:nil animated:YES];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:nil animated:YES];
    }];
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
    CheckCell *cell = (CheckCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[CheckCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
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
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [dataArray count];
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

#pragma mark - view

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

#pragma mark - 刷新
- (void)addRefreshView{
    KWeakSelf
    backTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf loadData:NO];
    }];
    
    backTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadData:NO];
    }];
}

- (void)endRefresh{
    [backTableView.mj_header endRefreshing];
    if (_moreData) {
        [backTableView.mj_footer endRefreshing];
    }else{
        [backTableView.mj_footer endRefreshingWithNoMoreData];
    }
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
            [weakSelf loadData:YES];//查询
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
