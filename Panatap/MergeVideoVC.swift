//
//  MergeVideoVC.swift
//  Panatap
//
//  Created by Mohsin on 26/02/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MergeVideoVC: UIViewController {
    
    
    var humtapUrl: NSURL!
    var videoUrl: NSURL!
    var outputVideoUrl : NSURL!
    var isOutpuVideoPreserveAudio : Bool!
    
    // store the state of preserve real audio of video
    var preserveAudio = false
    
    @IBOutlet weak var thumbImg: UIImageView!

    @IBOutlet weak var btnHumTapOnly: UIButton!
    @IBOutlet weak var btnSoundMusic: UIButton!
    @IBOutlet weak var lblOR: UILabel!
    
    @IBOutlet weak var btnPreview: UIButton!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // temp remove it
        //videoUrl = NSURL(string: "dsa")

        
        self.btnHumTapOnly.titleLabel?.numberOfLines = 2
        self.btnHumTapOnly.titleLabel?.textAlignment = NSTextAlignment.Center
        self.btnHumTapOnly.titleLabel?.font = UIFont.systemFontOfSize(12.0)
        self.btnHumTapOnly.setImage(UIImage(named: "music").imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: UIControlState.Normal)
        self.btnHumTapOnly.tintColor = UIColor.whiteColor()
        self.btnHumTapOnly.layer.borderColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.3).CGColor
        self.btnHumTapOnly.layer.borderWidth = 1.0
        self.btnHumTapOnly.layer.cornerRadius = 2.0
        
        
        // set image and title inset
        let width = self.btnHumTapOnly.frame.size.width
        self.btnHumTapOnly.titleEdgeInsets = UIEdgeInsetsMake(0.0, -(width/1.125), width/18.0, width/9.0)
        self.btnHumTapOnly.imageEdgeInsets = UIEdgeInsetsMake(width/9.0,width/3.6 , width/2.25, width/3.6 )

        
        
        self.btnSoundMusic.titleLabel?.numberOfLines = 2
        self.btnSoundMusic.titleLabel?.textAlignment = NSTextAlignment.Center
        self.btnSoundMusic.titleLabel?.font = UIFont.systemFontOfSize(12.0)
        self.btnSoundMusic.setImage(UIImage(named: "HumtapMusicIcon").imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: UIControlState.Normal)
        self.btnSoundMusic.tintColor = HTBlueColor
        self.btnSoundMusic.layer.borderColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.3).CGColor
        self.btnSoundMusic.layer.borderWidth = 1.0
        self.btnSoundMusic.layer.cornerRadius = 2.0
        
        // set image and title inset
        self.btnSoundMusic.titleEdgeInsets = UIEdgeInsetsMake(0.0, -(width/1.125), width/18.0, width/9.0)
        self.btnSoundMusic.imageEdgeInsets = UIEdgeInsetsMake(width/9.0,width/9.0 , width/2.25, width/9.0)
        
        
        
        self.lblOR.layer.borderColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.5).CGColor
        self.lblOR.layer.borderWidth = 1.0
        self.lblOR.layer.cornerRadius = 2.0
        self.lblOR.layer.masksToBounds = true
        
        
        self.btnPreview.layer.cornerRadius = 4.0
        
        
        self.activityView.stopAnimating()
        
        
        
        if Visualization.getDuratonInSec(self.videoUrl) > 24.0 {
            showVideoDurationAlert("Your selected video's length is grater then 24sec it will trim upto 24sec automatically", okCallBack: { () -> Void in
                
            })
        }
        
        
        
        
        
        //self.humtapUrl = NSBundle.mainBundle().URLForResource("humtap", withExtension: ".mp3")
        self.humtapUrl = NSURL(string: "http://humtap.s3.amazonaws.com/humtaps/humtap-e820bead6ab0d01ba2a935790942cd04.mp3")
        // set thumb img of video
        self.thumbImg.image = Visualization.getThumbnailOfVide(self.videoUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func showVideoDurationAlert(message: String?,okCallBack : () -> Void){
        let alert = UIAlertController(title: "NOTE", message: "Video duration should be not greater than 24sec, if it is then it will trim upto 24sec automatically", preferredStyle: UIAlertControllerStyle.Alert)
        
        if message != nil {
            alert.message = message!
        }
        
        
        let backAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            _ in
            okCallBack()
        })
        
        alert.addAction(backAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func runAVPlayer(url: NSURL){
        let av = AVPlayerViewController()
        av.player =  AVPlayer(URL: url)
        self.presentViewController(av, animated: true, completion: nil)
    }

    @IBAction func mergeAndPreview(sender: UIButton) {
        
        // if the output video does not merge
        if outputVideoUrl == nil {
            
            if self.humtapUrl != nil && self.videoUrl != nil {
                self.activityView.startAnimating()
                
                // save the last state of audio of video
                self.isOutpuVideoPreserveAudio = self.preserveAudio
                
                Visualization.mergeAudiVideo(audioUrl: self.humtapUrl, videoUrl: self.videoUrl, outputVideName: "MyVideo", maximumVideoDuration: 24, preserveAudio: self.preserveAudio) { (outputUrl, errorDesc) -> Void in
                    
                    self.activityView.stopAnimating()
                    if outputUrl != nil {
                        self.outputVideoUrl = outputUrl
                        self.runAVPlayer(self.outputVideoUrl!)
                        
                    }
                }
            }

        }
            // if the saved video preserve audio and user change the other button of "HumTap Music Only" or wise versa
        else if self.isOutpuVideoPreserveAudio != self.preserveAudio{
            if self.humtapUrl != nil && self.videoUrl != nil {
                self.activityView.startAnimating()
                
                // save the last state of audio of video
                self.isOutpuVideoPreserveAudio = self.preserveAudio
                
                Visualization.mergeAudiVideo(audioUrl: self.humtapUrl, videoUrl: self.videoUrl, outputVideName: "MyVideo", maximumVideoDuration: 24, preserveAudio: self.preserveAudio) { (outputUrl, errorDesc) -> Void in
                    
                    self.activityView.stopAnimating()
                    if outputUrl != nil {
                        self.outputVideoUrl = outputUrl
                        self.runAVPlayer(self.outputVideoUrl!)
                        
                    }
                }
            }
            
        }
        // if the video already merge
        else {
            self.runAVPlayer(self.outputVideoUrl!)
        }

        
    }
    
    @IBAction func preserveAudio(sender: UIButton) {
     // HumTap Music Only
        if sender.tag == 0 {
            self.preserveAudio = false
            
            self.btnHumTapOnly.backgroundColor = HTBlueColor
            self.btnHumTapOnly.tintColor = UIColor.whiteColor()
            self.btnHumTapOnly.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)

            self.btnSoundMusic.backgroundColor = UIColor.groupTableViewBackgroundColor()
            self.btnSoundMusic.tintColor = HTBlueColor
            self.btnSoundMusic.setTitleColor(HTBlueColor, forState: UIControlState.Normal)
            
        }
    // Sound And Music
        else if sender.tag == 1 {
            self.preserveAudio = true
            
            self.btnSoundMusic.backgroundColor = HTBlueColor
            self.btnSoundMusic.tintColor = UIColor.whiteColor()
            self.btnSoundMusic.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            
            
            self.btnHumTapOnly.backgroundColor = UIColor.groupTableViewBackgroundColor()
            self.btnHumTapOnly.tintColor = HTBlueColor
            self.btnHumTapOnly.setTitleColor(HTBlueColor, forState: UIControlState.Normal)
            
        }
    }
    
    
    @IBAction func shareAction(sender: AnyObject) {
        let textToShare = UIImage(named: "Add")
      //  let obj = ["Action",textToShare]
        let myWebsite = NSURL(string: "http://www.google.com/")
        
        let myMusic = NSURL(string: "http://www.dailymotion.com/video/x28jmhr_michael-gregorio-you-are-so-beautiful-joe-cocker-en-live-dans-le-grand-studio-rtl_music")
        let image = self.thumbImg.image!
        let message = "Humtap video share: "
        
        let shareContent = [message, myWebsite, image]

        let activity = UIActivityViewController(activityItems: shareContent, applicationActivities: nil)
        /*activity.view.backgroundColor = UIColor.lightGrayColor()
        activity.view.layer.cornerRadius = 6*/
        activity.excludedActivityTypes = [UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,UIActivityTypePostToWeibo,UIActivityTypeMail,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypePostToTwitter, UIActivityTypeMessage]
        self.presentViewController(activity, animated: true, completion: nil)
    }
    
}
