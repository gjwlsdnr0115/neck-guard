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
    let detail: String
    
    init(name: String, image: String, detail: String) {
        self.name = name
        self.image = UIImage(named: image) ?? UIImage()
        self.detail = detail
    }

    static func generateData() -> [Exercise] {
        
        let detail1 = "Face a corner of your room.\nPlace your forearms on each side of the corner seam.\nKeep your elbows just below the height of your shoulders.\nLean in as far as possible.\nHold the stretch for 30-60 seconds."
        let detail2 = "Raise your right elbow above the level of your shoulder.\nRest your elbow against a wall. Turn your head to the left and bring your chin down.\nHold the stretch for 30-60 seconds\nRepeat on the other side."
        let detail3 = "Stand with your back against a wall, with your heels as close to the wall as possible.\nPress your spine against the wall, including the spine in your neck, and the back of your head."
        let detail4 = "Stand with your back against the wall and tighten your core muscles.\nTilt your head downward. Bend your elbows and squeeze your shoulder blades together, keeping them flat against the wall.\nRaise your arms upward over your head while keeping the backs of your arms flat against the wall."
        
        return [Exercise(name: "Corner Stretch", image: "exercise-1", detail: detail1), Exercise(name: "Scapula Stretch", image: "exercise-2", detail: detail2),
                Exercise(name: "Wall Press", image: "exercise-3", detail: detail3), Exercise(name: "Wall Reach", image: "exercise-4", detail: detail4)]
    }
}
