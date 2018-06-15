//
//  RNContactsUtil.h
//  RNContactsPicker
//
//  Created by Harry Walter on 15/06/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@import Contacts;

@interface RNContactsUtil : NSObject

+ (NSDictionary *) convertContactToDictionary:(CNContact *)contact;
+ (NSDictionary *) convertPropertyToDictionary:(CNContactProperty *)contactProperty;

@end
