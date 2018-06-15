//
//  RNContactsUtil.m
//  RNContactsPicker
//
//  Created by Harry Walter on 15/06/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "RNContactsUtil.h"

@implementation RNContactsUtil

+ (NSDictionary *) convertContactToDictionary:(CNContact *)contact {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    NSString *givenName = contact.givenName;
    NSString *familyName = contact.familyName;
    NSString *namePrefix = contact.namePrefix;
    NSString *nameSuffix = contact.nameSuffix;
    NSString *middleName = contact.middleName;
    NSString *departmentName = contact.departmentName;
    NSString *nickname = contact.nickname;
    NSString *organizationName = contact.organizationName;
    
    [dict setObject:contact.identifier forKey:@"id"];
    
    [dict setObject:(givenName) ? givenName : @"" forKey:@"givenName"];
    [dict setObject:(familyName) ? familyName : @"" forKey:@"familyName"];
    [dict setObject:(namePrefix) ? namePrefix : @"" forKey:@"namePrefix"];
    [dict setObject:(nameSuffix) ? nameSuffix : @"" forKey:@"nameSuffix"];
    [dict setObject:(middleName) ? middleName : @"" forKey:@"middleName"];
    [dict setObject:(departmentName) ? departmentName : @"" forKey:@"departmentName"];
    [dict setObject:(nickname) ? nickname : @"" forKey:@"nickname"];
    [dict setObject:(organizationName) ? organizationName : @"" forKey:@"organizationName"];
    
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
    
    NSMutableArray *emailAddresses = [[NSMutableArray alloc] init];
    
    for (CNLabeledValue<NSString*> *labeledValue in contact.emailAddresses) {
        NSString *value = [labeledValue value];
        
        if (value) {
            [emailAddresses addObject:value];
        }
    }
    
    [dict setObject:emailAddresses forKey:@"emailAddresses"];
    
    NSMutableArray *postalAddresses = [[NSMutableArray alloc] init];
    
    for (CNLabeledValue<CNPostalAddress*> *labeledValue in contact.postalAddresses) {
        NSString *label = [CNLabeledValue localizedStringForLabel:[labeledValue label]];
        CNPostalAddress *value = [labeledValue value];
        
        if (!label) {
            label = [CNLabeledValue localizedStringForLabel:@"other"];
        }
        
        if (value) {
            NSDictionary *address = [NSDictionary dictionaryWithObjectsAndKeys:value.street, @"street",
                                     value.city, @"city",
                                     value.state, @"state",
                                     value.postalCode, @"postalCode",
                                     value.country, @"country",
                                     value.ISOCountryCode, @"ISOCountryCode",
                                     nil];
            
            NSDictionary *postalAddress = [NSDictionary dictionaryWithObjectsAndKeys:label, @"label", address, @"value", nil];
            [postalAddresses addObject:postalAddress];
        }
    }
    
    [dict setObject:postalAddresses forKey:@"postalAddresses"];
    
    NSMutableArray *urlAddresses = [[NSMutableArray alloc] init];
    
    for (CNLabeledValue<NSString*> *labeledValue in contact.urlAddresses) {
        NSString *label = [CNLabeledValue localizedStringForLabel:[labeledValue label]];
        NSString *value = [labeledValue value];
        
        if (!label) {
            label = [CNLabeledValue localizedStringForLabel:@"other"];
        }
        
        if (value) {
            NSDictionary *address = [NSDictionary dictionaryWithObjectsAndKeys:label, @"label", value, @"value", nil];
            [urlAddresses addObject:address];
        }
    }
    
    [dict setObject:urlAddresses forKey:@"urlAddresses"];
    
    return dict;
}

+ (NSDictionary *) convertPropertyToDictionary:(CNContactProperty *)contactProperty; {
    NSString *label = [CNLabeledValue localizedStringForLabel:[contactProperty label]];
    id value;
    
    if ([[contactProperty value] respondsToSelector:@selector(stringValue)]) {
        value = [[contactProperty value] stringValue];
    } else if ([[contactProperty value] isKindOfClass:[CNPostalAddress class]]) {
        CNPostalAddress *address = [contactProperty value];
        
        value = [NSDictionary dictionaryWithObjectsAndKeys:address.street, @"street",
                 address.city, @"city",
                 address.state, @"state",
                 address.postalCode, @"postalCode",
                 address.country, @"country",
                 address.ISOCountryCode, @"ISOCountryCode",
                 nil];
    } else {
        value = [contactProperty value];
    }
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:label, @"label", value, @"value", nil];
    
    return dict;
}

@end
