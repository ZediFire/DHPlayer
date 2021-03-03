//
//  ViewController.swift
//  DHPlayer
//
//  Created by Iziah Reid on 3/2/21.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var playbackSlider: UISlider!
    @IBOutlet weak var lblAlbumTitle: UILabel!
    
    @IBOutlet weak var lblSongTitle: UILabel!
    @IBOutlet weak var imgAlbumCover: UIImageView!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblCurrentTime: UILabel!
    
    var audioPlayer = AVAudioPlayer()
    var isPlaying:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func btnShare_Click(_ sender: Any) {
        //open share viewcontroller
    }
    
    @IBAction func btnBack_Click(_ sender: Any) {
    }
    
    
    @IBAction func btnPlayPause_Click(_ sender: Any) {
        if isPlaying{ 
            audioPlayer.pause()
           
        }else{
            audioPlayer.play()
        }
        isPlaying = !isPlaying
    }
    

    @IBAction func btnForward_Click(_ sender: Any) {
    }
    
    @IBAction func btnComment_Click(_ sender: Any) {
        
    }


    @IBAction func playbackSlider_ValueChanged(_ sender: Any) {
        audioPlayer.stop()
        audioPlayer.currentTime = TimeInterval(playbackSlider.value)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    @objc func updateSlider() {
        playbackSlider.value = Float(audioPlayer.currentTime)
    }
    
    @objc func updateTime() {
        let currentTime = Int(audioPlayer.currentTime)
        let duration = Int(audioPlayer.duration)
        let total = currentTime - duration
        let totalString = String(total)

        let minutes = currentTime/60
        let seconds = currentTime - minutes / 60

        lblCurrentTime.text = NSString(format: "%02d:%02d", minutes,seconds) as String
        playbackSlider.value = Float(audioPlayer.currentTime)
    }

    
    func loadSong(){
        
        let updateTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        let timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)

        let pathString = Bundle.main.path(forResource: "loficodingbeatss", ofType: "mp3")

            if let pathString = pathString {

                let pathURL = NSURL(fileURLWithPath: pathString)
 
                do {

                    try audioPlayer = AVAudioPlayer(contentsOf: pathURL as URL)

                } catch {

                    print("error")
                }


            }

        playbackSlider.maximumValue = Float(audioPlayer.duration)
        playbackSlider.maximumValue = Float(audioPlayer.duration)
        
      
        let duration = Int(audioPlayer.duration)
        

        let minutes = duration/60
        let seconds = duration - minutes / 60

        lblCurrentTime.text = NSString(format: "%02d:%02d", minutes,seconds) as String
        
    }
    
}

