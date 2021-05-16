//
//  Exercise.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/05/16.
//

import UIKit

class Exercise {
    let name: String
//    let image: UIImage
    
//    init(name: String, image: String) {
//        self.name = name
//        self.image = UIImage(named: image) ?? UIImage()
//    }
    init(name: String) {
        self.name = name
    }
    
    static func generateData() -> [Exercise] {
        return [Exercise(name: "ex1"), Exercise(name: "ex2"), Exercise(name: "ex3"), Exercise(name: "ex4")]
    }
}
