//
//  SearchView.swift
//  Recipe
//
//  Created by 松田拓海 on 2022/09/06.
//

import SwiftUI

struct SearchView: View {
    @State var searchText: String = ""
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "magnifyingglass")
            TextField("Search Menu", text: $searchText)
        }
        .padding()
        .background(Color(.systemGray))
        .cornerRadius(8.0)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .previewLayout(.fixed(width: 375, height: 485))
    }
}
