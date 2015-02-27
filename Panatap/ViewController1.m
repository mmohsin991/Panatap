//
//  ViewController1.m
//  Panatap
//
//  Created by Mohsin on 26/02/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

#import "ViewController1.h"
#import "Panatap-Swift.h"
#import "MobileCoreServices/MobileCoreServices.h"
#import "AVKit/AVKit.h"


@interface ViewController1 ()

@end

@implementation ViewController1


UIImagePickerController *imagePicker;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)addVideo:(id)sender {
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Select Image Source"
                                  message:nil
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    UIAlertAction*  camera = [UIAlertAction
                         actionWithTitle:@"Camera"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             if ([UIImagePickerController availableCaptureModesForCameraDevice:UIImagePickerControllerCameraDeviceRear]){
                                 
                                 //Do some thing here
                                 imagePicker = [[UIImagePickerController alloc] init];
                                 imagePicker.allowsEditing = YES;
                                 imagePicker.delegate = self;
                                 imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                 imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
                                 imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
                                 imagePicker.videoMaximumDuration = 24.0;
                                 
                                 [self presentViewController:imagePicker animated:YES completion:nil];
                             }

                             
                             
                             
                         }];
    
    UIAlertAction* Videos = [UIAlertAction
                         actionWithTitle:@"Videos"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here
                             
                             imagePicker = [[UIImagePickerController alloc] init];
                             imagePicker.allowsEditing = YES;
                             imagePicker.delegate = self;
                             imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                             imagePicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie,      nil];
                             
                             [self presentViewController:imagePicker animated:YES completion:nil];
                             
                         }];
    
    UIAlertAction* cameraRoll = [UIAlertAction
                             actionWithTitle:@"Photos"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                 imagePicker = [[UIImagePickerController alloc] init];
                                 imagePicker.allowsEditing = YES;
                                 imagePicker.delegate = self;
                                 imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                                 imagePicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeImage,      nil];
                                 
                                 [self presentViewController:imagePicker animated:YES completion:nil];
                                 
                             }];
    
    
    UIAlertAction* facebook = [UIAlertAction
                             actionWithTitle:@"Facebook"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                 
                             }];
    
    
    
    
    
    
    
    
    [alert addAction:camera];
    [alert addAction:Videos];
    [alert addAction:cameraRoll];
    [alert addAction:facebook];
    
    
}




- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        // Media is a video
        NSURL *videoUrl=(NSURL*)[info objectForKey:UIImagePickerControllerMediaURL];
        [self performSegueWithIdentifier:@"mergeVideoSeg" sender:videoUrl];
        [self dismissViewControllerAnimated:YES completion:nil ];

    }
    
    if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
        
        // if Media is an image

      //  NSURL *videoUrl=(NSURL*)[info objectForKey:UIImagePickerControllerMediaURL];
        
        UIImage *img = (UIImage*)[info objectForKey:UIImagePickerControllerOriginalImage];
     //   [self performSegueWithIdentifier:@"mergeImagesSeg" sender:img];
        
        printf("mohsin");
        [self dismissViewControllerAnimated:YES completion:nil ];
        
    }
    
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        // if video selected
        if ([segue.identifier isEqualToString:@"mergeVideoSeg"]) {

            MergeVideoVC *descVC = [segue destinationViewController];
            descVC.videoUrl = (NSURL*)sender;
        }
        // if image selected
        else if ([segue.identifier isEqualToString:@"mergeImagesSeg"]){
            
        }
}

@end
