//
//  HLHJPrivacyAgreementSdk.h
//  HLHJPrivacyAgreementFramework
//
//  Created by YuDong on 2020/10/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HLHJPrivacyAgreementSdk : NSObject

/**
 * 初始化sdk(此步骤需在application:didFinishLaunchingWithOptions中调用)
 */
+ (void)startSDKWithAppKey:(nonnull NSString *)AppKey;

@end

NS_ASSUME_NONNULL_END
