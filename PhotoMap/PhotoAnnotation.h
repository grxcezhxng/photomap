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

@interface PhotoAnnotation : NSObject <MKAnnotation>

@property (strong, nonatomic) UIImage *photo;

@end

#endif /* PhotoAnnotation_h */

