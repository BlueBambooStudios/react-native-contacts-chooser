//
//  RNContactsPicker.h
//  RNContactsPicker
//
//  Created by Harry Walter on 29/05/2018.
//  Copyright © 2018 Blue Bamboo Studios Limited. All rights reserved.
//

#import "RNContactsPicker.h"
#import "RNContactsDelegate.h"
#import "RNContactsDelegateContactSingle.h"
#import "RNContactsDelegateContactMulti.h"
#import "RNContactsDelegatePropertySingle.h"
#import "RNContactsDelegatePropertyMulti.h"

typedef NS_ENUM(NSUInteger, PickerMode) {
    PickerModeContactSingle,
    PickerModePropertySingle,
    PickerModeContactMulti,
    PickerModePropertyMulti
};

@interface RNContactsPicker()

@property (nonatomic, strong) RNContactsDelegate<CNContactPickerDelegate> *delegate;

@end

@implementation RNContactsPicker

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE(ContactsPicker);

RCT_EXPORT_METHOD(hasAccess:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized) {
        return resolve(@YES);
    }
    
    resolve(@NO);
}

RCT_EXPORT_METHOD(requestAccess:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    CNContactStore *store = [[CNContactStore alloc] init];
    
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (error) {
            return reject([NSString stringWithFormat: @"%lu", (long)error.code], error.localizedDescription, error);
        }
        
        resolve(@(granted));
    }];
}

RCT_EXPORT_METHOD(pickContact:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    [self showContactPicker:PickerModeContactSingle resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(pickContacts:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    [self showContactPicker:PickerModeContactMulti resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(pickProperty:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    [self showContactPicker:PickerModePropertySingle resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(pickProperties:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    [self showContactPicker:PickerModePropertyMulti resolver:resolve rejecter:reject];
}

- (void)showContactPicker:(enum PickerMode)mode resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject {
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] != CNAuthorizationStatusAuthorized) {
        return reject(@"E_PERMISSION_DENIED", @"Denied", nil);
    }
    
    CNContactPickerViewController *picker = [[CNContactPickerViewController alloc] init];
    picker.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    switch (mode) {
        case PickerModeContactSingle: {
            _delegate = [[RNContactsDelegateContactSingle alloc] init];
            break;
        }
        case PickerModeContactMulti: {
            _delegate = [[RNContactsDelegateContactMulti alloc] init];
            break;
        }
        case PickerModePropertySingle: {
            _delegate = [[RNContactsDelegatePropertySingle alloc] init];
            break;
        }
        case PickerModePropertyMulti: {
            _delegate = [[RNContactsDelegatePropertyMulti alloc] init];
            break;
        }
    }
    
    _delegate._rejecter = reject;
    _delegate._resolver = resolve;
    
    picker.delegate = _delegate;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *root = [UIApplication sharedApplication].delegate.window.rootViewController;
        [root presentViewController:picker animated:YES completion:nil];
    });
}

@end
  
