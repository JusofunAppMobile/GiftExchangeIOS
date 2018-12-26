//
//  PushController.m
//  GiftExchange
//
//  Created by WangZhipeng on 17/7/20.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "PushController.h"

@interface PushController ()

@end

@implementation PushController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button       = [[UIButton alloc]initWithFrame:CGRectMake(30, 100, 80,40)];
    [button setTitle:@"查询" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    [button addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    UITextField *field     = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button.frame), 100 , 100 , 30)];
    field.placeholder      = @"请输入快递单号";
    [self.view addSubview:field];
    
    // Do any additional setup after loading the view.
}


- (void)checkAction{
    NSLog(@"查询");
    
    NSString *appcode = @"04ba93c1c338466d8af6d755eaadc2fe";
    NSString *method = @"GET";

    NSString *host = @"https://ali-deliver.showapi.com";
    NSString *path = @"/showapi_expInfo";
    NSString *querys = @"?com=auto&nu=670980426029";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
//    NSString *bodys = @"";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       
                                                       NSHTTPURLResponse *rep = (NSHTTPURLResponse *)response;
                                                       
                                                       if (rep.statusCode == 200) {
                                                           
                                                           
                                                           NSString *data = [body mj_JSONString];
                                                           
                                                           NSLog(@"Response body: %@" , data);

                                                       }else{
                                                       
                                                           NSLog(@"失败code: %li",rep.statusCode);
                                                       }
                                                      
                                                       //打印应答中的body
                                                   }];
    
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
