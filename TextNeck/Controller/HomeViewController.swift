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
    @IBOutlet weak var currentNumLabel: UILabel!
    
    @IBOutlet weak var goalCircleChartView: UIView!
    @IBOutlet weak var goodCircleChartView: UIView!
    @IBOutlet weak var badCircleChartView: UIView!
    @IBOutlet weak var exerciseCircleChartView: UIView!
    
    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var badLabel: UILabel!
    @IBOutlet weak var exerciseLabel: UILabel!
        
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
        
        
//        reloadData()
//        getGyroMotion()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadData()
    }
    
    
    func reloadData() {
        
        reloadGoalStatusData()
        reloadGoodPostureData()
        reloadBadPostureDate()
        reloadExerciseNumData()
    }
    
    func reloadGoalStatusData() {
        let goalNum = UserDefaults.standard.integer(forKey: userGoalKey)
        let currentNum = UserDefaults.standard.integer(forKey: userCurrentKey)
        var value = Double(currentNum) / Double(goalNum)
        
        if value > 1.0 {
            value = 1.0
        }
        
        
        let valuePercent = Int(value * 100)
        currentNumLabel.text = "\(currentNum)"
        goalPercentLabel.text = "\(valuePercent)%"
        
        drawCircleChart(values: [value], fgColor: chartColor1[0], bgColor: UIColor.systemGray5, width: 10, margin: 2, radius: 90, chartView: goalCircleChartView)
    }
    
    func reloadGoodPostureData() {
        drawCircleChart(values: values2, fgColor: chartColor2[0], bgColor: chartColor2[1], width: 6, margin: 2, radius: 32, chartView: goodCircleChartView)
    }
    
    func reloadBadPostureDate() {
        drawCircleChart(values: values3, fgColor: chartColor1[0], bgColor: chartColor1[1], width: 6, margin: 2, radius: 32, chartView: badCircleChartView)
    }
    
    func reloadExerciseNumData() {
        if list.count != 0 {
            let sharedFormatter = SharedDateFormatter()
            let today = sharedFormatter.getToday()
            let lastData = list.first
            if lastData?.date == today, let exerciseNum = lastData?.exerciseNum {
                switch exerciseNum {
                case 0:
                    drawCircleChart(values: [0.0], fgColor: chartColor3[0], bgColor: chartColor3[1], width: 6, margin: 2, radius: 32, chartView: exerciseCircleChartView)
                    exerciseLabel.text = "0 sets"
                case 1:
                    drawCircleChart(values: [0.33], fgColor: chartColor3[0], bgColor: chartColor3[1], width: 6, margin: 2, radius: 32, chartView: exerciseCircleChartView)
                    exerciseLabel.text = "1 set"
                case 2:
                    drawCircleChart(values: [0.66], fgColor: chartColor3[0], bgColor: chartColor3[1], width: 6, margin: 2, radius: 32, chartView: exerciseCircleChartView)
                    exerciseLabel.text = "2 sets"
                case 3:
                    drawCircleChart(values: [1.0], fgColor: chartColor3[0], bgColor: chartColor3[1], width: 6, margin: 2, radius: 32, chartView: exerciseCircleChartView)
                    exerciseLabel.text = "3 sets"
                default:
                    drawCircleChart(values: [1.0], fgColor: chartColor3[0], bgColor: chartColor3[1], width: 6, margin: 2, radius: 32, chartView: exerciseCircleChartView)
                    exerciseLabel.text = "\(exerciseNum) sets"
                }
            } else {
                drawCircleChart(values: [0.0], fgColor: chartColor3[0], bgColor: chartColor3[1], width: 6, margin: 2, radius: 32, chartView: exerciseCircleChartView)
                exerciseLabel.text = "0 sets"
            }
            
        } else {
            drawCircleChart(values: [0.0], fgColor: chartColor3[0], bgColor: chartColor3[1], width: 6, margin: 2, radius: 32, chartView: exerciseCircleChartView)
        }
    }

    
//    func getGyroMotion() {
//
//        if motion.isDeviceMotionAvailable {
//            motion.deviceMotionUpdateInterval = 0.5
//
//            motion.startDeviceMotionUpdates(to: OperationQueue()) { (data, error) in
//                if let attitude = data?.attitude {
//                    let deviceAngle = attitude.pitch * 180 / Double.pi
//                    let angleProgress = deviceAngle / 90.0
//                    DispatchQueue.main.async {
//                        self.barChartView.progress = CGFloat(angleProgress)
//                    }
//                }
//            }
//            print("HomeVC motion started")
//        } else {
//            print("HomeVC motion unavailable")
//        }
//    }
    
    
    @IBAction func setGoalButtonToggled(_ sender: Any) {
        let controller = UIAlertController(title: "Manage Goal Settings", message: nil, preferredStyle: .actionSheet)
        
        let setNewGoalAction = UIAlertAction(title: "Set New Goal", style: .default) { [weak self] (action) in
            let subController = UIAlertController(title: "Set New Goal", message: "This does not reset your current progress.", preferredStyle: .alert)
            
            subController.addTextField { goalField in
                goalField.keyboardType = .numberPad
                
            }
            
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                if let goalField = subController.textFields?.first {
                    print("textfound")
                    if let text = goalField.text {
                        let newGoal = Int(text)
                        
                        if newGoal != 0, newGoal != nil{
                            UserDefaults.standard.setValue(newGoal!, forKey: userGoalKey)
                            NotificationCenter.default.post(name: NSNotification.Name.NewDataDidInsert, object: nil)
                        }
                    }
                }
            }
            
            subController.addAction(okAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            subController.addAction(cancelAction)
            self?.present(subController, animated: true, completion: nil)
            
        }
        controller.addAction(setNewGoalAction)
        
        let resetProgressAction = UIAlertAction(title: "Reset Progress", style: .destructive) { [weak self] (action) in
            let subController = UIAlertController(title: "Delete Progress Data?", message: "Your current progress will be permanently deleted.", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .default) { (action) in
                UserDefaults.standard.setValue(0, forKey: userCurrentKey)
                NotificationCenter.default.post(name: NSNotification.Name.NewDataDidInsert, object: nil)
            }
            subController.addAction(deleteAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            subController.addAction(cancelAction)
            self?.present(subController, animated: true, completion: nil)
        }
        controller.addAction(resetProgressAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        
        present(controller, animated: true, completion: nil)
    }
    
    
    @IBAction func startDetectionToggled(_ sender: Any) {
        let detectionVC = storyboard?.instantiateViewController(identifier: "DetectionViewController") as! DetectionViewController
        detectionVC.modalPresentationStyle = .fullScreen
        present(detectionVC, animated: true, completion: nil)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(token)
    }
}
