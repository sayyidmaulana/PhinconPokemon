//
//  CatchModel.swift
//  Phincon
//
//  Created by Sayyid Maulana Khakul Yakin on 28/10/21.
//

import UIKit
import Foundation
import CoreData

class CatchProvider {
    private func newTaskContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let taskContext = appDelegate.persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
    func getAllData(completion: @escaping(_ members: [Response]) -> ()){
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Phincon")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var members: [Response] = []
                for result in results {
                    let member = Response(

                        name: result.value(forKey: "name") as? String,
                        url: result.value(forKey: "url") as? String
                        
                        )
                    members.append(member)
                }
                completion(members)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func getData(_ id: Int, completion: @escaping(_ members: Response) -> ()){
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Phincon")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                if let result = try taskContext.fetch(fetchRequest).first{
                    let member = Response(
                        
                        name: result.value(forKey: "name") as? String,
                        url: result.value(forKey: "url") as? String
                        
                        )
                    completion(member)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func createData(_ name:String,_ url:String, completion: @escaping() -> ()){
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "Phincon", in: taskContext) {
                let member = NSManagedObject(entity: entity, insertInto: taskContext)
                member.setValue(name, forKeyPath: "name")
                member.setValue(url, forKeyPath: "url")
                do {
                    try taskContext.save()
                    completion()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }

     func deleteData(_ name: String, completion: @escaping() -> ()){
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Phincon")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "name == \(name)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult,
                batchDeleteResult.result != nil {
                completion()
            }
        }
    }
    
}
