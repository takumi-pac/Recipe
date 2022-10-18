//
//  CalenderView.swift
//  Recipe
//
//  Created by 松田拓海 on 2022/08/29.
//

import SwiftUI

struct CalenderView: View {
    // MARK: - PROPERTIES
    @State private var date = Date()
    
    // MARK: - BODY
    var body: some View {
        VStack (alignment: .trailing){
            DatePicker("Select Date", selection: $date)
                .datePickerStyle(GraphicalDatePickerStyle())

            Spacer()
            
        }
    }
}

struct CalenderView_Previews: PreviewProvider {
    static var previews: some View {
        CalenderView()
    }
}

