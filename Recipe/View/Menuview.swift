//
//  Menuview.swift
//  Recipe
//
//  Created by 松田拓海 on 2022/08/29.
//

import SwiftUI

struct Menuview: View {
    init() {
        getRApi()
    }
    @State private var searchText: String = ""
    
    var body: some View {
        
        NavigationView {
            //            List(menuVM.data) { menuData in
            //                VStack(alignment: .leading) {
            //
            //
            //                }
            //            }
        }
        Text("")
    }
}

struct Menuview_Previews: PreviewProvider {
    static var previews: some View {
        Menuview()
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
                let resultList = try JSONDecoder().decode(RakutenRecipeModel.self, from: data)
                print("json: ", RakutenRecipeModel.self)
            }catch(let err){
                print("情報の取得に失敗しました。:", err)
            }
        }
    }
    task.resume()
}
