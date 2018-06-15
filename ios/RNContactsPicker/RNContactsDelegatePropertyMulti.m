//
//  RNContactsPropertyMulti.m
//  RNContactsPicker
//
//  Created by Harry Walter on 15/06/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "RNContactsDelegatePropertyMulti.h"
#import "RNContactsUtil.h"

@implementation RNContactsDelegatePropertyMulti

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperties:(NSArray<CNContactProperty *> *)contactProperties {
    NSMutableArray *propertyDicts = [[NSMutableArray alloc] init];
    
    for (CNContactProperty *contactProperty in contactProperties) {
        NSDictionary *dict = [RNContactsUtil convertPropertyToDictionary:contactProperty];
        [propertyDicts addObject:dict];
    }
    
    self._resolver(propertyDicts);
}

@end
