//
//  MenuRowView.swift
//  Recipe
//
//  Created by 松田拓海 on 2022/10/03.
//

import SwiftUI
import SDWebImageSwiftUI

struct MenuRowView: View {
    // MARK: - PROPERTIES
    var id = ""
    var name = ""
    var ingredient = ""
    var recipeImage = ""
//    var date = ""
    
    static let formatter = RelativeDateTimeFormatter()
    
    var body: some View {
        VStack (alignment: .leading){
            Text(name)
                .font(.title3)
                .fontWeight(.bold)
            
            VStack{
                WebImage(url: URL(string: self.recipeImage))
                    .resizable()
                    .frame(width: 130, height: 130)
                    .cornerRadius(12.0, antialiased: true)
            }
            
            Text("材料")
            Text(ingredient)
                .font(.headline)
                .fontWeight(.semibold)
            
            Spacer()
        }
    }
}

struct MenuRowView_Previews: PreviewProvider {
    static var previews: some View {
        MenuRowView()
    }
}
