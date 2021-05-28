//
//  DailyStatsView.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/05/14.
//

import UIKit

class DailyStatsView: UIView {


    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreCircleChart: UIView!
    @IBOutlet weak var starView1: UIImageView!
    @IBOutlet weak var starView2: UIImageView!
    @IBOutlet weak var starView3: UIImageView!
    
    @IBOutlet weak var exercisedNumLabel: UILabel!
    
    func setNoStars() {
        starView1.image = UIImage(named: "gray_star")
        starView2.image = UIImage(named: "gray_star")
        starView3.image = UIImage(named: "gray_star")
        exercisedNumLabel.text = "0"
    }
    
    func setOneStar() {
        starView1.image = UIImage(named: "star")
        starView2.image = UIImage(named: "gray_star")
        starView3.image = UIImage(named: "gray_star")
        exercisedNumLabel.text = "1"
    }
    
    func setTwoStars() {
        starView1.image = UIImage(named: "star")
        starView2.image = UIImage(named: "star")
        starView3.image = UIImage(named: "gray_star")
        exercisedNumLabel.text = "2"
    }
    
    func setThreeStars() {
        starView1.image = UIImage(named: "star")
        starView2.image = UIImage(named: "star")
        starView3.image = UIImage(named: "star")
        exercisedNumLabel.text = "3"
    }
}
