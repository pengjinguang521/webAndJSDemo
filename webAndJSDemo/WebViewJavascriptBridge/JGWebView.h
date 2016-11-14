//
//  JGWebView.h
//  webAndJSDemo
//
//  Created by JGPeng on 16/11/11.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewJavascriptBridge.h"

@interface JGWebView : UIView

/** 加载webView时候访问 */
@property (nonatomic,strong) UIWebView *webview;

@property WebViewJavascriptBridge* bridge;


/**
 *  重写初始化方法
 *
 *  @param frame
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame;


@end
