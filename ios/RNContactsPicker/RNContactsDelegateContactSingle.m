//
//  RNContactsDelegateContactSingle.m
//  RNContactsPicker
//
//  Created by Harry Walter on 15/06/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "RNContactsDelegateContactSingle.h"
#import "RNContactsUtil.h"

@implementation RNContactsDelegateContactSingle

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact
{
    NSDictionary *dict = [RNContactsUtil convertContactToDictionary:contact];
    self._resolver(dict);
}

@end
