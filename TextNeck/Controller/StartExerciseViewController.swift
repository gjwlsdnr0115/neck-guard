//
//  StartExerciseViewController.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/05/16.
//

import UIKit

class StartExerciseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToStartExercise (_ unwindSegue: UIStoryboardSegue) {
        print("exercise completed")
    }

}
