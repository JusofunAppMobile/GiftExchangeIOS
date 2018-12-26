//
//  RecordCell.h
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/14.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYLabel.h"
#import "GiftExchangeModel.h"
@protocol RecordCellDelegate <NSObject>


/**
 更改地址

 @param model cell的数据
 */
-(void)changeAddress:(GiftExchangeModel*)model;


/**
 查看物流

 @param model cell的数据
 */
-(void)checkLogistics:(GiftExchangeModel*)model;


@end

@interface RecordCell : UITableViewCell


@property(nonatomic,assign) id<RecordCellDelegate>delegate;

/**
 订单号
 */
@property(nonatomic,strong)UILabel *orderLabel;


/**
 日期
 */
@property(nonatomic,strong)UILabel *timeLabel;

/**
 图片
 */
@property(nonatomic,strong)UIImageView*goodsImageView;

/**
 图片
 */
@property(nonatomic,strong)UIImageView*goodsImageView2;

/**
 图片
 */
@property(nonatomic,strong)UIImageView*goodsImageView3;


/**
 名字
 */
@property(nonatomic,strong)LYLabel *nameLabel;


/**
 型号
 */
@property(nonatomic,strong)LYLabel *typeLabel;


/**
 卡的名字
 */
@property(nonatomic,strong)UILabel *cardLabel;


/**
 商品数量
 */
@property(nonatomic,strong)UILabel *numLabel;


/**
 提示信息
 */
@property(nonatomic,strong)UILabel *tipLabel;

/**
 更改地址
 */
@property(nonatomic,strong)UIButton *adressBtn;


/**
 查看物流
 */
@property(nonatomic,strong)UIButton *logisticsBtn;



@property(nonatomic,strong)GiftExchangeModel*model;


@property (nonatomic ,assign) NSInteger index;




@end
