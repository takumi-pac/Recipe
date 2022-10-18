//
//  Menuview.swift
//  Recipe
//
//  Created by 松田拓海 on 2022/08/29.
//

import SwiftUI
import Firebase
import SDWebImage
import SDWebImageSwiftUI

struct Menuview: View {
    // MARK: - PROPERTIES
    @ObservedObject var obserbedData = getData()
    
    // MARK: - BODY
    var body: some View {
        List(obserbedData.datas) { recipe in
            MenuRowView(id: recipe.id, name: recipe.name, ingredient: recipe.ingredient, recipeImage: recipe.recipeImage)
        }.environment(\.defaultMinListRowHeight, 391)
    }
}

struct Menuview_Previews: PreviewProvider {
    static var previews: some View {
        Menuview()
    }
}
