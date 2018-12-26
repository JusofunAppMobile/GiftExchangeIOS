//
//  LogisticsCell.h
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/14.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYLabel.h"
#import "GiftExchangeModel.h"
@protocol LogisticsCellDelegate <NSObject>

@optional
/**
 审核
 
 @param model cell的数据
 */
-(void)check:(GiftExchangeModel*)model;


/**
 查看物流
 
 @param model cell的数据
 */
-(void)checkLogistics:(GiftExchangeModel*)model;


@end
@interface LogisticsCell : UITableViewCell

@property(nonatomic,assign)id<LogisticsCellDelegate>delegate;

/**
 订单号
 */
@property(nonatomic,strong)UILabel *orderLabel;


/**
 日期
 */
@property(nonatomic,strong)UILabel *timeLabel;



/**
 收件人
 */
@property(nonatomic,strong)UILabel *receiverLabel;


/**
 联系电话
 */
@property(nonatomic,strong)UILabel *phoneLabel;

/**
 联系地址
 */
@property(nonatomic,strong)UILabel *adressLabel;

/**
 图片
 */
@property(nonatomic,strong)UIView*imageBgView;


/**
 名字
 */
@property(nonatomic,strong)UILabel *nameLabel;


/**
 商品数量
 */
@property(nonatomic,strong)UILabel *numLabel;


/**
 提示信息
 */
@property(nonatomic,strong)UILabel *tipLabel;

/**
 审核
 */
@property(nonatomic,strong)UIButton *checkBtn;


/**
 查看物流
 */
@property(nonatomic,strong)UIButton *logisticsBtn;



@property(nonatomic,strong)GiftExchangeModel*model;


/**
 类型 //0：待处理  1:已发货
 */
@property(nonatomic,assign)int cellType;


@end
