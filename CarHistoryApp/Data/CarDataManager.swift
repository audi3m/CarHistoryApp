//
//  CarDataManager.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/15/24.
//

import SwiftUI
import RealmSwift

final class CarDataManager {
    static let shared = CarDataManager()
    private init() { }
    
    let realm = try! Realm()
    
    @ObservedResults(Car.self) var cars
    @ObservedResults(CarHistory.self) var historyList
    
    func addNewCar(car: Car) {
        $cars.append(car)
    }
    
    func deleteCar(car: Car) {
        $cars.remove(car)
    }
    
    func printDirectory() {
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "NOT FOUND")
    }
    
    func addNewHistory(history: CarHistory) {
        $historyList.append(history)
    }
    
    func deleteHistory(history: CarHistory) {
        $historyList.remove(history)
    }
    
}

// 자동차 이미지 저장
extension CarDataManager {
    
    func saveImageToDocument(image: UIImage, filename: String) {
        
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }
        
        //이미지를 저장할 경로(파일명) 지정
        let fileURL = documentDirectory.appendingPathComponent("\(filename).png")
        
        //이미지 압축
        guard let data = image.pngData() else { return }
        
        //이미지 파일 저장
        do {
            try data.write(to: fileURL)
        } catch {
            print("File save error", error)
        }
    }
    
    func loadImageToDocument(filename: String) -> UIImage? {
        
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return nil }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).png")
        
        //이 경로에 실제로 파일이 존재하는 지 확인
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path())
        } else {
            return nil
        }
    }
    
    func removeImageFromDocument(filename: String) {
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).png")
        
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            
            do {
                try FileManager.default.removeItem(atPath: fileURL.path())
            } catch {
                print("File remove error", error)
            }
            
        } else {
            print("File does not exist")
        }
    }
    
}


//actor RealmActor {
//    
//    var realm: Realm!
//    init() async throws {
//        realm = try await Realm(actor: self)
//    }
//
//    var count: Int {
//        realm.objects(Todo.self).count
//    }
//    
//    func createTodo(name: String, owner: String, status: String) async throws {
//        try await realm.asyncWrite {
//            realm.create(Todo.self, value: [
//                "_id": ObjectId.generate(),
//                "name": name,
//                "owner": owner,
//                "status": status
//            ])
//        }
//    }
//    
//    func getTodoOwner(forTodoNamed name: String) -> String {
//        let todo = realm.objects(Todo.self).where {
//            $0.name == name
//        }.first!
//        return todo.owner
//    }
//    
//    struct TodoStruct {
//        var id: ObjectId
//        var name, owner, status: String
//    }
//    
//    func getTodoAsStruct(forTodoNamed name: String) -> TodoStruct {
//        let todo = realm.objects(Todo.self).where {
//            $0.name == name
//        }.first!
//        return TodoStruct(id: todo._id, name: todo.name, owner: todo.owner, status: todo.status)
//    }
//    
//    func updateTodo(_id: ObjectId, name: String, owner: String, status: String) async throws {
//        try await realm.asyncWrite {
//            realm.create(Todo.self, value: [
//                "_id": _id,
//                "name": name,
//                "owner": owner,
//                "status": status
//            ], update: .modified)
//        }
//    }
//    
//    func deleteTodo(id: ObjectId) async throws {
//        try await realm.asyncWrite {
//            let todoToDelete = realm.object(ofType: Todo.self, forPrimaryKey: id)
//            realm.delete(todoToDelete!)
//        }
//    }
//    
//    func close() {
//        realm = nil
//    }
//    
//}

