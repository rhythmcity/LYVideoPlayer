//
//  LYVideoPlayerControl.swift
//  LYVideoPlayer
//
//  Created by 李言 on 16/7/6.
//  Copyright © 2016年 李言. All rights reserved.
//

import UIKit
import AVFoundation
class LYVideoPlayerControl: NSObject,TransPortDelegate{
    private var assetUrl:NSURL?
    internal  var view:UIView? {
        
        return self.videoPlayView
    
    }
    private var asset:AVAsset?
    private var playerItem:AVPlayerItem?
    private var player:AVPlayer?
    private var itemEndObserver:AnyObject?
    private var itemObserver:AnyObject?
    private var lastPlaybackRate:Float?
    private var imageGenerator:AVAssetImageGenerator?
    private var videoPlayView:LYVideoPlayView?
    weak private var transport:TransPort?
    private var PlayerItemStatusContext = 0
    
    
    init(url:NSURL) {
        super.init()
        asset = AVAsset.init(URL: url)
        assetUrl = url
        self.prepareToPlay()
    }
    

    
    static func VideoPlayerControlWithURL(assetURL:NSURL) ->LYVideoPlayerControl {
        
        let control = LYVideoPlayerControl.init(url: assetURL)
        control.asset = AVAsset.init(URL: assetURL)
        control.prepareToPlay()
        
        return control

    }
    
    private func prepareToPlay() {
    
        let keys = ["tracks","duration","commonMetadata","availableMediaCharacteristicsWithMediaSelectionOptions"]
        
        self.playerItem = AVPlayerItem.init(asset: self.asset!, automaticallyLoadedAssetKeys: keys)
        
        self.playerItem?.addObserver(self, forKeyPath: "status", options:.New , context: &PlayerItemStatusContext)
        
        self.player = AVPlayer.init(playerItem: self.playerItem!)
        
        self.videoPlayView = LYVideoPlayView.init(play: self.player!)

        self.transport?.delegate = self
    
    }
    
    override func observeValueForKeyPath(keyPath: String?,
        ofObject object: AnyObject?,
        change: [String : AnyObject]?,
        context: UnsafeMutablePointer<Void>)
    {
        if let _ = change where context == &PlayerItemStatusContext {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.playerItem?.removeObserver(self, forKeyPath: "status")
                
                guard self.playerItem?.status == .ReadyToPlay else {
                
                    return
                }
                
                self.addPlayerItemTimeOberser()
                
                self.addItemEndObserverForPlayItem()
                
                let  duration = self.playerItem?.duration
                
                self.transport?.setCurrentTime(CMTimeGetSeconds(kCMTimeZero), duration: CMTimeGetSeconds(duration!))

                self.player?.play()
              
            })
        }
    }
    
    
    func  addPlayerItemTimeOberser() -> Void {
        
        let interval = CMTimeMakeWithSeconds(0.5, Int32(NSEC_PER_SEC))
        weak var weakSelf = self
        self.itemObserver = self.player?.addPeriodicTimeObserverForInterval(interval, queue: dispatch_get_main_queue(), usingBlock: { (time:CMTime) -> Void in
            let currentTime = CMTimeGetSeconds(time);
            let duration = CMTimeGetSeconds(weakSelf!.playerItem!.duration);
            weakSelf?.transport?.setCurrentTime(currentTime, duration: duration)
        })
    }
    
    func addItemEndObserverForPlayItem() -> Void {

        weak var weakSelf = self
        self.itemEndObserver = NSNotificationCenter.defaultCenter().addObserverForName(AVPlayerItemDidPlayToEndTimeNotification, object: self.playerItem, queue: NSOperationQueue.mainQueue()) { (notification:NSNotification) -> Void in
            weakSelf?.transport?.playbackComplete()
        }
    }
    
    
    func play() -> Void {
        self.player?.play()
    
    
    }
    func pause() -> Void {
        self.lastPlaybackRate = self.player?.rate
        self.player?.pause()
        
    }
    func stop() -> Void {
        self.player?.rate = 0
        self.transport?.playbackComplete()
    }
    func scrubbingDidStart() -> Void {
        self.lastPlaybackRate = self.player?.rate
        self.player?.pause()
        self.player?.removeTimeObserver(self.itemObserver!)
        
    }
    func scrubbingToTime(time:NSTimeInterval) ->Void {
        self.playerItem?.cancelPendingSeeks()
        self.player?.seekToTime(CMTimeMakeWithSeconds(time, Int32(NSEC_PER_SEC)), toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
        
    }
    func scrubbingDidEnd() -> Void {
        self.addPlayerItemTimeOberser()
        if self.lastPlaybackRate > 0.0 {
           self.player?.play()
        }
        
    }
    func jumpToTime(time:NSTimeInterval) ->Void {
        self.player!.seekToTime(CMTimeMakeWithSeconds(time, Int32(NSEC_PER_SEC)))
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if (self.itemEndObserver != nil) {
           NSNotificationCenter.defaultCenter().removeObserver(self, name: AVPlayerItemDidPlayToEndTimeNotification, object: self.playerItem)
        }
        
    
    }
    

}
