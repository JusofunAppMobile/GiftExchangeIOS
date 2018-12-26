//
//  ChangeLogisticsController.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/15.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "ChangeLogisticsController.h"
#import "CustomTextField.h"
#import "RecordLogisticsController.h"
@interface ChangeLogisticsController ()
@property (nonatomic ,strong) UILabel *numLab;

@property (nonatomic ,strong) CustomTextField *numText;

@end

@implementation ChangeLogisticsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBtn];
    [self setNavigationBarTitle:@"物流更改"];
    [self setRightNavigationBarBtnWithTitle:nil withImageName:@"扫一扫"];
    
    [self initView];
}

- (void)initView{

    UIView *backView1 = [UIView new];
    [self.view addSubview:backView1];
    [backView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(25);
    }];
    backView1.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *titleLab1 = [UILabel new];
    [backView1 addSubview:titleLab1];
    [titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(backView1);
    }];
    titleLab1.text      = @"当前物流";
    titleLab1.font      = KFont(12);
    titleLab1.textColor = RGBHex(@"#5b5b5b");

    UIView *backView2 = [UIView new];
    [self.view addSubview:backView2];
    [backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView1.mas_bottom).offset(1);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(55);
    }];
    backView2.backgroundColor = [UIColor whiteColor];
    
    self.numLab = ({
        UILabel *view = [UILabel new];
        [backView2 addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(backView2);
        }];
        view.font = KFont(15);
        view.text = [NSString stringWithFormat:@"运单编号：%@",_number];
        view;
    });
    
    
    UIView *backView3 = [UIView new];
    [self.view addSubview:backView3];
    [backView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView2.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(25);
    }];
    backView3.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLab2 = [UILabel new];
    [backView3 addSubview:titleLab2];
    [titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(backView3);
    }];
    titleLab2.font = KFont(12);
    titleLab2.text = @"变更物流";
    titleLab2.textColor = RGBHex(@"#5b5b5b");
    
    
    UIView *backView4 = [UIView new];
    [self.view addSubview:backView4];
    [backView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView3.mas_bottom).offset(1);
        make.left.bottom.right.mas_equalTo(self.view);
    }];
    backView4.backgroundColor = [UIColor whiteColor];
    
    self.numText = ({
        CustomTextField *view = [CustomTextField new];
        view.textAlignment = NSTextAlignmentCenter;
        view.textColor = [UIColor blackColor];
        [backView4 addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(275);
            make.height.mas_equalTo(42);
            make.top.mas_equalTo(backView4).offset(30);
            make.centerX.mas_equalTo(backView4);
        }];
        view.layer.cornerRadius = 20;
        view.layer.borderColor = RGBHex(@"#b1b1b1").CGColor;
        view.layer.borderWidth = 1.f;
        view.layer.masksToBounds = YES;
        view.font = KFont(14);
        //view.textColor = [UIColor grayColor];
        view.placeholder = @"请输入变更的运单编号";
        view;
    });
    
    
    UIButton *commitBtn = [UIButton new];
    [self.view addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-35);
    }];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn setBackgroundImage:KImageName(@"兑奖按钮") forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 按钮
- (void)commitAction{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:_pid forKey:@"pid"];
    [params setObject:_numText.text forKey:@"flowNo"];
    
    KWeakSelf
    [MBProgressHUD showMessag:@"" toView:nil];
    [RequestManager postWithURLString:KUpdateFlow parameters:params  success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 1) {
            [MBProgressHUD showSuccess:@"更改成功！" toView:nil];
            if (weakSelf.reloadBlock) {
                weakSelf.reloadBlock(_numText.text);
            }
            [weakSelf back];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"] toView:nil];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:nil animated:YES];
    }];
}

- (void)rightBtnAction{//扫描成功需要更新
    
    RecordLogisticsController *vc = [RecordLogisticsController new];
    vc.scanBlock = ^(NSString*resultStr){
        
        _numText.text = resultStr;
    };
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
