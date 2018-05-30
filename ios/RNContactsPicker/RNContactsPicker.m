//
//  RNContactsPicker.h
//  RNContactsPicker
//
//  Created by Harry Walter on 29/05/2018.
//  Copyright © 2018 Blue Bamboo Studios Limited. All rights reserved.
//

#import "RNContactsPicker.h"

typedef NS_ENUM(NSUInteger, PickerMode) {
    PickerModeContact,
    PickerModeProperty,
    PickerModeContactMulti,
    PickerModePropertyMulti
};

@interface RNContactsPicker()

@property (nonatomic, strong) RCTPromiseResolveBlock _resolver;
@property (nonatomic, strong) RCTPromiseRejectBlock _rejecter;

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
    self._resolver = resolve;
    self._rejecter = reject;
    
    [self showContactPicker:PickerModeContact];
}

- (void)showContactPicker:(enum PickerMode)mode {
    CNContactPickerViewController *picker = [[CNContactPickerViewController alloc] init];
    picker.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    picker.delegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *root = [UIApplication sharedApplication].delegate.window.rootViewController;
        [root presentViewController:picker animated:YES completion:nil];
    });
}

- (NSDictionary *) convertContactToDictionary:(CNContact *)contact {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    NSString *givenName = contact.givenName;
    NSString *familyName = contact.familyName;
    
    [dict setObject:contact.identifier forKey:@"id"];
    
    [dict setObject:(givenName) ? givenName : @"" forKey:@"givenName"];
    [dict setObject:(familyName) ? familyName : @"" forKey:@"familyName"];
    
    // Phone Numbers
    NSMutableArray *phoneNumbers = [[NSMutableArray alloc] init];
    
    for (CNLabeledValue<CNPhoneNumber*> *labeledValue in contact.phoneNumbers) {
        NSString *label = [CNLabeledValue localizedStringForLabel:[labeledValue label]];
        NSString *value = [[labeledValue value] stringValue];
        
        if (!label) {
            label = [CNLabeledValue localizedStringForLabel:@"other"];
        }
        
        if (value) {
            NSDictionary *number = [NSDictionary dictionaryWithObjectsAndKeys:label, @"label", value, @"value", nil];
            [phoneNumbers addObject:number];
        }
    }
    
    [dict setObject:phoneNumbers forKey:@"phoneNumbers"];
    
    return dict;
}

# pragma mark CNContactPickerDelegate

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact
{
    NSDictionary *dict = [self convertContactToDictionary:contact];
    self._resolver(dict);
}

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker
{
    self._rejecter(@"E_PICKER_CANCELLED", @"Cancelled", nil);
}

@end
  
