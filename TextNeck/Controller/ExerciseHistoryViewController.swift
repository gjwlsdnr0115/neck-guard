//
//  ExerciseHistoryViewController.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/04/27.
//

import UIKit
import FSCalendar

class ExerciseHistoryViewController: UIViewController {

    
    
    @IBOutlet weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.today = nil
        calendar.placeholderType = .none

        // Do any additional setup after loading the view.
    }
    

}

extension ExerciseHistoryViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
}
