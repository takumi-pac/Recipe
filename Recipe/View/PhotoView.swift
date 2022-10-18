//
//  PhotoView.swift
//  Recipe
//
//  Created by 松田拓海 on 2022/10/04.
//

import SwiftUI

struct PhotoView: View {
    @State private var recipeImage = UIImage()
    @State private var isShowPhotoLibrery = false
    
    var body: some View {
        VStack(spacing: 20) {
            Image(uiImage: self.recipeImage)
                .resizable()
                .scaledToFill()
                .padding(.top)
                .frame(width: 240, height: 80)
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            Button(action: {
                self.isShowPhotoLibrery = true
            }, label: {
                Text("Photo Library")
            })
            Spacer()
        }
        .sheet(isPresented: $isShowPhotoLibrery, content: {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$recipeImage)
        })
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView()
            .previewLayout(.sizeThatFits)
    }
}
