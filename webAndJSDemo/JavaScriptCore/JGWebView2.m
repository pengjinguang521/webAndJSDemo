//
//  JGWebView2.m
//  webAndJSDemo
//
//  Created by JGPeng on 16/11/11.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "JGWebView2.h"
#import <JavaScriptCore/JavaScriptCore.h>

#pragma mark - 苹果官方的web交互oc的js方法

@interface JGWebView2 ()<UIWebViewDelegate>

@property (nonatomic,strong)ReturnBlock returnBlock;

@property (nonatomic,strong)NSArray * funcationArray;

@end

@implementation JGWebView2

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

#pragma -mark  --WebViewDelegate
//加载之前调用
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
//开始加载调用
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
//加载完成调用
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    for (int i = 0; i < self.funcationArray.count; i ++) {
        context[self.funcationArray[i]] = ^(){
        NSArray *args = [JSContext currentArguments];
            if (self.returnBlock) {
                self.returnBlock(self.funcationArray[i] ,args);
            }
        };
    }
}
/** OC掉用js*/
- (NSString *)IOS_OC_JS:(NSString *)content{
   return  [self.webview stringByEvaluatingJavaScriptFromString:content];
}


@end
