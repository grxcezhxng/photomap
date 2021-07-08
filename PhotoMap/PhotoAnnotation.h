//
//  PhotoAnnotation.h
//  PhotoMap
//
//  Created by gracezhg on 7/8/21.
//  Copyright © 2021 Codepath. All rights reserved.
//

#ifndef PhotoAnnotation_h
#define PhotoAnnotation_h

#import <Foundation/Foundation.h>
@import MapKit;

NS_ASSUME_NONNULL_BEGIN

@interface PhotoAnnotation : NSObject <MKAnnotation>

@property (strong, nonatomic) UIImage *photo;

@end

NS_ASSUME_NONNULL_END

#endif /* PhotoAnnotation_h */

