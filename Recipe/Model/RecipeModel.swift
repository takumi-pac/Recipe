//
//  RecipeModel.swift
//  Recipe
//
//  Created by 松田拓海 on 2022/10/03.
//

import Foundation
import FirebaseFirestore

struct Recipe: Identifiable {
    var id: String
    var name: String
    var ingredient: String
    var recipeImage: String
//    var date: Date
}
