//
//  RecordSoundsViewController.swift
//  Pitch Perfect ver 2
//
//  Created by Charles Lim on 4/19/15.
//  Copyright (c) 2015 Edupolis. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder:AVAudioRecorder!
    
    var recordedAudio:RecordedAudio!
    
    @IBOutlet weak var recordLabel: UILabel!
    
    @IBOutlet weak var stopLabel: UIButton!
    
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        stopLabel.hidden = true
        recordButton.enabled = true
        recordLabel.text="Tap to Record"
    }
    
    @IBAction func recordButton(sender: UIButton) {
        recordLabel.text="Recording in progress ..."
        stopLabel.hidden = false
        recordButton.enabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate=self
        audioRecorder.meteringEnabled = true
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag){
          recordedAudio = RecordedAudio( filePath: recorder.url, titlePath: recorder.url.lastPathComponent!)
            if recordedAudio.filePathUrl != nil{
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
            }
        } else {
            stopLabel.hidden = true
            recordButton.enabled = true
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier=="stopRecording"){
            let playSoundsVC:PlaySoundsViewController=segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    @IBAction func stopButton(sender: UIButton) {
        stopLabel.hidden = true
        recordButton.enabled = true
        recordLabel.text="Tap to Record"
        audioRecorder.stop()
    }
    
    
}