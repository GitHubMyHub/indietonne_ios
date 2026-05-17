//
//  ContentView 2.swift
//  apple
//
//  Created by Doom Mortal on 16.03.26.
//

import SwiftUI

struct RegisterPage: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Form {
                TextField("Email adress", text: $email).textFieldStyle(DefaultTextFieldStyle())
                SecureField("Password", text: $password).textFieldStyle(DefaultTextFieldStyle())
                
                Button {
                    // Attempt login
                } label: {
                    ZStack {

                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.blue)
                        
                        Text("Login")
                            .foregroundColor(.white)
                            .padding(10)
                            .bold()
                    }
                }
                .padding()
            }
            
            VStack {
                
                Text("Don't have an account?")
                Button("Create an account") {
                    // Show registration
                }
            }
            .padding(.bottom, 50)
            
            Spacer()
        }
    }
}

#Preview {
    RegisterPage()
}
