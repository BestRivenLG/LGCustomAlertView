//
//  LGCustomAlertView.m
//  LGCustomAlertViewDemo
//
//  Created by mac on 16/7/11.
//  Copyright © 2016年 ZLG. All rights reserved.
//

#import "LGCustomAlertView.h"
#define LGCUSTOMALERTVIEWWIDTH   260

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
    
    self.backGroundView = [[UIView alloc]init];
    self.backGroundView.center = self.center;
    self.backGroundView.backgroundColor = [UIColor colorWithRed:225 green:225 blue:225 alpha:1];
    self.backGroundView.layer.masksToBounds = YES;
    self.backGroundView.layer.cornerRadius = 5;
    [self addSubview:self.backGroundView];
    
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = titleLabel;
    CGFloat titleHeight = [self getHeightWithTitle:titleLabel andFont:16];
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    self.titleLabel.frame = CGRectMake(20, 10, LGCUSTOMALERTVIEWWIDTH-20*2, titleHeight);
    self.titleLabel.numberOfLines = 0;
    [self.backGroundView addSubview:self.titleLabel];
    
    
    self.detailLabel = [[UILabel alloc]init];
    self.detailLabel.textColor = [UIColor blackColor];
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.text = detailLabel;
    CGFloat detailHeight = [self getHeightWithTitle:detailLabel andFont:13];
    self.detailLabel.font = [UIFont systemFontOfSize:13];
    self.detailLabel.frame = CGRectMake(20,10+self.titleLabel.frame.origin.y + titleHeight, LGCUSTOMALERTVIEWWIDTH-20*2, detailHeight);
    self.detailLabel.tag = 306;
    
    //detailLabel交互开启
//    self.detailLabel.userInteractionEnabled = YES;
    
    //detailLabel交互关闭
    self.detailLabel.userInteractionEnabled = NO;
    
    [self.backGroundView addSubview:self.detailLabel];
    
    self.horLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,self.detailLabel.frame.origin.y + detailHeight + 10 , LGCUSTOMALERTVIEWWIDTH*2, 1)];
    
    self.horLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];;
    [self.backGroundView addSubview:self.horLabel];
    
    self.verLabel = [[UILabel alloc]init];
    self.verLabel.frame = CGRectMake(LGCUSTOMALERTVIEWWIDTH/2, self.horLabel.frame.origin.y + self.horLabel.frame.size.height, 1, 40);
    
    self.verLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];;
    [self.backGroundView addSubview:self.verLabel];
    
    self.canleButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    self.canleButton.frame = CGRectMake(0, self.horLabel.frame.origin.y + 5, LGCUSTOMALERTVIEWWIDTH/2, 30);
    [self.canleButton setTitle:cancelTitle forState:UIControlStateNormal];
    self.canleButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [self.canleButton setTitleColor:[UIColor colorWithRed:(43.0/255.0) green:(157.0/255.0) blue:(255.0/255.0) alpha:1] forState:UIControlStateNormal];
    
    self.canleButton.tag = 0;
    [self.canleButton addTarget:self action:@selector(clickToButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.backGroundView addSubview: self.canleButton];
    
    self.otherButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    self.otherButton.frame = CGRectMake(LGCUSTOMALERTVIEWWIDTH/2, self.horLabel.frame.origin.y + 5, LGCUSTOMALERTVIEWWIDTH/2, 30);
    [self.otherButton setTitle:otherTitle forState:UIControlStateNormal];
    self.otherButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.otherButton setTitleColor:[UIColor colorWithRed:(43.0/255.0) green:(157.0/255.0) blue:(255.0/255.0) alpha:1] forState:UIControlStateNormal];
    
    self.otherButton.tag = 1;
    [self.otherButton addTarget:self action:@selector(clickToButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.backGroundView addSubview:self.otherButton];
    
    CGFloat height = CGRectGetMaxY(self.verLabel.frame);
    self.backGroundView.bounds = CGRectMake(0, 0, LGCUSTOMALERTVIEWWIDTH,  height);
    
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
