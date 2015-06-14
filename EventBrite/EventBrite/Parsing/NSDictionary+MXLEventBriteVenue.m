//
//  NSDictionary+MXLEventBriteVenue.m
//  MXLFrameworkDemo
//
//  Created by Anthony Hoang on 5/5/15.
//  Copyright (c) 2015 MobileX Labs. All rights reserved.
//

#import "NSDictionary+MXLEventBriteVenue.h"

static NSString * const kAddressInfoKey = @"address";
static NSString * const kAddress1Key = @"address_1";
static NSString * const kAddress2Key = @"address_2";
static NSString * const kCityKey = @"city";
static NSString * const kCountryKey = @"country";
static NSString * const kLatitudeKey = @"latitude";
static NSString * const kLongitudeKey = @"longitude";
static NSString * const kPostalCodeKey = @"postal_code";
static NSString * const kIdKey = @"id";
static NSString * const kNameKey = @"name";

@implementation NSDictionary (MXLEventBriteVenue)

- (MXLEventBriteVenue *)eb_parseVenue {
    MXLEventBriteVenue *venue = [MXLEventBriteVenue venueWithBuilderBlock:^(MXLEventBriteVenueBuilder *builder) {
        builder.address1 = self[kAddressInfoKey][kAddress1Key];
        builder.address2 = self[kAddressInfoKey][kAddress2Key];
        builder.city = self[kAddressInfoKey][kCityKey];
        builder.country = self[kAddressInfoKey][kCountryKey];
        builder.postalCode = self[kAddressInfoKey][kPostalCodeKey];
        builder.location = CLLocationCoordinate2DMake([self[kLatitudeKey] floatValue], [self[kLongitudeKey] floatValue]);
        builder.venueId = self[kIdKey];
        builder.name = self[kNameKey];
        
    }];
    
    return venue;
}

@end

@implementation NSNull (MXLEventBriteVenue)

- (MXLEventBriteVenue *)eb_parseVenue {
    return nil;
}

@end
