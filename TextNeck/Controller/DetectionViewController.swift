//
//  DetectionViewController.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/05/28.
//

import UIKit
import AVFoundation
import VideoToolbox

class DetectionViewController: UIViewController {

    
    @IBOutlet weak var previewImageView: PoseImageView!
    
    private let videoCapture = VideoCapture()
    
    private var poseNet: PoseNet!
    
    private var currentFrame: CGImage?
    
    private var poseBuilderConfiguration = PoseBuilderConfiguration()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.isIdleTimerDisabled = true
        
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
    
    
    
    @IBAction func stopDetectinToggled(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("detection finished")
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
        
        if poses.count == 1 {
            let p = poses.first
            let nosePoint = p?.joints[.nose]?.position
            let leftShoulderPoint = p?.joints[.rightShoulder]?.position
            
            if  leftShoulderPoint!.x - nosePoint!.x > 50 {

                print(nosePoint!.x)
                print(leftShoulderPoint!.x)
            } else {
            }
        }
        
        
        
        previewImageView.show(poses: poses, on: currentFrame)
    }
    
    
}
