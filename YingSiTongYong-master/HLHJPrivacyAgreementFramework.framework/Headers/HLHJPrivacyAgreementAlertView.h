//
//  HLHJPrivacyAgreementAlertView.h
//  HLHJPrivacyAgreementFramework
//
//  Created by YuDong on 2020/10/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HLHJPrivacyAgreementAlertView : UIView

/**
 * 显示弹框
 * 注意显示弹框代码必须添加在ViewDidLoad初始化UI最后
 *
 * @param view  弹框的父视图
*/
- (void)showInView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
