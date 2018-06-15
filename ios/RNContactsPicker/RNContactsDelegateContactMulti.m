//
//  RNContactsDelegateContactMulti.m
//  RNContactsPicker
//
//  Created by Harry Walter on 15/06/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "RNContactsDelegateContactMulti.h"
#import "RNContactsUtil.h"

@implementation RNContactsDelegateContactMulti

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact *> *)contacts {
    NSMutableArray *contactDicts = [[NSMutableArray alloc] init];
    
    for (CNContact *contact in contacts) {
        NSDictionary *dict = [RNContactsUtil convertContactToDictionary:contact];
        [contactDicts addObject:dict];
    }
    
    self._resolver(contactDicts);
}

@end
