//
//  DailyViewController.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/05/14.
//

import UIKit
import FSCalendar

class DailyViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topBarView: UIView!
    
    @IBOutlet weak var dailyStatsButton: UIButton!
    @IBOutlet weak var exerciseStatsButton: UIButton!
    
    
    var slides: [UIView] = []
    
    var token: NSObjectProtocol!
    var list = [DailyEntity]()
    
    
    // dummy data
    let values = [0.8]
    let chartColor = [UIColor(displayP3Red: 124/255.0, green: 225/255.0, blue: 238/255.0, alpha: 1.0),
                      UIColor(displayP3Red: 73/255.0, green: 60/255.0, blue: 199/255.0, alpha: 1.0),]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("hi")
        
        list = DataManager.shared.fetchDaily()
        print(list.count)
        
        token = NotificationCenter.default.addObserver(forName: NSNotification.Name.NewDataDidInsert, object: nil, queue: .main, using: { [weak self] (noti) in
            self?.list = DataManager.shared.fetchDaily()
            self?.slides = (self?.createSlides()) ?? []
            self?.setupScrollView(slides: self?.slides ?? [])
            // implement update UI code
        })
        
        
        setTitleLabel()
        slides = createSlides()
        setupScrollView(slides: slides)
        scrollView.delegate = self

        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        
        
        dailyStatsButton.addTarget(self, action: #selector(dailyButtonTapped), for: .touchUpInside)
        exerciseStatsButton.addTarget(self, action: #selector(exerciseButtonTapped), for: .touchUpInside)

    }
    
    func setTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.text = "Daily"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
        titleLabel.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    @objc func dailyButtonTapped() {
        if scrollView.contentOffset.x > 0 {
            let newOffset = CGPoint(x: scrollView.contentOffset.x - self.view.bounds.width, y: scrollView.contentOffset.y)
            scrollView.setContentOffset(newOffset, animated: true)
            }
    }
    
    @objc func exerciseButtonTapped() {
        if scrollView.contentOffset.x == 0 {
            let newOffset = CGPoint(x: scrollView.contentOffset.x + self.view.bounds.width, y: scrollView.contentOffset.y)
            scrollView.setContentOffset(newOffset, animated: true)
        }
    }
    
    
    func createSlides() -> [UIView] {
        
        let slide1:DailyStatsView = Bundle.main.loadNibNamed("DailyStatsView", owner: self, options: nil)?.first as! DailyStatsView
        drawCircleChart(values: values, fgColor: chartColor[0], bgColor: chartColor[1], width: 20, margin: 2, radius: 34, view: slide1.scoreCircleChart)
        
        if list.count != 0 {
            let sharedFormatter = SharedDateFormatter()
            let today = sharedFormatter.getToday()
            let lastData = list.last
            if lastData?.date == today, let exerciseNum = lastData?.exerciseNum {
                switch exerciseNum {
                case 0:
                    slide1.setNoStars()
                case 1:
                    slide1.setOneStar()
                case 2:
                    slide1.setTwoStars()
                case 3:
                    slide1.setThreeStars()
                default:
                    slide1.setThreeStars()
                    slide1.exercisedNumLabel.text = "\(exerciseNum)"
                }
            } else {
                slide1.setNoStars()
            }

        } else {
            slide1.setNoStars()
        }
        
        let slide2:ExerciseStatsView = Bundle.main.loadNibNamed("ExerciseStatsView", owner: self, options: nil)?.first as! ExerciseStatsView
        slide2.calendar.delegate = self
 
        slide2.calendar.dataSource = self
        slide2.calendar.today = nil
        slide2.calendar.placeholderType = .none
        
        return [slide1, slide2]
    }
    
    func setupScrollView(slides: [UIView]) {
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        let topBarViewHeight = topBarView.frame.height
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        let height = view.frame.height - (statusBarHeight + topBarViewHeight + navigationBarHeight + tabBarHeight)
        
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
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(token)
    }

}

extension DailyViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
}

extension DailyViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 {
            dailyStatsButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: dailyStatsButton.titleLabel?.font.pointSize ?? 16)
            exerciseStatsButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: exerciseStatsButton.titleLabel?.font.pointSize ?? 16)
        }
        
        if scrollView.contentOffset.x == self.view.bounds.width {
            exerciseStatsButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: exerciseStatsButton.titleLabel?.font.pointSize ?? 16)
            dailyStatsButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: dailyStatsButton.titleLabel?.font.pointSize ?? 16)
        }
    }
}

extension NSNotification.Name {
    static let NewDataDidInsert = NSNotification.Name("NewDataDidInsertNotification")
}
