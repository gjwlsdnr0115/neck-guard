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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
}
