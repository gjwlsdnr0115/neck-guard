//
//  ExerciseViewController.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/05/15.
//

import UIKit

class ExerciseViewController: UIViewController {

    
    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var exerciseButton: UIButton!
    
    var count = 300
    
    var timer: Timer?
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        resetTimer()
        showDetailVC()

    }
    
    func showDetailVC() {
        let detailVC = storyboard?.instantiateViewController(identifier: "ExerciseDetailViewController") as! ExerciseDetailViewController
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true, completion: nil)
    }
    
    
    func updateTimer() {
        count -= 1
        let min = count / 60
        let sec = count % 60
        timeLabel.text = "0\(min):" + String(format: "%02d", sec)
    }
    
    func resetTimer() {
        timeLabel.text = "05:00"
        count = 300
    }
    
    
    func startTimer() {
//        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
//            if self.count > 0 {
//                self.updateTimer()
//            } else {
//                timer.invalidate()
//            }
//        }
        guard timer == nil else {
            print("nil")
            return
        }
        timer = Timer(timeInterval: 1.0, repeats: true, block: { timer in
            if self.count > 0 {
                self.updateTimer()
            } else {
                timer.invalidate()
            }
        })
        
        RunLoop.current.add(timer!, forMode: .default)
    }

    
    @IBAction func unwindToExercise (_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        print("unwinded")
        startTimer()
    }
    
    
    @IBAction func test(_ sender: Any) {
        timer?.invalidate()
        timer = nil
    }
    
    @IBAction func teststart(_ sender: Any) {
        startTimer()
    }
}
