//
//  ApiModel.swift
//  Recipe
//
//  Created by 松田拓海 on 2022/09/05.
//

import Foundation

struct Rakuten: Codable {
    var result: Result
    
    struct Result: Codable {
        var small: [Food]
        var medium: [Food]
        var large: [LargeCate]
        
        struct Food: Codable {
            //実際の型(IntとかString)も揃えないといけない
            var categoryName: String
            var parentCategoryId: String
            var categoryId: Int
            var categoryUrl: String
        }
        
        struct LargeCate: Codable {
            var categoryName: String
            var categoryId: String
            var categoryUrl: String
        }
    }
}
func getRApi(){
    guard let url = URL(string: "https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426?format=json&categoryType=small&applicationId=1022216726251690877") else {return}
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, err)in
        if let err = err {
            print("情報の取得に失敗しました。:", err)
            return
        }
        if let data = data{
            do{
                let resultList = try JSONDecoder().decode(Rakuten.self, from: data)
                print("json: ", resultList)
            }catch(let err){
                print("データ情報の取得に失敗しました。:", err)
            }
        }
    }
    task.resume()
}

