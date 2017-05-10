//
//  JYQuestionTableCell.m
//  减约
//
//  Created by 姬巧春 on 2016/11/3.
//  Copyright © 2016年 北京减脂时代科技有限公司. All rights reserved.
//

#import "JYQuestionTableCell.h"
#import "JYQuestionModel.h"
#import "JYQuestionOptionModel.h"
#import "UIImageView+WebCache.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


@interface JYQuestionTableCell ()

@property (nonatomic, strong) JYQuestionModel    *questionModel;
@property (nonatomic, strong) NSArray               *buttonArray;
@property (nonatomic, assign) CGFloat               current_height;
@property (nonatomic, copy) NSString *type;
@property (nonatomic,strong) UIButton *RadioButton;

@end


@implementation JYQuestionTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
        andJYTenQuestionModel:(JYQuestionModel *)questionModel
               andQuestionNum:(NSInteger)questionNum
                     andWidth:(CGFloat)width{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.RadioButton = nil;
        self.questionModel = questionModel;
        self.type = questionModel.type;
        [self setupLayoutWithJYTenQuestionModel:questionModel andWidth:width];
    }
    return self;
}

- (void)setupLayoutWithJYTenQuestionModel:(JYQuestionModel *)questionModel andWidth:(CGFloat)width{
    CGFloat titleWidth = width - 15 * 2;
    CGFloat optionWidth = width - 15 * 2 - 30 - 5;
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat cellHeight = [self cellHeight];
    UIButton *bgBtn = [[UIButton alloc] initWithFrame:CGRectMake(8, 0, (SCREEN_WIDTH-16), cellHeight)];
    [bgBtn setBackgroundImage:[UIImage imageNamed:@"historyphase_bg"] forState:UIControlStateNormal];
    [bgBtn setBackgroundImage:[UIImage imageNamed:@"historyphase_bg"] forState:UIControlStateHighlighted];
    [self addSubview:bgBtn];
    
    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 2, (width-24), 112)];
    headImage.contentMode = UIViewContentModeScaleAspectFill;
    headImage.clipsToBounds = YES;
    [headImage sd_setImageWithURL:[NSURL URLWithString:questionModel.imageurl] placeholderImage:[UIImage imageNamed:@"placeholder-img_420x240.jpg"]];
    [self addSubview:headImage];
    
    // 设置imageV左上和右上的圆角
    UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerTopRight;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:headImage.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(5,5)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = headImage.bounds;
    shapeLayer.path = maskPath.CGPath;
    headImage.layer.mask = shapeLayer;
    
    NSString *title = questionModel.title;
    // 标题
    CGFloat height = [self Text:title HeightWithFontSize:17 andWidth:titleWidth];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (112-height-17), (SCREEN_WIDTH-30), height)];
    titleLabel.textColor = [UIColor redColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.text = title;
    titleLabel.numberOfLines = 0;
    [self addSubview:titleLabel];
    
    // 选项
    UILabel *currentLabel;
    NSMutableArray *tempArray = [NSMutableArray array];
    NSArray *optionArray = questionModel.optionList;
    
    height = 132;
    for (int i = 0; i < optionArray.count; i++) {
        JYQuestionOptionModel *optionModel = optionArray[i];
        NSString *isSingleChoice = optionModel.mark;
        
        CGFloat option_height = [self Text:optionModel.optionTitle HeightWithFontSize:16 andWidth:optionWidth];
        
        if (currentLabel == nil) {
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(15 + 30 + 5, height, (SCREEN_WIDTH-30), option_height+10)];
            lbl.numberOfLines = 0;
            lbl.textColor = [UIColor lightGrayColor];
            lbl.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
            lbl.font = [UIFont systemFontOfSize:16];
            lbl.text = optionModel.optionTitle;
            [self addSubview:lbl];
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15, height, 30, 30)];
            
            if ([questionModel.type isEqualToString:@"1"]) { // 单选
                [btn setImage:[UIImage imageNamed:@"dx"] forState:UIControlStateNormal];
                
                [btn setImage:[UIImage imageNamed:@"dx_h"] forState:UIControlStateSelected];
                
            }else{
                [btn setImage:[UIImage imageNamed:[isSingleChoice isEqualToString:@"1"] ? @"dx" : @"unchecked"] forState:UIControlStateNormal];
                
                [btn setImage:[UIImage imageNamed:[isSingleChoice isEqualToString:@"1"] ? @"dx_h" : @"checked"] forState:UIControlStateSelected];
            }
            
            [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            btn.selected = NO;
            [self addSubview:btn];
            [tempArray addObject:btn];
            
            currentLabel = lbl;
        }else {
            
            UILabel *lbl;
    
            UIButton *btn;
            
            if ([questionModel.type isEqualToString:@"2"] && [isSingleChoice isEqualToString:@"1"]) { // 多选题 单选项
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(currentLabel.frame)+15, optionWidth+35, 0.5)];
                lineView.backgroundColor = [UIColor lightGrayColor];
                [self addSubview:lineView];
                
                lbl = [[UILabel alloc] initWithFrame:CGRectMake(15 + 30 + 5, CGRectGetMaxY(lineView.frame)+15, optionWidth, option_height+10)];
                
                btn = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(lineView.frame)+15, 30, 30)];
                [btn addTarget:self action:@selector(clickRadioButton:) forControlEvents:UIControlEventTouchUpInside];
                self.RadioButton = btn;
            }else{
                lbl = [[UILabel alloc] initWithFrame:CGRectMake(15 + 30 + 5, CGRectGetMaxY(currentLabel.frame), optionWidth, option_height+10)];
                
                btn = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(currentLabel.frame), 30, 30)];
                [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
                [tempArray addObject:btn];
            }
            
            // lable
            lbl.numberOfLines = 0;
            lbl.textColor = [UIColor lightGrayColor];
            lbl.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
            lbl.font = [UIFont systemFontOfSize:16];
            lbl.text = optionModel.optionTitle;
            [self addSubview:lbl];
            
            // btn
            if ([questionModel.type isEqualToString:@"1"]) { // 单选
                [btn setImage:[UIImage imageNamed:@"dx"] forState:UIControlStateNormal];
                
                [btn setImage:[UIImage imageNamed:@"dx_h"] forState:UIControlStateSelected];
            }else{
                [btn setImage:[UIImage imageNamed:[isSingleChoice isEqualToString:@"1"] ? @"dx" : @"unchecked"] forState:UIControlStateNormal];
                
                [btn setImage:[UIImage imageNamed:[isSingleChoice isEqualToString:@"1"] ? @"dx_h" : @"checked"] forState:UIControlStateSelected];
            }
            
            btn.selected = NO;
            [self addSubview:btn];
            
            currentLabel = lbl;
        }
    }
    self.buttonArray = tempArray.copy;
}


- (void)clickButton:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if ([self.type isEqualToString:@"1"]) { // 单选
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (UIButton *btn in self.buttonArray) {
            
            if (btn != sender) {
                
                btn.selected = NO;
            }
            [tempArray addObject:@(btn.selected)];
        }
    }else {
        self.RadioButton.selected = NO;
        NSMutableArray *tempArray = [NSMutableArray array];
        for (UIButton *btn in self.buttonArray) {
            [tempArray addObject:@(btn.selected)];
        }
    }
}

- (void)clickRadioButton:(UIButton *)sender{
    
    self.RadioButton = sender;
    sender.selected = !sender.selected;
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (UIButton *btn in self.buttonArray) {
        
        if (btn != sender) {
            
            btn.selected = NO;
        }
        [tempArray addObject:@(btn.selected)];
    }
}

- (CGFloat)cellHeight{
    
    CGFloat optionWidth = SCREEN_WIDTH - 15 * 2 - 30 - 5;
    
    CGFloat option_height = 0;
    for (JYQuestionOptionModel *optionModel in self.questionModel.optionList) {
        
        if ([self.questionModel.type isEqualToString:@"2"] && [optionModel.mark isEqualToString:@"1"]) {
            option_height += 30;
        }
        
        option_height += [self Text:optionModel.optionTitle HeightWithFontSize:16 andWidth:optionWidth];
    }
    
    CGFloat height = 152 + option_height + self.questionModel.optionList.count*10;
    return height;
}

- (CGFloat)Text:(NSString *)str HeightWithFontSize:(CGFloat)fontSize andWidth:(CGFloat)width
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
    return [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle} context:nil].size.height;
}


@end
