//
//  RakutenRecipeModel.swift
//  Recipe
//
//  Created by 松田拓海 on 2022/09/26.
//

import Foundation

struct RakutenRecipeModel: Codable {
    
    let result: [Recipe]
    
    struct Recipe: Codable {
        let foodImageUrl :String
        let recipeTitle  :String
    }
}


//
//    struct Result: Codable, Identifiable {
//        var small: [Food]
//        var medium: [Food]
//        var large: [LargeCate]
//
//        struct Food: Codable,Identifiable {
//            var id: ObjectIdentifier
//
//            //実際の型(IntとかString)も揃えないといけない
//            var categoryName: String
//            var parentCategoryId: String
//            var categoryId: Int
//            var categoryUrl: String
//        }
//
//        struct LargeCate: Codable, Identifiable {
//            var categoryName: String
//            var categoryId: String
//            var categoryUrl: String
//        }
//    }
