//
//  RNContactsDelegate.m
//  RNContactsPicker
//
//  Created by Harry Walter on 15/06/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "RNContactsDelegate.h"

@implementation RNContactsDelegate

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker
{
    self._rejecter(@"E_PICKER_CANCELLED", @"Cancelled", nil);
}

@end
