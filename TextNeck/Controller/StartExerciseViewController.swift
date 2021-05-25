//
//  StartExerciseViewController.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/05/16.
//

import UIKit
import CoreData

class StartExerciseViewController: UIViewController {

    var list = [DailyEntity]()
    var target: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reloadTargetData()
    }
    
    func reloadTargetData() {
        list = DataManager.shared.fetchDaily()
        target = list.first
    }
    
    @IBAction func unwindToStartExercise (_ unwindSegue: UIStoryboardSegue) {
        print("exercise completed")
        
        let currentTotal = UserDefaults.standard.integer(forKey: userCurrentKey)
        UserDefaults.standard.set(currentTotal+1, forKey: userCurrentKey)
        
        let sharedFormatter = SharedDateFormatter()
        let today = sharedFormatter.getToday()
        
        
        if let target = target as? DailyEntity {
            
            print("target exsist")
            if target.date == today {
                print("today exists")
                let beforeNum = Int(target.exerciseNum)
                DataManager.shared.updateDaily(entity: target, exerciseNum: beforeNum + 1) {
                    self.reloadTargetData()
                    NotificationCenter.default.post(name: NSNotification.Name.NewDataDidInsert, object: nil)
                }
            } else {
                DataManager.shared.createDaily(date: today, exerciseNum: 1) {
                    self.reloadTargetData()
                    NotificationCenter.default.post(name: NSNotification.Name.NewDataDidInsert, object: nil)
                }
            }
        } else {
            print("no target")
            DataManager.shared.createDaily(date: today, exerciseNum: 1) {
                self.reloadTargetData()
                NotificationCenter.default.post(name: NSNotification.Name.NewDataDidInsert, object: nil)
            }
        }
        
    }

}
