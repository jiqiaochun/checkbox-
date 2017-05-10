//
//  JYQuestionTableCell.h
//  减约
//
//  Created by 姬巧春 on 2016/11/3.
//  Copyright © 2016年 北京减脂时代科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JYQuestionModel.h"

@interface JYQuestionTableCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
        andJYTenQuestionModel:(JYQuestionModel *)questionModel
               andQuestionNum:(NSInteger)questionNum
                     andWidth:(CGFloat)width;

@end
