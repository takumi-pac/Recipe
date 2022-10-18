//
//  LoginView.swift
//  Recipe
//
//  Created by 松田拓海 on 2022/08/29.
//

import SwiftUI
import FirebaseAuth
import AuthenticationServices

struct LoginView: View {
    
    //    @ObservedObject var viewModel: LoginViewModel
    //
    //    init(viewModel: LoginViewModel){
    //        self.viewModel = viewModel
    //    }
    
    @State private var isHomeView: Bool = false
    @State var newEmail: String = ""
    @State var newPassword: String = ""
    
    @State var email: String = ""
    @State var password: String = ""
    // TextFieldに入力した文字が半角英数かどうか判別する変数
    @State var isValidEmail: Bool = false
    @State var isValidPassword: Bool = false
    @State var isNewLoginButtonTapped: Bool = false
    @State var isLoginButtonTapped: Bool = false
    
    @State var errorMessage: String = ""
    
    var body: some View {
        VStack(spacing: 30){
            // メールアドレス
            TextField("メールアドレスを入力してください",text: $newEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
            
            // パスワード
            SecureField("パスワードを入力してください",text:$newPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
            
            // 認証
            Button(action: {
                Auth.auth().createUser(withEmail: self.newEmail, password: self.newPassword) { authResult, error in
                    if error == nil {
                        // do something
                        isHomeView.toggle()
                    } else {
                        if let errCode = AuthErrorCode.Code(rawValue: error!._code) {
                            switch errCode {
                            case .invalidEmail:
                                self.errorMessage = "メールアドレスの形式が違います。"
                                // メールアドレスの形式が違います。
                            case .emailAlreadyInUse:
                                self.errorMessage = "このメールアドレスはすでに使われています。"
                                // このメールアドレスはすでに使われています。
                            case .weakPassword:
                                self.errorMessage = "パスワードは6文字以上で入力してください。"
                                // パスワードは6文字以上で入力してください。
                            default:
                                // エラーが起きました。\nしばらくしてから再度お試しください。
                                self.errorMessage = "エラーが起きました。\nしばらくしてから再度お試しください。"
                            }
                        }
                    }
                }
            }) {
                Text("新規登録")
            }//BUTTON
            .frame(width: 200, height: 45)
            .foregroundColor(Color.white)
            .background(Color.gray)
            .sheet(isPresented: $isHomeView) {
                HomeView()
            }
            
            // メールアドレス
            TextField("メールアドレスを入力してください",text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
            
            // パスワード
            SecureField("パスワードを入力してください",text:$password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
            
            // 認証
            Button(action: {
                print("ログイン処理")
                Auth.auth().signIn(withEmail: self.email, password: self.password) { authResult, error in
                    if authResult?.user != nil {
                        // ログイン成功処理
                        print("success")
                        isHomeView.toggle()
                    } else {
                        // ログイン失敗処理
                        if let error = error as NSError?, let errorCode = AuthErrorCode.Code(rawValue: error.code) {
                            switch errorCode {
                            case .invalidEmail:
                                self.errorMessage = "メールアドレスの形式が正しくありません"
                            case .userNotFound, .wrongPassword:
                                self.errorMessage = "メールアドレス、またはパスワードが間違っています"
                            case .userDisabled:
                                self.errorMessage = "このユーザーアカウントは無効化されています"
                            default:
                                self.errorMessage = "ログイン失敗" + error.domain
                            }
                        }
                    }
                }
            }) {
                Text("ログイン")
            }//BUTTON
            .frame(width: 200, height: 45)
            .foregroundColor(Color.white)
            .background(Color.gray)
            .fullScreenCover(isPresented: $isHomeView) {
                HomeView()
            }
        } //VSTACK
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewDevice("iPhone 12")
    }
}
