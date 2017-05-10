//
//  JYQuestionModel.h
//  减约
//
//  Created by 姬巧春 on 2016/11/3.
//  Copyright © 2016年 北京减脂时代科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYQuestionModel : NSObject

@property (nonatomic,copy) NSString *imageurl;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) NSArray *optionList;

@property (nonatomic,copy) NSString *type;


@end
