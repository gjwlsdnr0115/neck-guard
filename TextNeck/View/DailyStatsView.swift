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
    
    
    @IBOutlet weak var date1Label: UILabel!
    @IBOutlet weak var date2Label: UILabel!
    @IBOutlet weak var date3Label: UILabel!
    @IBOutlet weak var date4Label: UILabel!
    @IBOutlet weak var date5Label: UILabel!
    @IBOutlet weak var date6Label: UILabel!
    @IBOutlet weak var date7Label: UILabel!
    
    
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
//        
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "test"
//        label.textAlignment = .center
//        self.addSubview(label)
//        
//        let height = bar.frame.maxY - bar.frame.minY
//
//
//        NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: bar, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -height*value).isActive = true
//        NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: bar, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
//        

        
    }
    
    
    func loadBarData() {
        let formatter = SharedDateFormatter()
        
        var dayLabels = formatter.getPastSevenDaysLabel()
        dayLabels.reverse()
        
        date1Label.text = dayLabels[0]
        date2Label.text = dayLabels[1]
        date3Label.text = dayLabels[2]
        date4Label.text = dayLabels[3]
        date5Label.text = dayLabels[4]
        date6Label.text = dayLabels[5]
        date7Label.text = dayLabels[6]
        
        
        let days = formatter.getPastSevenDays()
        var datas = [Double]()
        
        for day in days {
            let score = DataManager.shared.fetchByDate(date: day)
            datas.append(score)
        }
        
        datas.reverse()
        
        print(datas.count)
        
        
        setBar(bar: bar1, value: CGFloat(datas[0]))
        setBar(bar: bar2, value: CGFloat(datas[1]))
        setBar(bar: bar3, value: CGFloat(datas[2]))
        setBar(bar: bar4, value: CGFloat(datas[3]))
        setBar(bar: bar5, value: CGFloat(datas[4]))
        setBar(bar: bar6, value: CGFloat(datas[5]))
        setBar(bar: bar7, value: CGFloat(datas[6]))
        
    }
}
