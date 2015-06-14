//
//  MXLEventBriteVenue.m
//  MXLFrameworkDemo
//
//  Created by Anthony Hoang on 5/4/15.
//  Copyright (c) 2015 MobileX Labs. All rights reserved.
//

#import "MXLEventBriteVenue.h"

@interface MXLEventBriteVenue ()

#pragma mark - Writable property redeclarations
@property (nonatomic, strong) NSString *venueId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address1;
@property (nonatomic, strong) NSString *address2;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *postalCode;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, assign) CLLocationCoordinate2D location;

@end

@implementation MXLEventBriteVenue

+ (instancetype)venueWithBuilderBlock:(void (^)(MXLEventBriteVenueBuilder *))builderBlock {
    MXLEventBriteVenueBuilder *builder = [MXLEventBriteVenueBuilder new];
    
    if (builderBlock) {
        builderBlock(builder);
    }
    
    return [builder build];
}

- (instancetype)initWithBuilder:(MXLEventBriteVenueBuilder *)builder {
    self = [super self];
    
    if (self) {
        self.venueId = builder.venueId;
        self.name = builder.name;
        self.address1 = builder.address1;
        self.address2 = builder.address2;
        self.city = builder.city;
        self.postalCode = builder.postalCode;
        self.country = builder.country;
        self.location = builder.location;
    }
    
    return self;
}

@end

@implementation MXLEventBriteVenueBuilder

- (MXLEventBriteVenue *)build {
    return [[MXLEventBriteVenue alloc] initWithBuilder:self];
}

@end
