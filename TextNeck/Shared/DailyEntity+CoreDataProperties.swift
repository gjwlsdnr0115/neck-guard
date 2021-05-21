//
//  DailyEntity+CoreDataProperties.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/05/19.
//
//

import Foundation
import CoreData


extension DailyEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyEntity> {
        return NSFetchRequest<DailyEntity>(entityName: "Daily")
    }

    @NSManaged public var date: String?
    @NSManaged public var goodPostureTime: Double
    @NSManaged public var badPostureTime: Double
    @NSManaged public var exerciseNum: Int16
    @NSManaged public var moreThanThree: Bool

}

extension DailyEntity : Identifiable {

}
