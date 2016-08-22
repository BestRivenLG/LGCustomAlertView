//
//  LGCustomAlertView.m
//  LGCustomAlertViewDemo
//
//  Created by mac on 16/7/11.
//  Copyright © 2016年 ZLG. All rights reserved.
//

#import "LGCustomAlertView.h"
#define LGCUSTOMALERTVIEWWIDTH   260
#define LGRealWidth(value) ((value)/320.0f * [UIScreen mainScreen].bounds.size.width)
#define LGRealHeight(value) ((value)/480.0f *[UIScreen mainScreen].bounds.size.height)

#define IS_IPHONE_6 ([[UIScreen mainScreen] bounds].size.height == 667.0f)
#define IS_IPHONE_6_PLUS ([[UIScreen mainScreen] bounds].size.height == 736.0f)
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == 568.0f)

// 这里设置iPhone5放大的字号数（现在是放大2号，也就是iPhone4s和iPhone5上字体为15时，iPhone6上字号为17）
#define IPHONE5_INCREMENT 1

// 这里设置iPhone6放大的字号数（现在是放大2号，也就是iPhone4s和iPhone5上字体为15时，iPhone6上字号为18）
#define IPHONE6_INCREMENT 2

// 这里设置iPhone6Plus放大的字号数（现在是放大3号，也就是iPhone4s和iPhone5上字体为15时，iPhone6上字号为19）
#define IPHONE6PLUS_INCREMENT 3



@interface LGCustomAlertView ()
/**  提示框视图 */
@property (nonatomic,strong)UIView *backGroundView;
/**  水平分割线 */
@property (nonatomic,strong)UILabel *horLabel;
/**  垂直分割线 */
@property (nonatomic,strong)UILabel *verLabel;
@end

@implementation LGCustomAlertView

- (instancetype) initWithTitle:(nullable NSString *)titleLabel  detail:(nullable NSString *)detailLabel delegate:(nullable id<LGCustomAlertViewDelegate>)delegate cancelButtonTitle:(nullable NSString *)cancelTitle otherButtonTitle:(nullable NSString *)otherTitle {

    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        
        //蒙板
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
        
        self.delegate = delegate;
        
        [self setupSubViewWithTitle:titleLabel detail:detailLabel cancelButtonTitle:cancelTitle otherButtonTitle:otherTitle];
    }
    return self;
}

- (void) setupSubViewWithTitle:(NSString *)titleLabel detail:(NSString *)detailLabel cancelButtonTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherTitle {
    
    CGFloat titleFontSize;
    CGFloat detailFontSize;
    CGFloat btnFontSize;
    CGFloat cornerRadius;
    
    if (IS_IPHONE_6_PLUS) {
        titleFontSize = IPHONE6PLUS_INCREMENT + 16.0f;
        detailFontSize = IPHONE6PLUS_INCREMENT + 13.0f;
        btnFontSize = IPHONE6PLUS_INCREMENT + 16.0f;
        cornerRadius = 15;
        
    }else if (IS_IPHONE_6){
        titleFontSize = IPHONE6_INCREMENT + 16.0f;
        detailFontSize = IPHONE6_INCREMENT + 13.0f;
        btnFontSize = IPHONE6_INCREMENT + 16.0f;
        cornerRadius = 10;
        
    }else if (IS_IPHONE_5){
        titleFontSize = IPHONE5_INCREMENT + 16.0f ;
        detailFontSize = IPHONE5_INCREMENT + 13.0f;
        btnFontSize = IPHONE5_INCREMENT + 16.0f;
        cornerRadius = 5;
        
    }else{
        titleFontSize = 16.0f;
        detailFontSize = 13.0f;
        btnFontSize = 16.0f;
        cornerRadius = 5;
        
    }

    CGFloat realWidth = LGRealWidth(LGCUSTOMALERTVIEWWIDTH);

    self.backGroundView = [[UIView alloc]init];
    self.backGroundView.center = self.center;
    self.backGroundView.backgroundColor = [UIColor colorWithRed:225 green:225 blue:225 alpha:1];
    self.backGroundView.layer.masksToBounds = YES;
    self.backGroundView.layer.cornerRadius = cornerRadius;
    [self addSubview:self.backGroundView];
    
    
    CGFloat margin_x = LGRealWidth(20);
    CGFloat margin_y = LGRealHeight(10);
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = titleLabel;
    CGFloat titleHeight = [self getHeightWithTitle:titleLabel andFont:titleFontSize];
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:titleFontSize];
    self.titleLabel.frame = CGRectMake(margin_x, margin_y,realWidth- margin_x*2, titleHeight);
    self.titleLabel.numberOfLines = 0;
    [self.backGroundView addSubview:self.titleLabel];
    
    
    self.detailLabel = [[UILabel alloc]init];
    self.detailLabel.textColor = [UIColor blackColor];
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.text = detailLabel;
    CGFloat detailHeight = [self getHeightWithTitle:detailLabel andFont:detailFontSize];
    self.detailLabel.font = [UIFont systemFontOfSize:detailFontSize];
    self.detailLabel.frame = CGRectMake(margin_x,10+self.titleLabel.frame.origin.y + titleHeight, realWidth- margin_x*2, detailHeight);
    self.detailLabel.tag = 306;
    
    //detailLabel交互开启
//    self.detailLabel.userInteractionEnabled = YES;
    
    //detailLabel交互关闭
    self.detailLabel.userInteractionEnabled = NO;
    
    [self.backGroundView addSubview:self.detailLabel];
    
    self.horLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,self.detailLabel.frame.origin.y + detailHeight + 10 , realWidth*2, 1)];
    
    self.horLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];;
    [self.backGroundView addSubview:self.horLabel];
    
    CGFloat verLabel_h = LGRealHeight(30);
    CGFloat btn_h = LGRealHeight(20);
    CGFloat btn_margin = (verLabel_h - btn_h)/2.0;
    
    self.verLabel = [[UILabel alloc]init];
    self.verLabel.frame = CGRectMake(realWidth/2, self.horLabel.frame.origin.y + self.horLabel.frame.size.height, 1, verLabel_h);
    
    self.verLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];;
    [self.backGroundView addSubview:self.verLabel];
    
    self.canleButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    self.canleButton.frame = CGRectMake(0, self.horLabel.frame.origin.y + btn_margin, realWidth/2, btn_h);
    [self.canleButton setTitle:cancelTitle forState:UIControlStateNormal];
    self.canleButton.titleLabel.font = [UIFont systemFontOfSize:btnFontSize];
    
    [self.canleButton setTitleColor:[UIColor colorWithRed:(43.0/255.0) green:(157.0/255.0) blue:(255.0/255.0) alpha:1] forState:UIControlStateNormal];
    
    self.canleButton.tag = 0;
    [self.canleButton addTarget:self action:@selector(clickToButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.backGroundView addSubview: self.canleButton];
    
    self.otherButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    self.otherButton.frame = CGRectMake(LGRealWidth(LGCUSTOMALERTVIEWWIDTH)/2, self.horLabel.frame.origin.y + btn_margin, realWidth/2, btn_h);
    [self.otherButton setTitle:otherTitle forState:UIControlStateNormal];
    self.otherButton.titleLabel.font = [UIFont systemFontOfSize:btnFontSize];
    [self.otherButton setTitleColor:[UIColor colorWithRed:(43.0/255.0) green:(157.0/255.0) blue:(255.0/255.0) alpha:1] forState:UIControlStateNormal];
    
    self.otherButton.tag = 1;
    [self.otherButton addTarget:self action:@selector(clickToButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.backGroundView addSubview:self.otherButton];
    
    CGFloat height = CGRectGetMaxY(self.verLabel.frame);
    self.backGroundView.bounds = CGRectMake(0, 0, realWidth,  height);
    
    UITapGestureRecognizer *tapDetailLab = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toDoSomething:)];
    [self.detailLabel addGestureRecognizer:tapDetailLab];
    
    [self shakeToShow:self.backGroundView];
    
}

- (void)clickToButton:(UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(customAlertView:clickButtonWithTag:)]) {
        
        [self.delegate customAlertView:self clickButtonWithTag:button.tag];
    }
    [self removeFromSuperview];
}

//detailLabel交互开启 才会响应协议方法
- (void)toDoSomething:(UITapGestureRecognizer *)tap {

    if ([self.delegate respondsToSelector:@selector(customAlertView:clickLabelWithTag:)]) {
        
        [self.delegate customAlertView:self clickLabelWithTag:tap.self.view.tag];
    }
    [self removeFromSuperview];
}


- (void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

//动态计算高度
-(CGFloat)getHeightWithTitle:(NSString *)title andFont:(NSInteger)fontsize
{
    CGFloat height = [title boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]} context:nil].size.height;
    return height;
}

//显示提示框的动画
- (void) shakeToShow:(UIView*)aView{
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.2;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}


@end
