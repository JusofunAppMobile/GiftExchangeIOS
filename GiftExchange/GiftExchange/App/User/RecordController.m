//
//  RecordController.m
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/11.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "RecordController.h"
#import "AppDelegate.h"
#import "AddressModel.h"
//#import "SearchNoResultView.h"

@interface RecordController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *backTableView;
    NSMutableArray *dataArray;
}

//@property (nonatomic ,strong) SearchNoResultView *noResultView;
@end

@implementation RecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"兑换记录"];
    [self setBackBtn];
    
    dataArray = [NSMutableArray arrayWithCapacity:1];
    
    [self drawView];
    [self addRefreshView];
    [self loadData];
    
    if (_fromConfrimVC) {
        NSArray *viewControlers = self.navigationController.viewControllers;
        self.navigationController.viewControllers = @[viewControlers.firstObject,viewControlers.lastObject];
    }
}

#pragma mark - 网络请求
-(void)loadData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    
    KWeakSelf
    [MBProgressHUD showMessag:@"" toView:nil];
    [RequestManager postWithURLString:KExchangeRecord parameters:params  success:^(id responseObject) {
        
        if ([responseObject[@"code"] intValue] == 1) {
            dataArray = [GiftExchangeModel mj_objectArrayWithKeyValuesArray:
                         responseObject[@"data"][@"list"]];
            [weakSelf showNoResultInView:backTableView hidden:[dataArray count]];//显示无数据页面
            [backTableView reloadData];
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GiftExchangeModel *model = [dataArray objectAtIndex:indexPath.row];
    GiftDetailController *vc = [[GiftDetailController alloc]init];
    vc.url = model.detailUrl;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 更改地址
-(void)changeAddress:(GiftExchangeModel *)model
{
  
    EditAddressController *vc = [EditAddressController new];
    vc.type = ControllerTypeChange;
    vc.addrModel = model.addrInfo;
    vc.orderId = model.pid;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 查看物流
-(void)checkLogistics:(GiftExchangeModel *)model
{
    CheckLogisticsController *vc = [[CheckLogisticsController alloc]init];
    vc.flowNo = model.flowNo;
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"identifier";
    RecordCell *cell = (RecordCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[RecordCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    
    cell.model = [dataArray objectAtIndex:indexPath.row];
    return cell;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 225;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        UIView* headView = [[UIView alloc]initWithFrame:KFrame(0, 0, KDeviceW, 10)];
        headView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
        return headView;
    }
    else
    {
        return nil;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 10;
    }
    else
    {
        return 0.001;
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}


#pragma mark - 设置分割线从头开始
-(void)viewDidLayoutSubviews
{
    if ([backTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [backTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([backTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [backTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

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
        view;
    });
}

- (void)addRefreshView{
    KWeakSelf
    backTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
}

#pragma mark 通知  修改地址
- (void)addModifyAddrNoti{

    [KNotificationCenter addObserver:self selector:@selector(addrDidModified) name:KChangeAddressNoti object:nil];
}

- (void)addrDidModified{
    [self loadData];
}


- (void)willMoveToParentViewController:(UIViewController *)parent{
    [super willMoveToParentViewController:parent];
    
    NSArray *vcs = self.navigationController.viewControllers;
    
    if ([vcs.firstObject isKindOfClass:NSClassFromString(@"CustomTabBarController")]&&[vcs count]==2&&_fromConfrimVC) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    
}

@end
