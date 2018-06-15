//
//  RNContactsPropertySingle.m
//  RNContactsPicker
//
//  Created by Harry Walter on 15/06/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "RNContactsDelegatePropertySingle.h"
#import "RNContactsUtil.h"

@implementation RNContactsDelegatePropertySingle

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    NSDictionary *dict = [RNContactsUtil convertPropertyToDictionary:contactProperty];
    self._resolver(dict);
}

@end
