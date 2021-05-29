//
//  DetectionViewController.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/05/28.
//

import UIKit
import AVFoundation
import VideoToolbox
import CoreData

class DetectionViewController: UIViewController {

    
    @IBOutlet weak var positionControl: UISegmentedControl!
    @IBOutlet weak var previewImageView: PoseImageView!
    
    @IBOutlet weak var warningImageView: UIImageView!
    //    @IBOutlet weak var postureStatusLabel: UILabel!
    private let videoCapture = VideoCapture()
    
    var list = [DailyEntity]()
    var target: NSManagedObject?
    
    
    private var preferedRight = true
    private var poseNet: PoseNet!
    
    private var currentFrame: CGImage?
    
    private var poseBuilderConfiguration = PoseBuilderConfiguration()
    
    private var isGoodPose = false
    
    private var goodPoseTime = 0.0
    private var badPoseTime = 0.0
    
    var goodPoseTimer: Timer?
    var badPoseTimer: Timer?

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.isIdleTimerDisabled = true
        
        
        
        reloadTargetData()
        resetTimer()
        
        
        do {
            poseNet = try PoseNet()
            print("model found")
        } catch {
            fatalError("Failed to load model. \(error.localizedDescription)")
        }
        poseNet.delegate = self
        setupAndBeginCapturingVideoFrames()
    }
    
    
    private func setupAndBeginCapturingVideoFrames() {
        videoCapture.setUpAVCapture { error in
            if let error = error {
                print("Failed to setup camera with error \(error)")
                return
            }

            self.videoCapture.delegate = self

            self.videoCapture.startCapturing()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        videoCapture.stopCapturing {
            super.viewWillDisappear(animated)
        }
    }
    
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        // Reinitilize the camera to update its output stream with the new orientation.
        setupAndBeginCapturingVideoFrames()
    }
    

    
    
    func reloadTargetData() {
        list = DataManager.shared.fetchDaily()
        target = list.first
    }
    
    
    @IBAction func positionControlToggled(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            preferedRight = false
        } else {
            preferedRight = true
        }
    }
    
    
    
    @IBAction func stopDetectinToggled(_ sender: Any) {
        
        stopGoodPoseTimer()
        stopBadPoseTimer()
        
        let sharedFormatter = SharedDateFormatter()
        let today = sharedFormatter.getToday()
        
        if let target = target as? DailyEntity {
            print("target exists")
            if target.date == today {
                let beforeGoodPostureTime = target.goodPostureTime
                let beforeBadPostureTime = target.badPostureTime
                
                DataManager.shared.updateDaily(entity: target, goodPostureTime: beforeGoodPostureTime + goodPoseTime, badPostureTime: beforeBadPostureTime + badPoseTime) {
                    self.reloadTargetData()
                    NotificationCenter.default.post(name: NSNotification.Name.NewDataDidInsert, object: nil)
                }
            } else {
                DataManager.shared.createDaily(date: today, goodPostureTime: goodPoseTime, badPostureTime: badPoseTime) {
                    self.reloadTargetData()
                    NotificationCenter.default.post(name: NSNotification.Name.NewDataDidInsert, object: nil)
                }
            }
        } else {
            print("no target")
            DataManager.shared.createDaily(date: today, goodPostureTime: goodPoseTime, badPostureTime: badPoseTime) {
                self.reloadTargetData()
                NotificationCenter.default.post(name: NSNotification.Name.NewDataDidInsert, object: nil)
            }
        }
        
        
        
        dismiss(animated: true, completion: nil)
    }
    
    
    deinit {
        print("detection finished")
        stopGoodPoseTimer()
        stopBadPoseTimer()
        
        print("good: \(goodPoseTime)")
        print("bad: \(badPoseTime)")
    }

}

extension DetectionViewController {
    
    func resetTimer() {
        goodPoseTimer = nil
        goodPoseTime = 0
        
        badPoseTimer = nil
        badPoseTime = 0
    }
    
    func startGoodPoseTimer() {
        guard goodPoseTimer == nil else {
            return
        }
        
        goodPoseTimer = Timer(timeInterval: 1.0, repeats: true, block: { [weak self] timer in
            self?.goodPoseTime += 1
        })
        
        RunLoop.current.add(goodPoseTimer!, forMode: .default)
    }
    
    func stopGoodPoseTimer() {
        goodPoseTimer?.invalidate()
        goodPoseTimer = nil
    }
    
    func startBadPoseTimer() {
        guard badPoseTimer == nil else {
            return
        }
        
        badPoseTimer = Timer(timeInterval: 1.0, repeats: true, block: { [weak self] timer in
            self?.badPoseTime += 1
        })
        
        RunLoop.current.add(badPoseTimer!, forMode: .default)
    }
    
    func stopBadPoseTimer() {
        badPoseTimer?.invalidate()
        badPoseTimer = nil
    }
    
}


extension DetectionViewController: VideoCaptureDelegate {
    func videoCapture(_ videoCapture: VideoCapture, didCaptureFrame capturedImage: CGImage?) {
        guard currentFrame == nil else {
            return
        }
        guard let image = capturedImage else {
            fatalError("Captured image is null")
        }
        currentFrame = image
        poseNet.predict(image)
    }
    
    
}

extension DetectionViewController: PoseNetDelegate {
    func poseNet(_ poseNet: PoseNet, didPredict predictions: PoseNetOutput) {
        defer {
            self.currentFrame = nil
        }
        
        guard let currentFrame = currentFrame else {
            return
        }

        let poseBuilder = PoseBuilder(output: predictions,
                                      configuration: poseBuilderConfiguration,
                                      inputImage: currentFrame)
        
        let poses = [poseBuilder.pose]
        
        let p = poses.first
        let nosePoint = p?.joints[.nose]?.position
        
        if preferedRight {
            let rightShoulderPoint = p?.joints[.rightShoulder]?.position
            
            if  rightShoulderPoint!.x - nosePoint!.x > 30 {

                if isGoodPose {
                    isGoodPose = false
                    stopGoodPoseTimer()
                    startBadPoseTimer()
                }
                
                if warningImageView.isHidden {
                    warningImageView.isHidden = false
                }
            } else {
                
                if !isGoodPose {
                    isGoodPose = true
                    stopBadPoseTimer()
                    startGoodPoseTimer()
                }
                
                if !warningImageView.isHidden {
                    warningImageView.isHidden = true
                }
                
            }
            previewImageView.show(poses: poses, on: currentFrame)
        
        } else {
            let leftShoulderPoint = p?.joints[.leftShoulder]?.position
            
            if nosePoint!.x - leftShoulderPoint!.x > 30 {
                if isGoodPose {
                    isGoodPose = false
                    stopGoodPoseTimer()
                    startBadPoseTimer()
                }
                
                if warningImageView.isHidden {
                    warningImageView.isHidden = false
                }
            } else {
                if !isGoodPose {
                    isGoodPose = true
                    stopBadPoseTimer()
                    startGoodPoseTimer()
                }
                
                if !warningImageView.isHidden {
                    warningImageView.isHidden = true
                }
            }
            previewImageView.show(poses: poses, on: currentFrame)
        }
        
    }
    
    
}
