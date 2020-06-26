//
//  ViewController.swift
//  puzzles
//
//  Created by Sidharth Daga on 6/24/20.
//  Copyright © 2020 Sidharth Daga. All rights reserved.
//

import UIKit
import AVKit
class ViewController: UIViewController {
    
    var videoPlayer: AVPlayer?
    
    var videoPlayerLayer: AVPlayerLayer?
    
    @IBOutlet weak var logIn: UIButton!
    @IBOutlet weak var signUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpVideo()
    }
    
    func setUpVideo() {
        let bundlePath = Bundle.main.path(forResource: "boon", ofType: "mp4")
        guard bundlePath != nil else {
            return
        }
        let urld = URL(fileURLWithPath: bundlePath!)
        let item = AVPlayerItem(url: urld)
        videoPlayer = AVPlayer(playerItem: item)
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        videoPlayer?.playImmediately(atRate: 1)
    }
    
}

