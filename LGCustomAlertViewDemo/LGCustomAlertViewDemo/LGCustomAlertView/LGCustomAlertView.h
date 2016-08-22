//
//  LGCustomAlertView.h
//  LGCustomAlertViewDemo
//
//  Created by mac on 16/7/11.
//  Copyright © 2016年 ZLG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGCustomAlertView;
@protocol LGCustomAlertViewDelegate <NSObject>

- (void)customAlertView:(LGCustomAlertView *)alertView clickButtonWithTag:(NSInteger)buttonTag;

- (void)customAlertView:(LGCustomAlertView *)alertView clickLabelWithTag:(NSInteger)labelTag;

@end

@interface LGCustomAlertView : UIView
/** 标题 */
@property (nonatomic,strong)UILabel *titleLabel;
/** 内容 */
@property (nonatomic,strong)UILabel *detailLabel;
/** 左边按钮 */
@property (nonatomic,strong)UIButton *canleButton;
/** 右边按钮 */
@property (nonatomic,strong)UIButton *otherButton;
/** 代理 */
@property (nonatomic,weak)id<LGCustomAlertViewDelegate>delegate;

- (instancetype) initWithTitle:(nullable NSString *)titleLabel  detail:(nullable NSString *)detailLabel delegate:(nullable id<LGCustomAlertViewDelegate>)delegate cancelButtonTitle:(nullable NSString *)cancelTitle otherButtonTitle:(nullable NSString *)otherTitle;





- (void) show;

@end
