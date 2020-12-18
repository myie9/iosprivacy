//
//  HJG_YinSi.m
//  YingSiTongYong
//
//  Created by developer on 2018/10/8.
//  Copyright © 2018 developer. All rights reserved.
//

#import "HJG_YinSi.h"
#import <UIKit/UIKit.h>

#define isFirstYinSi  @"isFirstYinSi"
@interface HJG_YinSi()

@property(nonatomic,strong)UIWindow * window;

@property (nonatomic, strong) UIView *frontView;

@property (nonatomic, strong) UIWebView *webV;

@property (nonatomic, strong) UIButton *closeBut;
@property (nonatomic, strong) UIButton *exitBut;

@end
@implementation HJG_YinSi

-(void)loadDocument:(NSString*)documentName inView:(UIWebView*)webView

{

    NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:nil];

    NSURL *url = [NSURL fileURLWithPath:path];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [webView loadRequest:request];

}

- (UIWebView *)webV
{
    if (!_webV) {
        UIWebView * theView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 70, [UIScreen mainScreen].bounds.size.width - 20, [UIScreen mainScreen].bounds.size.height - 200)];
        
        
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"privacyios" ofType:@"doc"];
//
//            NSURL *url = [NSURL fileURLWithPath:path];
//
//            NSURLRequest *request = [NSURLRequest requestWithURL:url];
//
//            [theView loadRequest:request];
        
        [self loadDocument:@"privacyios.rtf" inView:theView];


        
        
//        [theView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.myie9.com/blog/?p=559"]]];
        
        
        [self.frontView addSubview:theView];
        _webV = theView;
    }
    return _webV;
}

- (UIView *)frontView
{
    if (!_frontView) {
        UIView * theView = [[UIView alloc] init];
        theView.backgroundColor = [UIColor whiteColor];
        theView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        _frontView = theView;
    }
    return _frontView;
}

- (UIButton *)exitBut
{
    if (!_exitBut) {
        UIButton * theView = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.webV.frame)-130, CGRectGetMaxY(self.webV.frame) + 10, 100, 60)];
        [theView setTitle:@"不同意" forState:UIControlStateNormal];
        theView.layer.cornerRadius= 30;
        theView.layer.borderColor = [UIColor blackColor].CGColor;
        theView.layer.borderWidth= 2;
        theView.clipsToBounds = YES;
        [theView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [theView addTarget:self action:@selector(exitButClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        theView.backgroundColor = [UIColor whiteColor];
        _exitBut = theView;
    }
    return _exitBut;
}


- (UIColor *) colorWithHexString: (NSString *) stringToConvert{
    UIColor*   DEFAULT_VOID_COLOR=[UIColor blueColor];
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return DEFAULT_VOID_COLOR;
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return DEFAULT_VOID_COLOR;
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
            green:((float) g / 255.0f)
          blue:((float) b / 255.0f)
            alpha:1.0f];
}


- (UIButton *)closeBut
{
    if (!_closeBut) {
        UIButton * theView = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.webV.frame)+10, CGRectGetMaxY(self.webV.frame) + 10, 100, 60)];
        [theView setTitle:@"同意" forState:UIControlStateNormal];
        theView.layer.cornerRadius= 30;
        theView.layer.borderColor = [self colorWithHexString:@"#07c160"].CGColor;//[UIColor blueColor].CGColor;
        theView.layer.borderWidth= 2;
        theView.clipsToBounds = YES;
        [theView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [theView addTarget:self action:@selector(closeButClick) forControlEvents:UIControlEventTouchUpInside];
        theView.backgroundColor = [self colorWithHexString:@"#07c160"];//[UIColor whiteColor];
        _closeBut = theView;
    }
    return _closeBut;
}

- (void)closeButClick{
    
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:isFirstYinSi];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.frontView removeFromSuperview];
}


- (void)exitButClick{
    
    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

+(void)load{
    [self shareManager];
}

+(HJG_YinSi *)shareManager{
    static HJG_YinSi *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[HJG_YinSi alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        //在UIApplicationDidFinishLaunching时初始化开屏广告,做到对业务层无干扰,当然你也可以直接在AppDelegate didFinishLaunchingWithOptions方法中初始化
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:isFirstYinSi] intValue] == 1) {}else{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self setupLaunchAd];
                });
            }
        }];
    }
    return self;
}

-(void)setupLaunchAd{
    _window = [UIApplication sharedApplication].keyWindow;
    [_window addSubview:self.frontView];
    [self.frontView addSubview:self.closeBut];
    [self.frontView addSubview:self.exitBut];
    [self webV];
}


@end
