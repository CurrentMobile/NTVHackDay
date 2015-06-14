//
//  MXLEventBriteVenue.h
//  MXLFrameworkDemo
//
//  Created by Anthony Hoang on 5/4/15.
//  Copyright (c) 2015 MobileX Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class MXLEventBriteVenueBuilder;

/**
 *  This is a data model that represent a venue in the EventBrite service.
 */
@interface MXLEventBriteVenue : NSObject

/**
 *  The unique identifier of the venue.
 */
@property (nonatomic, strong, readonly) NSString *venueId;

/**
 *  The name of the venue.
 */
@property (nonatomic, strong, readonly) NSString *name;

/**
 *  The street address of the venue.
 */
@property (nonatomic, strong, readonly) NSString *address1;

/**
 *  The 2nd street address of the venue.
 */
@property (nonatomic, strong, readonly) NSString *address2;

/**
 *  The city of the venue.
 */
@property (nonatomic, strong, readonly) NSString *city;

/**
 *  The postal code of the venue.
 */
@property (nonatomic, strong, readonly) NSString *postalCode;

/**
 *  The country of the venue.
 */
@property (nonatomic, strong, readonly) NSString *country;

/**
 *  The longitude and latitude of the venue.
 */
@property (nonatomic, assign, readonly) CLLocationCoordinate2D location;

/**
 *  Use this class method to create a new instance of MXLEventBriteVenue.
 *
 *  @param builderBlock The builder block. Use the builder to build the MXLEventBriteVenue by setting the builder's properties.
 *
 *  @return The new MXLEventBriteVenue whose properties are set to the builder's properties.
 */
+ (instancetype)venueWithBuilderBlock:(void(^)(MXLEventBriteVenueBuilder *builder))builderBlock;

@end

/**
 *  This is a builder class used to build instances of MXLEventBriteVenue.
 */
@interface MXLEventBriteVenueBuilder : NSObject

@property (nonatomic, strong) NSString *venueId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address1;
@property (nonatomic, strong) NSString *address2;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *postalCode;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, assign) CLLocationCoordinate2D location;

/**
 *  Builds a new MXLEventBriteVenue whose properties are set to the builder's properties.
 *
 *  @return The new MXLEventBriteVenue.are
 */
- (MXLEventBriteVenue *)build;

@end
