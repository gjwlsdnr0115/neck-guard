//
//  DataManager+Daily.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/05/19.
//

import Foundation
import CoreData

extension DataManager {
    
    func createDaily(date: Date, goodPostureTime: Double? = nil, badPostureTime: Double? = nil, exerciseNum: Int? = nil) {
        mainContext.perform {
            let newDaily = DailyEntity(context: self.mainContext)
            newDaily.date = date
            
            if let goodPostureTime = goodPostureTime {
                newDaily.goodPostureTime = goodPostureTime
            }
            
            if let badPosturetime = badPostureTime {
                newDaily.badPostureTime = badPosturetime
            }
            
            if let exerciseNum = exerciseNum {
                newDaily.exerciseNum = Int16(exerciseNum)
            }
            
            self.saveMainContext()
        }
    }
    
    func fetchDaily() -> [DailyEntity] {
        
        var list = [DailyEntity]()
        mainContext.performAndWait {
            let request: NSFetchRequest<DailyEntity> = DailyEntity.fetchRequest()
            let sortByDate = NSSortDescriptor(key: #keyPath(DailyEntity.date), ascending: false)
            request.sortDescriptors = [sortByDate]
            
            do {
                list = try mainContext.fetch(request)
            } catch {
                print(error)
            }
        }
        
        return list
    }
    
    
    
    
    
}
