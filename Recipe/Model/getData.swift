//
//  getData.swift
//  Recipe
//
//  Created by 松田拓海 on 2022/10/03.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseDatabase

class getData: ObservableObject {
    @Published var datas = [Recipe]()
    
    init() {
        let db = Firestore.firestore()
        
        db.collection("recipe").order(by: "id", descending: true).addSnapshotListener { (snap, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges{
                if i.type == .added {
                    let id = i.document.documentID
                    let name = i.document.get("name") as! String
                    let ingredient = i.document.get("ingredient") as! String
                    let recipeImage = i.document.get("recipeImage") as! String
                    
//                    let date = i.document.get("date") as! Timestamp
//
//                    let formatDate = DateFormatter()
//                    formatDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//                    let createDate = formatDate.string(from: date.dateValue())
                    
                    DispatchQueue.main.async {
                        self.datas.append(Recipe(id: id, name: name, ingredient: ingredient, recipeImage: recipeImage))
                    }
                }
            }
        }
    }
}
