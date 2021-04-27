//
//  OverallHistoryViewController.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/04/27.
//

import UIKit

class OverallHistoryViewController: UIViewController {

    
    @IBOutlet weak var weeklyButton: UIButton!
    @IBOutlet weak var monthlyButton: UIButton!
    
    
    
    
    
    
    
    @IBOutlet weak var todayScoreCircleChartView: UIView!
    
    
    
    
    
    
    
    let values = [0.8]
    let chartColor = [UIColor(displayP3Red: 124/255.0, green: 225/255.0, blue: 238/255.0, alpha: 1.0),
                      UIColor(displayP3Red: 73/255.0, green: 60/255.0, blue: 199/255.0, alpha: 1.0),]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateScoreTab()
    }
    

    
    @IBAction func weeklyToggled(_ sender: Any) {
        if !weeklyButton.isSelected {
            weeklyButton.isSelected = true
            monthlyButton.isSelected = false
        }
    }
    
    @IBAction func monthlyToggled(_ sender: Any) {
        if !monthlyButton.isSelected {
            monthlyButton.isSelected = true
            weeklyButton.isSelected = false
        }
    }
    

    
    
    func updateScoreTab() {
        drawCircleChart(values: values, fgColor: chartColor[0], bgColor: chartColor[1], width: 20, margin: 2, radius: 34, view: todayScoreCircleChartView)
    }
    
}
