//
//  ViewController.m
//  LGCustomAlertViewDemo
//
//  Created by mac on 16/7/11.
//  Copyright © 2016年 ZLG. All rights reserved.
//

#import "ViewController.h"
#import "LGCustomAlertView.h"

@interface ViewController ()<LGCustomAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    LGCustomAlertView *alert = [[LGCustomAlertView alloc] initWithTitle:@"提示更新" detail:@"啦啦啦啦啦啦啦啦啦啦" delegate:self cancelButtonTitle:@"确定" otherButtonTitle:@"取消"];
    alert.tag = 20;
    [alert show];
}

- (void)customAlertView:(LGCustomAlertView *)alertView clickButtonWithTag:(NSInteger)buttonTag
{
    NSLog(@"%s alert.tag = %ld, tag %ld",__func__,alertView.tag,buttonTag);

}

- (void)customAlertView:(LGCustomAlertView *)alertView clickLabelWithTag:(NSInteger)labelTag
{
    NSLog(@"%s alert.tag = %ld, tag %ld",__func__,alertView.tag,labelTag);
}

@end
