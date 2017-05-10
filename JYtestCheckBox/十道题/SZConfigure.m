//
//  SZConfigure.m
//  SZQuestionCheckBox_demo
//
//  Created by 吴三忠 on 16/5/26.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import "SZConfigure.h"

@implementation SZConfigure

- (CGFloat)titleFont {
    
    return 17.0;
}

- (CGFloat)optionFont {
    
    return 16.0;
}

- (CGFloat)oneLineHeight {
    
    return OPEN_OPTION_CELL_H;
}

- (CGFloat)topDistance {
    
    return 5.0;
}

- (CGFloat)buttonSize {
    
    return BUTTON_WIDTH;
}

- (UIColor *)backColor {
    
    return [UIColor whiteColor];
}

- (CGFloat)titleSideMargin {
    
    return HEADER_MARGIN;
}

- (CGFloat)optionSideMargin {
    
    return OPTION_MARGIN;
}

- (NSString *)checkedImage {
    return @"dx_h";
}

- (NSString *)unCheckedImage {
    
    return @"dx";
}

- (NSString *)multipleUncheckedImage {
    
    return @"unchecked";
}

- (NSString *)multipleCheckedImage {
    
    return @"checked";
}

- (NSString *)cellBackgroundImage{
    return @"article_tag_n";
}

- (UIColor *)titleTextColor {
    
    return [UIColor blackColor];
}

- (UIColor *)optionTextColor {
    
    return [UIColor blackColor];
}

@end
