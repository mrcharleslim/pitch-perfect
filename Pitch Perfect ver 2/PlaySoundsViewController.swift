//
//  PlaySoundsViewController.swift
//  Pitch Perfect ver 2
//
//  Created by Charles Lim on 4/21/15.
//  Copyright (c) 2015 Edupolis. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer = AVAudioPlayer()

    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer=AVAudioPlayer (contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate=true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recordSlowButton(sender: UIButton) {
        resetAll()
        audioPlayer.currentTime=0
        audioPlayer.rate=0.5
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }

    @IBAction func recordFastButton(sender: UIButton) {
        resetAll()
        audioPlayer.currentTime=0
        audioPlayer.rate=1.5
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
   
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
   
    @IBAction func stopSoundButton(sender: UIButton) {
        resetAll()
        audioPlayer.currentTime=0
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        resetAll()
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }

    func resetAll () {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }

}
