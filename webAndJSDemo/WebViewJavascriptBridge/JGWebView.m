//
//  JGWebView.m
//  webAndJSDemo
//
//  Created by JGPeng on 16/11/11.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "JGWebView.h"


@interface JGWebView ()<UIWebViewDelegate>

@property (nonatomic,strong)NSArray * funcationArray;



@end

@implementation JGWebView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
//        self.returnBlock = returnBlock;
//        self.funcationArray = funcationArray;
        _webview=[[UIWebView alloc]initWithFrame:self.bounds];
        [self.webview setBackgroundColor:[UIColor clearColor]];
        [self.webview setOpaque:NO];
        //webview的背景色主要由该view决定
        [self addSubview:_webview];
        /** 打开日记 */
        [WebViewJavascriptBridge enableLogging];
        /**
         *  建立桥接，给代理
         */
        _bridge = [WebViewJavascriptBridge bridgeForWebView:_webview];
        [_bridge setWebViewDelegate:self];
    }
    
    return self;
}


@end
