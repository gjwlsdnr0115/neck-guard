//
//  CircleChart.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/04/13.
//

import UIKit
import ConcentricProgressRingView

func drawCircleChart(values: [Double], fgColor: UIColor, bgColor: UIColor, width: CGFloat, margin: CGFloat, radius: CGFloat, chartView: UIView) {
    let rings = [ProgressRing(color: fgColor, backgroundColor: bgColor, width: width)]
    let progressRingView = ConcentricProgressRingView(center: CGPoint(x: chartView.bounds.midX, y: chartView.bounds.midY), radius: radius, margin: margin, rings: rings)
    progressRingView.arcs[0].setProgress(CGFloat(values[0]), duration: 1)
    chartView.addSubview(progressRingView)
}

