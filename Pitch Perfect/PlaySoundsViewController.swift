//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Alberto Luis Castro Castro - Ceiba Software on 24/08/15.
//  Copyright (c) 2015 Ceiba Software. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var audioPlayer:AVAudioPlayer!;
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    override func viewDidLoad() {
        super.viewDidLoad()
//        if var filePath = NSBundle.mainBundle().URLForResource("movie_quote", withExtension: "mp3"){
//        
//            audioPlayer = AVAudioPlayer(contentsOfURL: filePath , error: nil);
//            audioPlayer.enableRate = true
//        }else{
//            println("The filePath is empty")
//        }
        audioEngine = AVAudioEngine();
        
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl , error: nil);
        audioPlayer.enableRate = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playAudio(rate:Float){
        audioPlayer.stop()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }

    @IBAction func rabbitButton(sender: UIButton) {
        playAudio(2.0)
    }
    
    @IBAction func snailButton(sender: UIButton) {
       playAudio(0.5)
        
    }
    @IBAction func stopButton(sender: UIButton) {
        audioPlayer.stop()
    }
    @IBAction func chipmunk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
        
        
    }
    
    @IBAction func darthVaderButton(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    //New Function
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
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
}