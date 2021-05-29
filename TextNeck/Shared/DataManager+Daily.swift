//
//  DataManager+Daily.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/05/19.
//

import Foundation
import CoreData

extension DataManager {
    
    func createDaily(date: String, goodPostureTime: Double? = nil, badPostureTime: Double? = nil, exerciseNum: Int? = nil, completion: (() -> ())? = nil) {
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
            
            if newDaily.exerciseNum > 3 {
                newDaily.moreThanThree = true
            }
            
            self.saveMainContext()
            completion?()
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
    
    func updateDaily(entity: DailyEntity, goodPostureTime: Double? = nil, badPostureTime: Double? = nil, exerciseNum: Int? = nil, completion: (()-> ())? = nil) {
        mainContext.perform {
            if let goodPostureTime = goodPostureTime {
                entity.goodPostureTime = goodPostureTime
            }
            
            if let badPostureTime = badPostureTime {
                entity.badPostureTime = badPostureTime
            }
            
            if let exerciseNum = exerciseNum {
                entity.exerciseNum = Int16(exerciseNum)
            }
            
            if entity.exerciseNum > 3 {
                entity.moreThanThree = true
            }
            
            self.saveMainContext()
            completion?()
        }
    }
    
    func delete(entity: DailyEntity) {
        mainContext.perform {
            self.mainContext.delete(entity)
            self.saveMainContext()
        }
    }
    
    func fetchByDate(date: String) -> Double {
        var list = [DailyEntity]()
        mainContext.performAndWait {
            let request: NSFetchRequest<DailyEntity> = DailyEntity.fetchRequest()
            let predicate = NSPredicate(format: "date == %@", date)
            request.predicate = predicate
            
            do {
                list = try mainContext.fetch(request)
            } catch {
                print(error)
            }
        }
        let goodPoseTimes = list.map { $0.goodPostureTime }
        let badPoseTimes = list.map { $0.badPostureTime }
        
        guard goodPoseTimes.count != 0, badPoseTimes.count != 0 else {
            print("no data for date \(date)")
            return 0.0
        }
        
        let goodPoseTime = goodPoseTimes.first
        let badPoseTime = badPoseTimes.first
        
        guard goodPoseTime != nil, badPoseTime != nil else {
            return 0.0
        }
        
        let totalTime = goodPoseTime! + badPoseTime!
        
        var value = 0.0
        
        if totalTime != 0.0 {
            value = goodPoseTime! / totalTime
        }
        
        return value
    }
    
    func fetchByExerciseNum(num: Int) -> [String] {
        var list = [DailyEntity]()
        mainContext.performAndWait {
            let request: NSFetchRequest<DailyEntity> = DailyEntity.fetchRequest()
            let predicate = NSPredicate(format: "exerciseNum == \(num)")
            request.predicate = predicate
            
            do {
                list = try mainContext.fetch(request)
            } catch {
                print(error)
            }
        }
        let dates = list.map { $0.date ?? "" }
        return dates
        
    }
    
    func fetchMoreThanThree() -> [String] {
        var list = [DailyEntity]()
        mainContext.performAndWait {
            let request: NSFetchRequest<DailyEntity> = DailyEntity.fetchRequest()
            let predicate = NSPredicate(format: "moreThanThree == \(NSNumber(value:true))")
            request.predicate = predicate
            
            do {
                list = try mainContext.fetch(request)
            } catch {
                print(error)
            }
        }
        let dates = list.map { $0.date ?? "" }
        return dates
    }
    
    
}
