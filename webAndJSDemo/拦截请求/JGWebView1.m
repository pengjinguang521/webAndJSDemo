//
//  JGWebView1.m
//  webAndJSDemo
//
//  Created by JGPeng on 16/11/11.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "JGWebView1.h"

@interface JGWebView1 ()<UIWebViewDelegate>

@property (nonatomic,strong)ReturnBlock returnBlock;

@property (nonatomic,strong)NSArray * funcationArray;

@end

@implementation JGWebView1

- (instancetype)initWithFrame:(CGRect)frame FuncationArray:(NSArray *)funcationArray ReturnBlock:(ReturnBlock)returnBlock{
    
    if (self = [super initWithFrame:frame]) {
        self.returnBlock = returnBlock;
        self.funcationArray = funcationArray;
        _webview=[[UIWebView alloc]initWithFrame:self.bounds];
        [self.webview setBackgroundColor:[UIColor clearColor]];
        [self.webview setOpaque:NO];
        //webview的背景色主要由该view决定
        _webview.delegate = self;
        [self addSubview:_webview];
    }
    return self;
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSURL *URL = request.URL;
    NSString *scheme = [URL scheme];
    if ([scheme isEqualToString:@"haleyaction"]) {
        [self handleCustomAction:URL];
        return NO;
    }
    return YES;
}

#pragma mark - private method
- (void)handleCustomAction:(NSURL *)URL{
    NSString *host = [URL host];
    for (int i = 0; i < self.funcationArray.count; i ++) {
        if ([host isEqualToString:self.funcationArray[i]]) {
            if (self.returnBlock) {
                self.returnBlock(self.funcationArray[i],URL);
            }
        }
    }
}

/**
 *  OC掉用js
 *
 *  @param content 掉用内容
 */
/** OC掉用js*/
- (NSString *)IOS_OC_JS:(NSString *)content{
    return  [self.webview stringByEvaluatingJavaScriptFromString:content];
}


@end
