//
//  ViewController.m
//  UIMenuControllerDemo
//
//  Created by admin on 16/3/31.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic)  UILabel *menuLabel;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];


    self.menuLabel =[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-120, 200, 240, 50)];
    self.menuLabel.text = @"UIMenuViewControllerDemo";
    self.menuLabel.textAlignment = NSTextAlignmentCenter;
    self.menuLabel.textColor = [UIColor blackColor];
    self.menuLabel.backgroundColor =[UIColor cyanColor];
    self.menuLabel.userInteractionEnabled   = YES;
    [self.view addSubview:self.menuLabel];
    
    
    NSLog(@"viewDidLoad");
    
    UILongPressGestureRecognizer *longpress =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    longpress.delegate = self;
//    longpress.minimumPressDuration = 2;
    
    
    
    
    
    [self.menuLabel addGestureRecognizer:longpress];

}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    
    
    if (longPress.state==UIGestureRecognizerStateBegan) {
        //长按事件开始
        
        [self.view becomeFirstResponder];
        
        UIMenuController *menu=[UIMenuController sharedMenuController];
        
        UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyItemClicked:)];
        
        UIMenuItem *resendItem = [[UIMenuItem alloc] initWithTitle:@"转发" action:@selector(resendItemClicked:)];
        
        [menu setMenuItems:[NSArray arrayWithObjects:copyItem,resendItem,nil]];
        
        //设置menu显示在哪儿
//        [menu setTargetRect:self.bounds inView:self];
        [menu setTargetRect:self.menuLabel.frame inView:self.view];
        
        //设置item 显示
        [menu setMenuVisible:YES animated:YES];
        
    }else if ([longPress state] == UIGestureRecognizerStateEnded) {
        //长按事件结束
        //do something
    }
    
}
//告诉能控制器nemuitem能返回什么
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    if(action ==@selector(copyItemClicked:)){
        
        return YES;
        
    }else if (action==@selector(resendItemClicked:)){
        
        return YES;
        
    }
    
    return [super canPerformAction:action withSender:sender];
    
}

#pragma mark 实现成为第一响应者方法
//告诉控制器能成为第一响应者
-(BOOL)canBecomeFirstResponder{
    
    return YES;
    
}

#pragma mark method

-(void)resendItemClicked:(id)sender{
    
    NSLog(@"转发");
    
    //通知代理
    
}

-(void)copyItemClicked:(id)sender{
    
    NSLog(@"复制");
    
    // 通知代理
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:[self.menuLabel text]];
    NSLog(@"-复制--->>%@",pasteboard.string);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
