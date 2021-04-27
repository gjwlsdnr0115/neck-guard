//
//  RoundedUIView.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/04/27.
//

import UIKit

class RoundedUIView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        clipsToBounds = true
        layer.cornerRadius = 15
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 15
    }

}
