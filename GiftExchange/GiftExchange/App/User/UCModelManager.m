//
//  UCModelManager.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/28.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "UCModelManager.h"

@interface UCModelManager ()

@property (nonatomic ,strong) NSMutableArray *section1;

@property (nonatomic ,strong) NSMutableArray *section2;

@property (nonatomic ,strong) NSMutableArray *section3;

@property (nonatomic ,strong) NSMutableArray *sections;

@end

@implementation UCModelManager

- (instancetype)init{
    if (self = [super init]) {
        [self bindModel];
    }
    return self;
}

//角色类型 1：银行用户 2：快递员用户 3：普通用户 4：管理员用户 5.银行管理员
- (void)bindModel{

    [self.section1 addObject:@"兑换记录"];
    [self.section1 addObject:@"我的电子券"];
    [self.sections addObject:_section1];
    
    int type = [KUSER.type intValue];
    
    NSString *phone = kGetUserDefaults(@"servicenumber")?kGetUserDefaults(@"servicenumber"):@"";//客服电话
    phone = [NSString stringWithFormat:@"联系客服：%@",phone];
    
    if (type == 1) {

        [self.section2 addObject:@"赠送电子券"];

        [self.section3 addObject:phone];
        
        [self.sections addObject:_section2];
        [self.sections addObject:_section3];

    }else if (type == 2){

        [self.section2 addObject:@"物流管理"];

        [self.section3 addObject:phone];

        [self.sections addObject:_section2];
        [self.sections addObject:_section3];
        
    }else if(type == 4){
        
        [self.section2 addObject:@"订单核审"];
        [self.section2 addObject:@"发卡管理"];
        [self.section2 addObject:@"发卡历史"];
        
        [self.section3 addObject:phone];
        
        [self.sections addObject:_section2];
        [self.sections addObject:_section3];
    }else if (type == 5){

        [self.section2 addObject:@"发卡管理"];
        [self.section2 addObject:@"发卡历史"];
        
        [self.section3 addObject:phone];
        
        [self.sections addObject:_section2];
        [self.sections addObject:_section3];

    }else{
        [self.section2 addObject:phone];
        [self.sections addObject:_section2];

    }
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return [self.sections[section-1] count];
}

- (NSInteger)numberOfSections{
    return [self.sections count];
}

- (NSString *)titleForIndexPath:(NSIndexPath *)indexPath{
    NSArray *section = _sections[indexPath.section-1];
    NSString *title  = section[indexPath.row];
    return title;
}

- (void)updateModel:(NSString *)phone{
    kSaveUserDefaults(phone, @"servicenumber");
    int type = [KUSER.type intValue];

    if (type != 3) {
        [self.section3 replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"联系客服：%@",phone]];
    }else{
        [self.section2 replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"联系客服：%@",phone]];
    }
}



#pragma mark lazy load

- (NSMutableArray *)section1{
    if (!_section1) {
        _section1 = [NSMutableArray array];
    }
    return _section1;
}

- (NSMutableArray *)section2{
    if (!_section2) {
        _section2 = [NSMutableArray array];
    }
    return _section2;
}

-  (NSMutableArray *)section3{
    if (!_section3) {
        _section3 = [NSMutableArray array];
    }
    return _section3;
}

- (NSMutableArray *)sections{
    if (!_sections) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}


@end
