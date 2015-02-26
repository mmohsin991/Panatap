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
    
    
    @IBOutlet weak var btnPreview: UIButton!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // temp remove it
        videoUrl = NSURL(string: "dsa")

        
        self.btnHumTapOnly.titleLabel?.numberOfLines = 2
        self.btnHumTapOnly.titleLabel?.textAlignment = NSTextAlignment.Center
        self.btnHumTapOnly.titleLabel?.font = UIFont.systemFontOfSize(14.0)
        
        let image = UIImage(named: "music").imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        image.drawInRect( CGRect(x: 0.0, y: 0.0, width: 50, height: 50))
        
        self.btnHumTapOnly.setImage(image, forState: UIControlState.Normal)
        
        self.btnHumTapOnly.tintColor = UIColor.whiteColor()
        
        
//        self.btnHumTapOnly.imageView?.frame = CGRect(x: 0.0, y: 0.0, width: 50, height: 50)
        
        
        self.btnSoundMusic.titleLabel?.numberOfLines = 2
        self.btnSoundMusic.titleLabel?.textAlignment = NSTextAlignment.Center
        self.btnSoundMusic.titleLabel?.font = UIFont.systemFontOfSize(14.0)

        
        self.activityView.stopAnimating()
        
        if Visualization.getDuratonInSec(self.videoUrl) > 24.0 {
            showVideoDurationAlert("Your selected video's length is grater then 24sec it will trim upto 24sec automatically", okCallBack: { () -> Void in
                
            })
        }
        
        self.humtapUrl = NSBundle.mainBundle().URLForResource("humtap", withExtension: ".mp3")
        
        
        // set thumb img of video
        self.thumbImg.image = Visualization.getThumbnailOfVide(self.videoUrl)
        
        // Do any additional setup after loading the view.
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
            self.btnHumTapOnly.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)

            self.btnSoundMusic.backgroundColor = UIColor.groupTableViewBackgroundColor()
            self.btnSoundMusic.setTitleColor(HTBlueColor, forState: UIControlState.Normal)
        }
    // Sound And Music
        else if sender.tag == 1 {
            self.preserveAudio = true
            
            self.btnSoundMusic.backgroundColor = HTBlueColor
            self.btnSoundMusic.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            
            
            self.btnHumTapOnly.backgroundColor = UIColor.groupTableViewBackgroundColor()
            self.btnHumTapOnly.setTitleColor(HTBlueColor, forState: UIControlState.Normal)
            
        }
    }


}


class HTPreserveAudioView : UIView {
    
        @IBOutlet weak var thumbImg: UIImageView!
    
}
