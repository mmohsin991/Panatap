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
import CoreMedia

//import PUUIImageViewController




class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate {
    
    
    
    let videoPicker = UIImagePickerController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        videoPicker.delegate = self
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        videoPicker.viewControllers.count
    }
    
    
    
    
    

    @IBAction func click(sender: AnyObject) {
        let alert = UIAlertController(title: "Select Image Source", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        //let alert = HTUIAlertController(title: "Select Image Source", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        //alert.parent = self
        
        
        //alert.parent = self
        
        
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
        
        
        let video = UIAlertAction(title: "Videos and images", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
         
            // show the alert for the video duration
            self.videoPicker.allowsEditing = true
            self.videoPicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
            //videoPicker.modalPresentationStyle = UIModalPresentationStyle.FullScreen
            self.videoPicker.mediaTypes = [kUTTypeMovie as NSString , kUTTypeImage as NSString]
            //self.videoPicker.mediaTypes = [kUTTypeImage as NSString]

            self.presentViewController(self.videoPicker, animated: true, completion: nil)
        }
        
        
        let cameraRoll = UIAlertAction(title: "Photos", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in

            
        }
        
        
        let facebook  = UIAlertAction(title: "Facebook", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            
        }
        let cancel  = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (UIAlertAction) -> Void in
            
        }
        

        alert.addAction(camera)
        alert.addAction(video)
        alert.addAction(cameraRoll)
        alert.addAction(facebook)
        alert.addAction(cancel)

        
//        UIControl *aControl = (UIControl *) sender;
//        CGRect frameInView = [aControl convertRect:aControl.bounds toView:self.view];
//        alertController.popoverPresentationController.sourceRect = frameInView;
//        alertController.popoverPresentationController.sourceView = self.view;
//        alertController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;

        
        var control  = UIControl(frame: self.view.bounds)
//
//        alert.popoverPresentationController?.sourceRect = self.view.bounds
//        alert.popoverPresentationController?.sourceView = self.view
//        alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.Any

//        
//        alert.modalPresentationStyle = UIModalPresentationStyle.PageSheet
//        alert.preferredContentSize = CGSizeMake(260, 340)
//        
//        let popoverMenuViewController = alert.popoverPresentationController
//        popoverMenuViewController?.permittedArrowDirections = UIPopoverArrowDirection.allZeros
//        popoverMenuViewController?.delegate = self
//        popoverMenuViewController?.sourceView = self.view
//        
//        popoverMenuViewController?.sourceRect = CGRect(x: 200, y: 200, width: 300, height: 300)
        
        presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
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



class MyImgPicVC: UIImagePickerController {
    
    var Delegate: UIImagePickerControllerDelegate!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println(viewControllers.count)
        println(viewControllers[0])
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        super.pushViewController(viewController, animated: animated)
        
        println(viewController)
        
        //self.allowsEditing = false
        
    }
    
    
    

}
class HTUIAlertController: UIAlertController {
    
    var tapGesture = UITapGestureRecognizer()
    
    var parent: UIViewController!
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if parent != nil {
            parent.view.addGestureRecognizer(tapGesture)
            parent.view.userInteractionEnabled = true

        }
        
        //self.view.userInteractionEnabled = true
       // self.view.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(parent, action: "dismissVC")
        println(parent)
        //tapGesture.addTarget(parent, action: "dismissVC")
    }
    
    func dismissVC(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}


protocol MyPro {
    
    
    func myView(view: UIView)
    
}
