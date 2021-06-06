//
//  DailyStatsView.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/05/14.
//

import UIKit
import Charts

class DailyStatsView: UIView {

    
    
//    @IBOutlet weak var bar1: VerticalProgressBar!
//    @IBOutlet weak var bar2: VerticalProgressBar!
//    @IBOutlet weak var bar3: VerticalProgressBar!
//    @IBOutlet weak var bar4: VerticalProgressBar!
//    @IBOutlet weak var bar5: VerticalProgressBar!
//    @IBOutlet weak var bar6: VerticalProgressBar!
//    @IBOutlet weak var bar7: VerticalProgressBar!
//
//
//    @IBOutlet weak var date1Label: UILabel!
//    @IBOutlet weak var date2Label: UILabel!
//    @IBOutlet weak var date3Label: UILabel!
//    @IBOutlet weak var date4Label: UILabel!
//    @IBOutlet weak var date5Label: UILabel!
//    @IBOutlet weak var date6Label: UILabel!
//    @IBOutlet weak var date7Label: UILabel!
    
    @IBOutlet weak var barChartView: BarChartView!
    
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
        
        
        
        
        
//        date1Label.text = dayLabels[0]
//        date2Label.text = dayLabels[1]
//        date3Label.text = dayLabels[2]
//        date4Label.text = dayLabels[3]
//        date5Label.text = dayLabels[4]
//        date6Label.text = dayLabels[5]
//        date7Label.text = dayLabels[6]
//        
//        
        let days = formatter.getPastSevenDays()
        var datas = [Double]()
        
        for day in days {
            let score = DataManager.shared.fetchByDate(date: day)
            datas.append(score)
        }
        
        datas.reverse()
//        
//        print(datas.count)
//        
//        
//        setBar(bar: bar1, value: CGFloat(datas[0]))
//        setBar(bar: bar2, value: CGFloat(datas[1]))
//        setBar(bar: bar3, value: CGFloat(datas[2]))
//        setBar(bar: bar4, value: CGFloat(datas[3]))
//        setBar(bar: bar5, value: CGFloat(datas[4]))
//        setBar(bar: bar6, value: CGFloat(datas[5]))
//        setBar(bar: bar7, value: CGFloat(datas[6]))
        
        
        barChartView.noDataText = "No data"
        var barDataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dayLabels.count {
            let barDataEntry = BarChartDataEntry(x: Double(i), y: datas[i])
            barDataEntries.append(barDataEntry)
        }
        
        let barChartDataSet = BarChartDataSet(entries: barDataEntries, label: "Daily score")
        let data = BarChartData(dataSet: barChartDataSet)
        barChartView.data = data
        barChartView.data!.setValueTextColor(UIColor.systemGray2)
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        barChartView.xAxis.axisMaximum = data.xMax + 0.25
        barChartView.xAxis.axisMinimum = data.xMin - 0.25
        barChartView.xAxis.drawAxisLineEnabled = false

        // X축 레이블 포맷 ( index -> 실제데이터 )
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dayLabels)
//        let font =  UIFont.init(name: "Open Sans", size: 13.0)!
//        barChartView.xAxis.labelFont = font

        // 배경 그리드 라인 그릴지 여부
        barChartView.xAxis.drawGridLinesEnabled = false
   
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.backgroundColor = .white
        barChartView.drawBarShadowEnabled = false

        // 우측 레이블 제거
        barChartView.rightAxis.enabled = false
        barChartView.leftAxis.enabled = false
        
        
        // X축 레이블 위치 조정
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelTextColor = UIColor.systemGray
        barChartView.leftAxis.axisMinimum = 0
        barChartView.rightAxis.axisMinimum = 0
        
        
        // legend
        barChartView.legend.enabled = false

        
        // bar chart
        // 바 컬러, 바 두께

        barChartDataSet.colors = [UIColor(red: 1, green: 0.7686, blue: 0.8941, alpha: 1.0), UIColor(red: 1, green: 0.8824, blue: 0.749, alpha: 1.0), UIColor(red: 1, green: 0.9922, blue: 0.7686, alpha: 1.0), UIColor(red: 0.7686, green: 1, blue: 0.9255, alpha: 1.0), UIColor(red: 0.7686, green: 0.9843, blue: 1, alpha: 1.0), UIColor(red: 0.7686, green: 0.8039, blue: 1, alpha: 1.0), UIColor(red: 0.8196, green: 0.7686, blue: 1, alpha: 1.0) ]

        let barWidth = 0.5
        data.barWidth = barWidth
        barChartDataSet.barShadowColor = UIColor.systemGray6
        barChartDataSet.highlightEnabled = false
        barChartDataSet.axisDependency = .left
        // 줌 안되게
        
        barChartView.doubleTapToZoomEnabled = false

        // 애니메이션 효과
        // 기본 애니메이션
//        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        // 옵션 애니메이션
        barChartView.animate(yAxisDuration: 2.0, easingOption: .easeInBounce)
        barChartView.drawMarkers = true
        barChartView.marker = ChartMarker()
        barChartView.setExtraOffsets(left: 15.0, top: 0.0, right: 15.0, bottom: 15.0)
//
    }
}
