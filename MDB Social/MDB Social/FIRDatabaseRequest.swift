//
//  FIRDatabaseRequest.swift
//  MDB Social
//
//  Created by Michael Lin on 2/25/21.
//

import Foundation
import FirebaseFirestore

class FIRDatabaseRequest {
    
    static let shared = FIRDatabaseRequest()
    
    let db = Firestore.firestore()
    
    var events = [Event]()
    
    func setUser(_ user: User, completion: (()->Void)?) {
        guard let uid = user.uid else { return }
        do {
            try db.collection("users").document(uid).setData(from: user)
            completion?()
        }
        catch { }
    }
    
    func setEvent(_ event: Event, completion: (()->Void)?) {
        guard let id = event.id else { return }
        
        do {
            try db.collection("events").document(id).setData(from: event)
            completion?()
        } catch { }
    }
    
    /* TODO: Events getter */
    func getEvents(reloadFeed: @escaping () -> Void) {
        
        do {
            try db.collection("events").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.data())")
                        try! self.events.append(document.data(as: Event.self)!)
//                        print("Events2: \(self.events)")
                        
//                        print("In do: \(events)")
//                        events.append(document.data())
                    }
                    reloadFeed()
                }
            }
        } catch { }

//        print("Events: \(self.events)")
//        print("Out of Do: \(events)")
//        return events
    }
    
}
