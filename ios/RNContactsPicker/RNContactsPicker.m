//
//  RNContactsPicker.h
//  RNContactsPicker
//
//  Created by Harry Walter on 29/05/2018.
//  Copyright © 2018 Blue Bamboo Studios Limited. All rights reserved.
//

@import Foundation;
#import "RNContactsPicker.h"

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

@end
  
