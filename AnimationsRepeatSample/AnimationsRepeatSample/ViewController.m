//
//  ViewController.m
//  AnimationsRepeatSample
//
//  Created by Dolice on 2013/06/04.
//  Copyright (c) 2013年 Dolice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property UIImageView *star;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //背景色を黒に設定
    self.view.backgroundColor = [UIColor blackColor];
    
    //星の画像を作成
    UIImage *image = [UIImage imageNamed:@"star.png"];
    _star = [[UIImageView alloc] initWithImage:image];
    _star.center = CGPointMake(self.view.center.x, -100);
    
    //星の画像を画面に追加
    [self.view addSubview:_star];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //画面表示と同時にアニメーションを開始する
    [self startAnimation];
}

- (void)startAnimation
{
    //星がはじめにある位置
    _star.center = CGPointMake(self.view.center.x, -100);
    
    //transform初期化
    _star.transform = CGAffineTransformIdentity;
    
    //アニメーションの定義開始
    [UIView beginAnimations:nil context:NULL];
    
    //デリゲートを自分自身に設定
    [UIView setAnimationDelegate:self];
    
    //アニメーションが停止した時のセレクタ指定
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    //1回のアニメーションを2.0秒に設定する
    [UIView setAnimationDuration:2.0];
    
    //アニメーションのイージング指定
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    //星の画像の目標値
    _star.center = CGPointMake(self.view.center.x, 300);
    CGAffineTransform transformScale = CGAffineTransformScale(CGAffineTransformIdentity, 5, 5);
    CGAffineTransform transformRotate = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
    _star.transform = CGAffineTransformConcat(transformScale, transformRotate);
    
    //アニメーション実行
    [UIView commitAnimations];
}

- (void)animationDidStop:(NSString *)animationID
                finished:(NSNumber *)finished
                 context:(void *)context
{
    //アニメーションがキャンセルされずに完了した場合リピートする
    if ([finished boolValue]) {
        [self startAnimation];
    } 
}

@end
