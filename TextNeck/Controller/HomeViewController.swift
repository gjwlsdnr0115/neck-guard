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
    
    var token: NSObjectProtocol!
    var list = [DailyEntity]()
    
    
    
    let values = [0.8]
    let values2 = [0.54]
    let values3 = [0.46]
    let values4 = [0.66]
    
    let chartColor1 = [UIColor(displayP3Red: 123/255.0, green: 110/255.0, blue: 242/255.0, alpha: 1.0),
                       UIColor(displayP3Red: 228/255.0, green: 225/255.0, blue: 252/255.0, alpha: 1.0),]
    let chartColor2 = [UIColor(displayP3Red: 124/255.0, green: 225/255.0, blue: 238/255.0, alpha: 1.0),
                       UIColor(displayP3Red: 228/255.0, green: 248/255.0, blue: 251/255.0, alpha: 1.0),]
    let chartColor3 = [UIColor(displayP3Red: 32/255.0, green: 135/255.0, blue: 254/255.0, alpha: 1.0),
                       UIColor(displayP3Red: 209/255.0, green: 230/255.0, blue: 254/255.0, alpha: 1.0),]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = DataManager.shared.fetchDaily()
        
        token = NotificationCenter.default.addObserver(forName: NSNotification.Name.NewDataDidInsert, object: nil, queue: .main, using: { [weak self] (noti) in
            self?.list = DataManager.shared.fetchDaily()
            self?.reloadData()
            // implement update UI code
        })
        
        
        reloadData()
//        getGyroMotion()
    }
    
    func reloadData() {
        drawCircleChart(values: values, fgColor: chartColor1[0], bgColor: UIColor.systemGray5, width: 10, margin: 2, radius: 90, view: goalCircleChartView)
        drawCircleChart(values: values2, fgColor: chartColor2[0], bgColor: chartColor2[1], width: 6, margin: 2, radius: 32, view: goodCircleChartView)
        drawCircleChart(values: values3, fgColor: chartColor1[0], bgColor: chartColor1[1], width: 6, margin: 2, radius: 32, view: badCircleChartView)
        
        
        if list.count != 0 {
            let sharedFormatter = SharedDateFormatter()
            let today = sharedFormatter.getToday()
            let lastData = list.first
            if lastData?.date == today, let exerciseNum = lastData?.exerciseNum {
                switch exerciseNum {
                case 0:
                    drawCircleChart(values: [0.0], fgColor: chartColor3[0], bgColor: chartColor3[1], width: 6, margin: 2, radius: 32, view: exerciseCircleChartView)
                    exerciseLabel.text = "0 sets"
                case 1:
                    drawCircleChart(values: [0.33], fgColor: chartColor3[0], bgColor: chartColor3[1], width: 6, margin: 2, radius: 32, view: exerciseCircleChartView)
                    exerciseLabel.text = "1 set"
                case 2:
                    drawCircleChart(values: [0.66], fgColor: chartColor3[0], bgColor: chartColor3[1], width: 6, margin: 2, radius: 32, view: exerciseCircleChartView)
                    exerciseLabel.text = "2 sets"
                case 3:
                    drawCircleChart(values: [1.0], fgColor: chartColor3[0], bgColor: chartColor3[1], width: 6, margin: 2, radius: 32, view: exerciseCircleChartView)
                    exerciseLabel.text = "3 sets"
                default:
                    drawCircleChart(values: [1.0], fgColor: chartColor3[0], bgColor: chartColor3[1], width: 6, margin: 2, radius: 32, view: exerciseCircleChartView)
                    exerciseLabel.text = "\(exerciseNum) sets"
                }
            } else {
                drawCircleChart(values: [0.0], fgColor: chartColor3[0], bgColor: chartColor3[1], width: 6, margin: 2, radius: 32, view: exerciseCircleChartView)
                exerciseLabel.text = "0 sets"
            }
            
        } else {
            drawCircleChart(values: [0.0], fgColor: chartColor3[0], bgColor: chartColor3[1], width: 6, margin: 2, radius: 32, view: exerciseCircleChartView)
        }
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
            print("HomeVC motion started")
        } else {
            print("HomeVC motion unavailable")
        }
    }
    
    
    
}
