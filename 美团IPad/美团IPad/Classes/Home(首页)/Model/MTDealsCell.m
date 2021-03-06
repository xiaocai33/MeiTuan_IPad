//
//  MTDealsCell.m
//  美团IPad
//
//  Created by 小蔡 on 16/5/8.
//  Copyright © 2016年 xiaocai. All rights reserved.
//

#import "MTDealsCell.h"
#import "MTDeals.h"
#import "UIView+SDAutoLayout.h"
#import "UIImageView+WebCache.h"
#import "MTCenterLineLabel.h"

@interface MTDealsCell()
/** 订单图片 */
@property (nonatomic, weak) UIImageView *dealImageView;
/**
 属性名不能以new开头
 */
/** 新单图片 */
@property (nonatomic, weak) UIImageView *dealNewImage;
/** 订单名称 */
@property (nonatomic, weak) UILabel *titleLabel;
/** 订单描述 */
@property (nonatomic, weak) UILabel *descLabel;
/** 订单现价 */
@property (nonatomic, weak) UILabel *currentPriceLabel;
/** 订单原件 */
@property (nonatomic, weak) MTCenterLineLabel *listPriceLabel;
/** 订单销售量 */
@property (nonatomic, weak) UILabel *purchaseCountLabel;

/** 遮盖按钮 */
@property (nonatomic, weak) UIButton *coverBtn;
/** 选中图片View */
@property (nonatomic, weak) UIImageView *checkView;
@end

@implementation MTDealsCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //初始化内部控件操作
        [self setupContentView];
        
        // 拉伸
        // self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dealcell"]];
        // 平铺
        // self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_dealcell"]];
    }
    return self;
}
/**
 *  内部控件操作
 */
- (void)setupContentView{
    
    //图片控件
    UIImageView *dealImageView = [[UIImageView alloc] init];
    dealImageView.image = [UIImage imageNamed:@"placeholder_deal"];
    
    [self addSubview:dealImageView];
    self.dealImageView = dealImageView;
    
    //自动布局
    dealImageView.sd_layout
    .leftSpaceToView(self, 10)
    .rightSpaceToView(self, 10)
    .topSpaceToView(self, 10)
    .heightIs(185);
    
    //新单Image ic_deal_new
    UIImageView *dealNewView = [[UIImageView alloc] init];
    dealNewView.image = [UIImage imageNamed:@"ic_deal_new"];
    [self addSubview:dealNewView];
    self.dealNewImage = dealNewView;
    
    //自动布局
    dealNewView.sd_layout
    .leftEqualToView(dealImageView)
    .topEqualToView(dealImageView)
    .heightIs(24)
    .widthIs(38);
    
    //底部描述\价格详情View
    [self setupDetailView];
    
    UIButton *coverBtn = [[UIButton alloc] init];
    coverBtn.backgroundColor = [UIColor whiteColor];
    coverBtn.alpha = 0.7;
    coverBtn.hidden = YES;
    [coverBtn addTarget:self action:@selector(coverBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:coverBtn];
    self.coverBtn = coverBtn;
    
    coverBtn.sd_layout.leftEqualToView(self).rightEqualToView(self).topEqualToView(self).bottomEqualToView(self);
    
    UIImageView *checkView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_choosed"]]; //26
    checkView.hidden = YES;
    [self addSubview:checkView];
    self.checkView = checkView;
    
    checkView.sd_layout.bottomEqualToView(self).rightEqualToView(self).heightIs(26).widthIs(26);
}

/**
 *  设置底部控件的布局
 */
- (void)setupDetailView{
    UIView *detailView = [[UIView alloc] init];
    [self addSubview:detailView];
    
    detailView.sd_layout
    .leftSpaceToView(self, 10)
    .rightSpaceToView(self, 10)
    .bottomSpaceToView(self, 10)
    .topSpaceToView(self.dealImageView, 10);
    
    //设置容器中的控件
    //标题Label
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:17.0];
    
    [detailView addSubview:titleLabel];
    
    self.titleLabel = titleLabel;
    
    titleLabel.sd_layout.leftEqualToView(detailView).rightEqualToView(detailView).topEqualToView(detailView).heightIs(21);
    
    //团购信息描述信息
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.font = [UIFont systemFontOfSize:14.0];
    descLabel.textColor = [UIColor grayColor];
    //descLabel.text = @"哈哈大家哈减肥哈哈附加咖啡黑金卡回复,哈哈大家哈减肥哈哈附加咖啡黑金卡回复";
    descLabel.numberOfLines = 0;
    [detailView addSubview:descLabel];
    
    self.descLabel = descLabel;
    
    descLabel.sd_layout.leftEqualToView(detailView).rightEqualToView(detailView).topSpaceToView(titleLabel, 5).heightIs(60);
    
    //当前价格
    UILabel *currentPriceLabel = [[UILabel alloc] init];
    currentPriceLabel.textColor = [UIColor orangeColor];
    currentPriceLabel.font = [UIFont systemFontOfSize:20.0];
    //设置UILabel宽度自适应
    [currentPriceLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    [detailView addSubview:currentPriceLabel];
    
    self.currentPriceLabel = currentPriceLabel;
    
    currentPriceLabel.sd_layout.leftEqualToView(detailView).bottomEqualToView(detailView).heightIs(20);
    
    //历史价格
    MTCenterLineLabel *listPriceLabel = [[MTCenterLineLabel alloc] init];
    listPriceLabel.textColor = [UIColor grayColor];
    listPriceLabel.font = [UIFont systemFontOfSize:11.0];
    [listPriceLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    [detailView addSubview:listPriceLabel];
    self.listPriceLabel = listPriceLabel;
    
    listPriceLabel.sd_layout.leftSpaceToView(currentPriceLabel, 5).bottomEqualToView(detailView).heightIs(15);
    
    //销售量
    UILabel *purchaseCountLabel = [[UILabel alloc] init];
    purchaseCountLabel.textColor = [UIColor grayColor];
    purchaseCountLabel.font = [UIFont systemFontOfSize:11.0];
    purchaseCountLabel.textAlignment = NSTextAlignmentRight;
    
    [detailView addSubview:purchaseCountLabel];
    self.purchaseCountLabel = purchaseCountLabel;
    
    purchaseCountLabel.sd_layout.rightEqualToView(detailView).bottomEqualToView(detailView).heightIs(15).widthIs(100);
    
    
}

/**
 *  设置cell的背景
 */
- (void)drawRect:(CGRect)rect{
    // 拉伸
    [[UIImage imageNamed:@"bg_dealcell"] drawInRect:rect];
    
    // 平铺
    //    [[UIImage imageNamed:@"bg_dealcell"] drawAsPatternInRect:rect];
}

- (void)setDeal:(MTDeals *)deal{
    _deal = deal;
    //NSLog(@"setDeal---%@", deal.image_url);
    
    [self.dealImageView sd_setImageWithURL:[NSURL URLWithString:deal.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    //订单名称
    self.titleLabel.text = deal.title;
    //订单描述
    self.descLabel.text = deal.desc;
    //现价
    //NSLog(@"%@", deal.current_price);
    self.currentPriceLabel.text = [NSString stringWithFormat:@"¥ %@", deal.current_price];
    NSUInteger currentDotLoc = [self.currentPriceLabel.text rangeOfString:@"."].location;
    if (currentDotLoc != NSNotFound) {
        // 超过2位小数
        if (self.currentPriceLabel.text.length - currentDotLoc > 3) {
            self.currentPriceLabel.text = [self.currentPriceLabel.text substringToIndex:currentDotLoc + 2];
        }
    }
    //原价
    self.listPriceLabel.text = [NSString stringWithFormat:@"¥ %@", deal.list_price];
    NSUInteger dotLoc = [self.listPriceLabel.text rangeOfString:@"."].location;
    if (dotLoc != NSNotFound) {
        // 超过2位小数
        if (self.listPriceLabel.text.length - dotLoc > 3) {
            self.listPriceLabel.text = [self.listPriceLabel.text substringToIndex:dotLoc + 3];
        }
    }

    //销量
    self.purchaseCountLabel.text = [NSString stringWithFormat:@"已售%zd", deal.purchase_count];
    
    //判断是否显示新单
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *nowStr = [formatter stringFromDate:[NSDate date]];
    
    // 隐藏: 发布日期 < 今天
    self.dealNewImage.hidden = ([deal.publish_date compare:nowStr] == NSOrderedAscending);
    
    // 根据模型属性来控制cover的显示和隐藏
    self.coverBtn.hidden = !deal.isEditting;
    
    // 根据模型属性来控制打钩的显示和隐藏
    self.checkView.hidden = !deal.isChecking;
    
}

- (void)coverBtnClick:(UIButton *)btn{
    // 设置模型
    self.deal.checking = !self.deal.isChecking;
    // 直接修改状态
    self.checkView.hidden = !self.checkView.isHidden;
    
    if ([self.delegate respondsToSelector:@selector(dealCellCheckingStateDidChange:)]) {
        [self.delegate dealCellCheckingStateDidChange:self];
    }
}



@end
