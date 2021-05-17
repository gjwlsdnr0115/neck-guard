//
//  ExerciseDetailViewController.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/05/15.
//

import UIKit

class ExerciseDetailViewController: UIViewController {

    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var exerciseDetailLabel: UILabel!
    
    var exercise: Exercise?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setExercise()
        
    }
    
    func setExercise() {
        exerciseLabel.text = exercise?.name
        exerciseImage.image = exercise?.image
        exerciseDetailLabel.text = exercise?.detail
    }
    

}
