//
//  ViewController.m
//  webAndJSDemo
//
//  Created by JGPeng on 16/11/11.
//  Copyright © 2016年 彭金光. All rights reserved.
//http://www.huangyibiao.com/archives/670  参考网址

#import "ViewController.h"
#import "JGWebView1.h"
#import "JGWebView2.h"
#import "JGWebView.h"


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    /** WebViewJavascriptBridge框架方法 */
    [self webViewTest];
    /** 拦截url处理的方法 */
    [self webView1Test];
    /** 拦截url处理的方法 */
    [self webView2Test];
}


/** WebViewJavascriptBridge框架方法 */
- (void)webViewTest{

    JGWebView * web = [[JGWebView alloc]initWithFrame:self.view.bounds];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSURL *localUrl = [[NSURL alloc] initFileURLWithPath:htmlPath];
    [web.webview loadRequest:[NSURLRequest requestWithURL:localUrl]];
    [self.view addSubview:web];
    
    
    /***********************************************************************/
    /******这边regist是js掉起oc方法，call是oc掉起js方法，在html的代码中刚好相反*****/
    /***********************************************************************/
    
    /** JS掉起oc方法 */
    [web.bridge registerHandler:@"getBlogNameFromObjC" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"%@_____data",data);
        
        if (responseCallback) {
            responseCallback(@{@"blogName": @"标哥的技术博客"});
        }
    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        /** OC掉起js方法 */
        [web.bridge callHandler:@"getUserInfos" data:@{@"name": @"标哥"} responseCallback:^(id responseData) {
            NSLog(@"from js: %@", responseData);
        }];
        
    });

}

/** 拦截url处理的方法 */
- (void)webView1Test{
    
    /** JS方法的掉用，js掉起oc的方法，点击按钮 */
    JGWebView1 * web = [[JGWebView1 alloc]initWithFrame:self.view.bounds FuncationArray:@[@"locationClick",@"shareClick"] ReturnBlock:^(NSString *funcationName, id obj) {
        if ([funcationName isEqualToString:@"shareClick"]) {
            NSLog(@"%@",obj);
        }
        if ([funcationName isEqualToString:@"locationClick"]) {
            NSLog(@"%@",obj);
        }
    }];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index1" ofType:@"html"];
    NSURL *localUrl = [[NSURL alloc] initFileURLWithPath:htmlPath];
    [web.webview loadRequest:[NSURLRequest requestWithURL:localUrl]];
    [self.view addSubview:web];
    
    
    /** JS方法的掉用，没有返回值，这边是向js传入数据 */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%@",[web IOS_OC_JS:[NSString stringWithFormat:@"setLocation(%@);",@"123"]]);
    });
    
    
    
}

/** 苹果ios7.0以后提供的方法 */
- (void)webView2Test{
    
    /** JS方法的掉用，js掉起oc的方法，点击按钮 */
    JGWebView2 * web = [[JGWebView2 alloc]initWithFrame:self.view.bounds FuncationArray:@[@"textlog"] ReturnBlock:^(NSString *funcationName, id obj) {
        if ([funcationName isEqualToString:@"textlog"]) {
            NSLog(@"%@",obj);
        }
    }];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *localUrl = [[NSURL alloc] initFileURLWithPath:htmlPath];
    [web.webview loadRequest:[NSURLRequest requestWithURL:localUrl]];
    [self.view addSubview:web];
    
    /** JS方法的掉用，有返回值，这边是从js获取数据，注意返回类型string */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%@",[web IOS_OC_JS:@"postStr();"]);
        
    });
    /** JS方法的掉用，没有返回值，这边是向js传入数据 */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%@",[web IOS_OC_JS:[NSString stringWithFormat:@"postValue(%@);",@"123"]]);
    });
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
