//
//  ProgressBar.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/04/13.
//

import UIKit

@IBDesignable
class VerticalProgressBar: UIView {
    @IBInspectable var color: UIColor? = .gray
    var progress: CGFloat = 0.0 {
        didSet { setNeedsDisplay() }
    }
    
    private let progressLayer = CALayer()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(progressLayer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.addSublayer(progressLayer)
    }
    
    
    
    override func draw(_ rect: CGRect) {
        let backgroundMask = CAShapeLayer()
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.width*0.25).cgPath
        layer.mask = backgroundMask
        
        let origin = CGPoint(x: 0, y: rect.height)
        
        let progressRect = CGRect(origin: origin, size: CGSize(width: rect.width, height: -rect.height*progress))
        progressLayer.frame = progressRect
        
        layer.addSublayer(progressLayer)
        progressLayer.backgroundColor = color?.cgColor
        
    }
}
