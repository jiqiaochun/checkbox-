//
//  JYTenQuestionsController.m
//  减约
//
//  Created by 姬巧春 on 2016/11/2.
//  Copyright © 2016年 北京减脂时代科技有限公司. All rights reserved.
//

#import "JYTenQuestionsController.h"
#import "JYQuestionTableCell.h"

#import "JYQuestionModel.h"
#import "JYQuestionOptionModel.h"

#import "NSObject+YYModel.h"

@interface JYTenQuestionsController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) CGFloat titleWidth;
@property (nonatomic, assign) CGFloat OptionWidth;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *header;
@property (nonatomic, strong) NSMutableArray *sourceArray;

@end

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation JYTenQuestionsController

- (void)setupNav{
    
}

- (void)popButtonEventTouchUpInside{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonEventTouchUpInside{
    
}

// 初始化tableview
-(void)setupTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
    self.tableView.tableHeaderView = header;
    self.header = header;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:header.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.image = [UIImage imageNamed:@"sport_scheme_other_bg"];
    [self.header addSubview:imageView];
    
    UILabel *topLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 28, (SCREEN_WIDTH-30), 28)];
    topLable.textColor = [UIColor blackColor];
    topLable.font = [UIFont systemFontOfSize:20];
    topLable.text = @"量身定制专业减脂方案";
    topLable.textAlignment = NSTextAlignmentCenter;
    [self.header addSubview:topLable];
    
    UILabel *middleLable = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(topLable.frame)+6, (SCREEN_WIDTH-30), 20)];
    middleLable.textColor = [UIColor lightGrayColor];
    middleLable.font = [UIFont systemFontOfSize:14];
    middleLable.text = @"为了使你的减脂方案精准有效，";
    middleLable.textAlignment = NSTextAlignmentCenter;
    [self.header addSubview:middleLable];
    
    UILabel *bottomLable = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(middleLable.frame)+6, (SCREEN_WIDTH-30), 20)];
    bottomLable.textColor = [UIColor lightGrayColor];
    bottomLable.font = [UIFont systemFontOfSize:14];
    bottomLable.text = @"请认真回答以下问题！";
    bottomLable.textAlignment = NSTextAlignmentCenter;
    [self.header addSubview:bottomLable];
    
    NSDictionary *opdic = @{@"optionTitle":@"选项-----单选",@"mark":@"1"};
    NSDictionary *opdic2 = @{@"optionTitle":@"选项-----多选",@"mark":@"2"};
    JYQuestionOptionModel *model = [JYQuestionOptionModel modelWithDictionary:opdic];
    JYQuestionOptionModel *model2 = [JYQuestionOptionModel modelWithDictionary:opdic2];
    NSArray *optionArray = @[model2,model2,model2,model];
    NSArray *optionArray2 = @[model2,model2,model2,model2];
    
    NSDictionary *dic = @{@"imageurl":@"http://7xi4h1.com2.z0.glb.qiniucdn.com/images/2/76abf8ce9e8b489f9696de711b3ef159.jpg?hash=FmuNje_KsMeAd7t85bJlLzji2n1i&width=718&height=314&fsize=43453&scope=1",@"title":@"单选单选单选单选单选单选单选单选",@"optionList":optionArray,@"type":@"1"};
    NSDictionary *dic2 = @{@"imageurl":@"http://7xi4h1.com2.z0.glb.qiniucdn.com/images/2/76abf8ce9e8b489f9696de711b3ef159.jpg?hash=FmuNje_KsMeAd7t85bJlLzji2n1i&width=718&height=314&fsize=43453&scope=1",@"title":@"多选多选多选多选多选多选多选多选",@"optionList":optionArray,@"type":@"2"};
    NSDictionary *dic3 = @{@"imageurl":@"http://7xi4h1.com2.z0.glb.qiniucdn.com/images/2/76abf8ce9e8b489f9696de711b3ef159.jpg?hash=FmuNje_KsMeAd7t85bJlLzji2n1i&width=718&height=314&fsize=43453&scope=1",@"title":@"多选多选多选多选多选多选多选多选",@"optionList":optionArray2,@"type":@"2"};
    
    for (int i = 0; i < 2; i++) {
        JYQuestionModel *model = [JYQuestionModel modelWithDictionary:dic];
        [self.sourceArray addObject:model];
        JYQuestionModel *model2 = [JYQuestionModel modelWithDictionary:dic2];
        [self.sourceArray addObject:model2];
        JYQuestionModel *model3 = [JYQuestionModel modelWithDictionary:dic3];
        [self.sourceArray addObject:model3];
    }
}

// 修改滚动条颜色
//- (void)viewDidLayoutSubviews{
//    //设置滚动条的颜色
//    for (UIView* subview in [self.tableView subviews])
//    {
//        if([subview isKindOfClass:[UIImageView class]])
//        {
//            UIImageView *img = (UIImageView*)subview;
//            img.jy_width = 2.5;
//            img.image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#65DEC9"]];
//            [self.tableView bringSubviewToFront:img];
//        }
//    }
//    [super viewDidLayoutSubviews];
//}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.titleWidth = SCREEN_WIDTH - 15 * 2;
    self.OptionWidth = SCREEN_WIDTH - 15 * 2 - 30 - 5;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNav];
    
    [self setupTableView];
}


#pragma mark - UITableViewdatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.sourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
//    JYQuestionModel *model = self.sourceArray[section];
//    NSArray *optionArray = model.optionList;
//    return optionArray.count;
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JYQuestionModel *questionModel = self.sourceArray[indexPath.section];
    JYQuestionTableCell *cell = [[JYQuestionTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"questionCellIdentifier" andJYTenQuestionModel:questionModel andQuestionNum:indexPath.row+1 andWidth:SCREEN_WIDTH];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

#pragma mark - UITableViewdelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 3)];
    header.backgroundColor = [UIColor lightGrayColor];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

/**
 *  返回各个Cell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JYQuestionModel *model = self.sourceArray[indexPath.section];
    
    CGFloat topDistance = model.optionList.count*10;
    
    //CGFloat title_height = [model.title TextHeightWithFontSize:17 andWidth:self.titleWidth];
    
    CGFloat imageHeight = 152;
    
    CGFloat option_height = 0;
    
    for (JYQuestionOptionModel *optionModel in model.optionList) {
        
        if ([model.type isEqualToString:@"2"] && [optionModel.mark isEqualToString:@"1"]) {
            option_height += 30;
        }
        
        option_height += [self Text:optionModel.optionTitle HeightWithFontSize:16 andWidth:self.OptionWidth];
    }
    
    CGFloat height = imageHeight + option_height + topDistance;
    
    return height;
}

#pragma mark - 懒加载
- (NSMutableArray *)sourceArray {
    
    if (_sourceArray == nil) {
        _sourceArray = [NSMutableArray array];
    }
    return _sourceArray;
}

- (CGFloat)Text:(NSString *)str HeightWithFontSize:(CGFloat)fontSize andWidth:(CGFloat)width
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
    return [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle} context:nil].size.height;
}

@end
