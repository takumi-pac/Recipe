//
//  RegisterMenuView.swift
//  Recipe
//
//  Created by 松田拓海 on 2022/10/04.
//

import SwiftUI
import Firebase
import FirebaseStorage

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
                    "ingredient" : ingredient
                ])
                
                //firestore Storageに画像保存
                let storage = Storage.storage()
                let storageRef = storage.reference()
                let path = "gs://recipe-896e2.appspot.com/Recipe"
                let imageRef = storageRef.child(path)
                
                guard let data = recipeImage.pngData() else {
                    return
                }
                let uploadTask = imageRef.putData(data)
                
                var downloadURL: URL?
                //成功時の処理
                uploadTask.observe(.success) { _ in
                    imageRef.downloadURL{url, error in
                        if let url = url {
                            downloadURL = url
                        }
                    }
                }
                //失敗時の処理
                uploadTask.observe(.failure) { snapshot in
                    if let message = snapshot.error?.localizedDescription {
                        print(message + "アップロード失敗")
                    }
                }
                
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
