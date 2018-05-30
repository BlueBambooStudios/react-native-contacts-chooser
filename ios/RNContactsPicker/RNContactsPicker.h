//
//  RNContactsPicker.h
//  RNContactsPicker
//
//  Created by Harry Walter on 29/05/2018.
//  Copyright © 2018 Blue Bamboo Studios Limited. All rights reserved.
//

#if __has_include(<React/RCTBridgeModule.h>)
#import <React/RCTBridgeModule.h>
#else
#import "RCTBridgeModule.h"
#endif

@import Contacts;
@import ContactsUI;

@interface RNContactsPicker : NSObject <RCTBridgeModule, CNContactPickerDelegate>

@end
  
