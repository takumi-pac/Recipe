//
//  HomeView.swift
//  Recipe
//
//  Created by 松田拓海 on 2022/10/03.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            Menuview()
                .tabItem {
                    Image(systemName: "flame")
                }
            CalenderView()
                .tabItem {
                    Image(systemName: "flame")
                }
            RegisterMenuView()
                .tabItem {
                    Image(systemName: "pencil")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
