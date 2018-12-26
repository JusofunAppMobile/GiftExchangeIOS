//
//  CustomTextField.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/15.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

- (CGRect)textRectForBounds:(CGRect)bounds{

    return CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width-10, bounds.size.height);
}
- (CGRect)editingRectForBounds:(CGRect)bounds{
 return CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width-10, bounds.size.height);
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds{
    return CGRectMake(self.width-self.rightView.width-10, (self.height-self.rightView.height)/2, self.rightView.width, self.rightView.height);
}

//- (CGRect)placeholderRectForBounds:(CGRect)bounds{
//    return CGRectMake(10, bounds.origin.y, bounds.size.width, bounds.size.height);
//}

@end
