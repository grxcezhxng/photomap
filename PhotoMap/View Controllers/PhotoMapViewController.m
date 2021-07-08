//
//  PhotoMapViewController.m
//  PhotoMap
//
//  Created by emersonmalca on 7/8/18.
//  Copyright © 2018 Codepath. All rights reserved.
//

#import "PhotoMapViewController.h"
#import "LocationsViewController.h"
#import "PhotoAnnotation.h"
#import <MapKit/MapKit.h>

@interface PhotoMapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation PhotoMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MKCoordinateRegion sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:sfRegion animated:false];
    self.mapView.delegate = self;
}

- (IBAction)handleCamera:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
       imagePickerVC.delegate = self;
       imagePickerVC.allowsEditing = YES;

       // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
       if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
           imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
       }
       else {
           NSLog(@"Camera 🚫 available so we will use photo library instead");
           imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
       }

       [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    self.selectedImage = editedImage;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
    [self performSegueWithIdentifier:@"tagSegue" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if([segue.identifier isEqualToString:@"tagSegue"]) {
        LocationsViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }
}

- (void)locationsViewController:(LocationsViewController *)controller didPickLocationWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude {
    [self.navigationController popViewControllerAnimated:YES];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude.floatValue, longitude.floatValue);
    
//    MKPointAnnotation *annotation = [MKPointAnnotation new];
//    annotation.coordinate = coordinate;
//    annotation.title = @"Picture!";
//    [self.mapView addAnnotation:annotation];
    
    PhotoAnnotation *point = [[PhotoAnnotation alloc] init];
        point.coordinate = coordinate;
        point.photo = [self resizeImage:self.selectedImage withSize:CGSizeMake(50.0, 50.0)];
        [self.mapView addAnnotation:point];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];

    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;

    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
     MKAnnotationView *annotationView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    
    if (annotationView == nil) {
        //Makes a pin
          annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
        //Allows for the pop-up
          annotationView.canShowCallout = true;
        //Creates the imageview
          annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
          annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
          }

          UIImageView *imageView = (UIImageView*)annotationView.leftCalloutAccessoryView;
   // UIButton *button = (UIButton *) annotationView.rightCalloutAccessoryView;
//           imageView.image = [UIImage imageNamed:@"camera-icon"]; // remove this line

          // add these two lines below
          PhotoAnnotation *photoAnnotationItem = annotation; // refer to this generic annotation as our more specific PhotoAnnotation
          imageView.image = photoAnnotationItem.photo; // set the image into the callout imageview

          return annotationView;

 }

@end
