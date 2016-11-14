//
//  JGWebView1.h
//  webAndJSDemo
//
//  Created by JGPeng on 16/11/11.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  定义webview掉用oc的回调
 *
 *  @param js的方法名称 返回内容
 */
typedef void (^ReturnBlock)(NSString * funcationName ,id obj);


@interface JGWebView1 : UIView
/** 加载webView时候访问 */
@property (nonatomic,strong) UIWebView *webview;

/**
 *  初始化jsweb页面
 *
 *  @param frame
 *  @param funcationArray 方法名称数组,没有方法传入@[].不要传nil
 *  @param returnBlock    js掉用oc
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame
               FuncationArray:(NSArray *)funcationArray
                  ReturnBlock:(ReturnBlock)returnBlock;


/**
 *  OC掉用js
 *
 *  @param content 掉用内容
 */
- (NSString *)IOS_OC_JS:(NSString *)content;

@end
