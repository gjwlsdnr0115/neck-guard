//
//  ExerciseDetailViewController.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/05/15.
//

import UIKit

class ExerciseDetailViewController: UIViewController {

    @IBOutlet weak var exerciseLabel: UILabel!
    
    var exercise: Exercise?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        exerciseLabel.text = exercise?.name
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
