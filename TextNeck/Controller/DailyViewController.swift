//
//  DailyViewController.swift
//  TextNeck
//
//  Created by 허진욱 on 2021/05/14.
//

import UIKit
import FSCalendar

class DailyViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var slides: [UIView] = []
    
    let values = [0.8]
    let chartColor = [UIColor(displayP3Red: 124/255.0, green: 225/255.0, blue: 238/255.0, alpha: 1.0),
                      UIColor(displayP3Red: 73/255.0, green: 60/255.0, blue: 199/255.0, alpha: 1.0),]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slides = createSlides()
        setupScrollView(slides: slides)

        // Do any additional setup after loading the view.
    }
    

    
    func createSlides() -> [UIView] {
        let slide1:DailyStatsView = Bundle.main.loadNibNamed("DailyStatsView", owner: self, options: nil)?.first as! DailyStatsView
        drawCircleChart(values: values, fgColor: chartColor[0], bgColor: chartColor[1], width: 20, margin: 2, radius: 34, view: slide1.scoreCircleChart)
        
        let slide2:ExerciseStatsView = Bundle.main.loadNibNamed("ExerciseStatsView", owner: self, options: nil)?.first as! ExerciseStatsView
        slide2.calendar.delegate = self

 
        slide2.calendar.dataSource = self
        slide2.calendar.today = nil
        slide2.calendar.placeholderType = .none
        
        return [slide1, slide2]
    }
    
    func setupScrollView(slides: [UIView]) {
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        let height = view.frame.height - (statusBarHeight + navigationBarHeight + tabBarHeight)
        
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: height)
        scrollView.isPagingEnabled = true
        
        let slide1 = slides[0] as! DailyStatsView
        slide1.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        scrollView.addSubview(slide1)
        
        let slide2 = slides[1] as! ExerciseStatsView
        slide2.frame = CGRect(x: view.frame.width, y: 0, width: view.frame.width, height: height)
        scrollView.addSubview(slide2)
    }

}

extension DailyViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
}
