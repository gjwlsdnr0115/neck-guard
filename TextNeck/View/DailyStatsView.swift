//
//  DailyStatsView.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/05/14.
//

import UIKit

class DailyStatsView: UIView {

    
    
    @IBOutlet weak var bar1: VerticalProgressBar!
    @IBOutlet weak var bar2: VerticalProgressBar!
    @IBOutlet weak var bar3: VerticalProgressBar!
    @IBOutlet weak var bar4: VerticalProgressBar!
    @IBOutlet weak var bar5: VerticalProgressBar!
    @IBOutlet weak var bar6: VerticalProgressBar!
    @IBOutlet weak var bar7: VerticalProgressBar!
    
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
    
    func setBar(bar: VerticalProgressBar, value: CGFloat) {
        bar.progress = value
        
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "test"
//        label.textAlignment = .center
//        self.addSubview(label)
//
//        let multiplier = 3.0 - (value * 2)
//
//        NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: bar, attribute: NSLayoutConstraint.Attribute.top, multiplier: multiplier, constant: 0).isActive = true
//        NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: bar, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
        
//        NSLayoutConstraint.activate([
//                                        label.bottomAnchor.constraint(equalTo: bar.topAnchor, constant: 0),
//
//                                        label.centerXAnchor.constraint(equalTo: bar.centerXAnchor)])
        
    }
}
