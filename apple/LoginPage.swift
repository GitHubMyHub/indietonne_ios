//
//  LoginPage.swift
//  apple
//
//  Created by Doom Mortal on 16.03.26.
//

import SwiftUI

enum AuthType {
    case login
    case register
}

struct LoginPage: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var authType: AuthType = .login
    @State private var email: String = ""
    @State private var password: String = ""
    
    @FocusState private var isEmailFocused
    @FocusState private var isPasswordFocused
    
    @State private var showPass = false
    
    var body: some View {
        VStack {
            HStack (spacing:0) {
                Button {
                    withAnimation {
                        authType = .login
                    }
                } label: {
                    Text ("Login")
                        .fontWeight(authType == .login ? .semibold : .regular)
                        .foregroundStyle(authType == .login ? (colorScheme == .light ? Color(uiColor: UIColor.darkGray) :
                                .white): .gray)
                        .padding(.vertical, 12)
                        .padding(.horizontal, authType == .login ? 30 : 20)
                        .background(
                            ZStack {
                                if authType == .login {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.black.opacity(0.3),
                                                lineWidth: 0.5)
                                        .zIndex(1)
                                }
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(authType == .login ?
                                          Color (UIColor.systemGray5) :
                                            Color (UIColor.systemGray6))
                                    .zIndex(0)
                            }
                        )
                }
                
                Button {
                    withAnimation {
                        authType = .register
                    }
                } label: {
                    Text ("Login")
                        .fontWeight(authType == .register ? .semibold : .regular)
                        .foregroundStyle(authType == .register ? (colorScheme == .light ? Color(uiColor: UIColor.darkGray) :
                                .white): .gray)
                        .padding(.vertical, 12)
                        .padding(.horizontal, authType == .login ? 30 : 20)
                        .background(
                            ZStack {
                                if authType == .register {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.black.opacity(0.3),
                                                lineWidth: 0.5)
                                        .zIndex(1)
                                }
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(authType == .register ?
                                          Color (UIColor.systemGray5) :
                                            Color (UIColor.systemGray6))
                                    .zIndex(0)
                            }
                        )
                }
                
                
                
                
            }
        }
        .background(
            Color(UIColor.systemGray6)
            
        )
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        .frame(maxWidth: .infinity)
    }
}


struct TopView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode:.fit)
                .frame(width: 75)
            
            Text("AuthFlow")
                .font(.system(size: 35, weight: .bold, design: .rounded))
        }
    }
}


#Preview {
    LoginPage()
}
