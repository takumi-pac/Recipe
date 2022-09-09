//
//  loginViewModel.swift
//  Recipe
//
//  Created by 松田拓海 on 2022/09/02.
//

import FirebaseAuth
import Combine
import AuthenticationServices
import Foundation
import UIKit
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var newEmail: String = ""
    @Published var newPassword: String = ""
    
    @Published var email: String = ""
    @Published var password: String = ""
    // TextFieldに入力した文字が半角英数かどうか判別する変数
    @Published var isValidEmail: Bool = false
    @Published var isValidPassword: Bool = false
    
    @Published var isNewLoginButtonTapped: Bool = false
    @Published var isLoginButtonTapped: Bool = false
    
    //@Published var appleAuthResults: Result<ASAuthorization, Error>?
    
    private var disposables = [AnyCancellable]()
    @State var errorMessage: String = ""
    
    init() {
        $newEmail
            .sink(receiveValue: {
                self.isValidEmail = $0.isValidEmail && !$0.isEmpty ? true : false
            })
            .store(in: &disposables)
        
        $newPassword
            .sink(receiveValue: {
                self.isValidPassword = $0.isAlphanumeric && !$0.isEmpty ? true : false
            })
            .store(in: &disposables)
        
        $isNewLoginButtonTapped
            .sink(receiveValue: { isTapped in
                if isTapped == true {
                    Auth.auth().createUser(withEmail: self.newEmail, password: self.newPassword) { authResult, error in
                        if error == nil {
                                // do something
                            Menuview()
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
                    
                    
                }
            })
            .store(in: &disposables)
        
        $email
            .sink(receiveValue: {
                self.isValidEmail = $0.isValidEmail && !$0.isEmpty ? true : false
            })
            .store(in: &disposables)
        
        $password
            .sink(receiveValue: {
                self.isValidPassword = $0.isAlphanumeric && !$0.isEmpty ? true : false
            })
            .store(in: &disposables)
        
        $isLoginButtonTapped
            .sink(receiveValue: { isTapped in
                if isTapped == true {
                    print("ここでログイン処理を呼び出す")
                    Auth.auth().signIn(withEmail: self.email, password: self.password) { authResult, error in
                        if authResult?.user != nil {
                            // ログイン成功処理
                            print("success")
                            Menuview()
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
                                    self.errorMessage = error.domain
                                }
                            }
                        }
                    }
                }
            })
            .store(in: &disposables)
        
//        $appleAuthResults
//            .sink(receiveValue: { results in
//                switch results {
//                case .success(let authResults):
//                    switch authResults.credential {
//                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
//                        print("userIdentifier:\(appleIDCredential.user)")
//                        print("fullName:\(String(describing: appleIDCredential.fullName))")
//                        print("email:\(String(describing: appleIDCredential.email))")
//                        print("authorizationCode:\(String(describing: appleIDCredential.authorizationCode))")
//
//                        print("ここでログイン処理を呼び出す")
//
//                    default:
//                        break
//                    }
//
//                case .failure(let error):
//                    print(error.localizedDescription)
//
//                default:
//                    break
//                }
//            })
//            .store(in: &disposables)
    }
}
