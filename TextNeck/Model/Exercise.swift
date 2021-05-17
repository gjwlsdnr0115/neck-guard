//
//  Exercise.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/05/16.
//

import UIKit

class Exercise {
    let name: String
    let image: UIImage
    
    init(name: String, image: String) {
        self.name = name
        self.image = UIImage(named: image) ?? UIImage()
    }

    static func generateData() -> [Exercise] {
        return [Exercise(name: "Corner Stretch", image: "exercise-1"), Exercise(name: "Scapula Stretch", image: "exercise-2"),
                Exercise(name: "Wall Press", image: "exercise-3"), Exercise(name: "Wall Reach", image: "exercise-4")]
    }
}
