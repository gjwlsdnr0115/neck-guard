//
//  HomeViewController.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/04/13.
//

import UIKit
import ConcentricProgressRingView
import CoreMotion

class HomeViewController: UIViewController {

        
    @IBOutlet weak var goalPercentLabel: UILabel!
    
    @IBOutlet weak var goalCircleChartView: UIView!
    @IBOutlet weak var goodCircleChartView: UIView!
    @IBOutlet weak var badCircleChartView: UIView!
    @IBOutlet weak var exerciseCircleChartView: UIView!
    
    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var badLabel: UILabel!
    @IBOutlet weak var exerciseLabel: UILabel!
    
    @IBOutlet weak var barChartView: HorizontalProgressBar!
    
    var motion = CMMotionManager()
    
    
    let values = [0.8]
    let chartColor1 = [UIColor(displayP3Red: 123/255.0, green: 110/255.0, blue: 242/255.0, alpha: 1.0),
                       UIColor(displayP3Red: 228/255.0, green: 225/255.0, blue: 252/255.0, alpha: 1.0),]
    let chartColor2 = [UIColor(displayP3Red: 124/255.0, green: 225/255.0, blue: 238/255.0, alpha: 1.0),
                       UIColor(displayP3Red: 228/255.0, green: 248/255.0, blue: 251/255.0, alpha: 1.0),]
    let chartColor3 = [UIColor(displayP3Red: 32/255.0, green: 135/255.0, blue: 254/255.0, alpha: 1.0),
                       UIColor(displayP3Red: 209/255.0, green: 230/255.0, blue: 254/255.0, alpha: 1.0),]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
        getGyroMotion()
    }
    
    func reloadData() {
        drawCircleChart(values: values, fgColor: chartColor1[0], bgColor: UIColor.systemGray5, width: 10, margin: 2, radius: 90, view: goalCircleChartView)
        drawCircleChart(values: values, fgColor: chartColor2[0], bgColor: chartColor2[1], width: 6, margin: 2, radius: 32, view: goodCircleChartView)
        drawCircleChart(values: values, fgColor: chartColor1[0], bgColor: chartColor1[1], width: 6, margin: 2, radius: 32, view: badCircleChartView)
        drawCircleChart(values: values, fgColor: chartColor3[0], bgColor: chartColor3[1], width: 6, margin: 2, radius: 32, view: exerciseCircleChartView)
    }

    
    func getGyroMotion() {
        
        if motion.isDeviceMotionAvailable {
            motion.deviceMotionUpdateInterval = 0.5
            
            motion.startDeviceMotionUpdates(to: OperationQueue()) { (data, error) in
                if let attitude = data?.attitude {
                    let deviceAngle = attitude.pitch * 180 / Double.pi
                    let angleProgress = deviceAngle / 90.0
                    DispatchQueue.main.async {
                        self.barChartView.progress = CGFloat(angleProgress)
                    }
                }
            }
            print("Device motion started")
        } else {
            print("Device motion unavailable")
        }
    }
    
}
