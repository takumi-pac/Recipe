//
//  RegisterMenuView.swift
//  Recipe
//
//  Created by 松田拓海 on 2022/10/04.
//

import SwiftUI
import Firebase

struct RegisterMenuView: View {
    // MARK: - PROPERTIES
    @State var id = ""
    @State var name = ""
    @State var ingredient = ""
    @State private var recipeImage = UIImage()
    @State private var isShowPhotoLibrery = false
    
    // MARK: - BODY
    var body: some View {
        
        VStack {
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
                    Text("select photo")
                    Image(systemName: "photo")
                })
            }
            .sheet(isPresented: $isShowPhotoLibrery, content: {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$recipeImage)
            })
            
            TextField(text: $name) {
                Text("レシピ名")
            }
            .frame(width: 240, height: 40)
            TextField(text: $ingredient) {
                Text("材料名")
            }
            .frame(width: 240, height: 40)
            
            Button(action: {
                guard let user = Auth.auth().currentUser else {
                    //ログインしていないユーザーの処理
                    return
                }
                let db = Firestore.firestore()
                db.collection("recipe").document(user.uid).setData([
                    "recipeName" : name,
                    "ingredient" : ingredient,
                    //画像を文字列に変換してデータベースに保存
                    "recipeImage" : convertImageToBase64(recipeImage)!
                ])
            }, label: {
                Text("登録")
            })
        }
    }
}

struct RegisterMenuView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterMenuView()
    }
}
