//
//  RNContactsDelegate.h
//  RNContactsPicker
//
//  Created by Harry Walter on 15/06/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#if __has_include(<React/RCTBridgeModule.h>)
#import <React/RCTBridgeModule.h>
#else
#import "RCTBridgeModule.h"
#endif

@import ContactsUI;

@interface RNContactsDelegate : NSObject <CNContactPickerDelegate>

@property (nonatomic, strong) RCTPromiseResolveBlock _resolver;
@property (nonatomic, strong) RCTPromiseRejectBlock _rejecter;

@end
