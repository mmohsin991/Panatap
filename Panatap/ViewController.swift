//
//  ViewController.swift
//  Panatap
//
//  Created by Mohsin on 26/02/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVKit


class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    
    let videoPicker = UIImagePickerController()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        videoPicker.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    

    @IBAction func click(sender: AnyObject) {
        let alert = UIAlertController(title: "Select Image Source", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        let camera = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                
                self.videoPicker.allowsEditing = true
                self.videoPicker.sourceType = UIImagePickerControllerSourceType.Camera
                self.videoPicker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.Camera)!
                //self.videoPicker.mediaTypes = [kUTTypeMovie as NSString]
                self.videoPicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.Video
                self.videoPicker.videoMaximumDuration = 24.0
                
                self.presentViewController(self.videoPicker, animated: true, completion: nil)
                
            }
        }
        
        
        let video = UIAlertAction(title: "Videos", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
         
            // show the alert for the video duration
            self.videoPicker.allowsEditing = true
            self.videoPicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
            //videoPicker.modalPresentationStyle = UIModalPresentationStyle.FullScreen
            self.videoPicker.mediaTypes = [kUTTypeMovie as NSString]
            self.presentViewController(self.videoPicker, animated: true, completion: nil)
        }
        
        
        let cameraRoll = UIAlertAction(title: "Photos", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in

            
        }
        
        
        let facebook  = UIAlertAction(title: "Facebook", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            
        }
        
        
        alert.addAction(camera)
        alert.addAction(video)
        alert.addAction(cameraRoll)
        alert.addAction(facebook)
        
        
        presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    
    //What to do when the picker returns with a video
    func imagePickerController(videoPicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as NSString
        
        if mediaType.isEqualToString(kUTTypeImage as NSString) {
            // if Media is an image
            println("image selected")
            var chosenImage = info[UIImagePickerControllerOriginalImage] as UIImage
            
            dismissViewControllerAnimated(true, completion: nil)
        }
            
        else if mediaType.isEqualToString(kUTTypeMovie as NSString) {
            
            // Media is a video
            let videoUrl = info[UIImagePickerControllerMediaURL] as NSURL
            performSegueWithIdentifier("mergeVideoSeg", sender: videoUrl)
            dismissViewControllerAnimated(true, completion: nil)
            
        }
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mergeVideoSeg" {
            let mergeVideoVC = segue.destinationViewController as MergeVideoVC
            mergeVideoVC.videoUrl = sender as NSURL
        }
        
    }

}

