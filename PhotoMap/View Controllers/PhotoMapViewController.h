//
//  PhotoMapViewController.h
//  PhotoMap
//
//  Created by emersonmalca on 7/8/18.
//  Copyright © 2018 Codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationsViewController.h"

@interface PhotoMapViewController : UIViewController < UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationsViewControllerDelegate>

@property (weak, nonatomic) UIImage *selectedImage;

@end
