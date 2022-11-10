//
//  ContentView.swift
//  geotag
//
//  Created by Ningze Dai on 11/6/22.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @EnvironmentObject var authentication: Authentication

    @ObservedObject var loginVM = LoginVM()
    
    var body: some View {
        ZStack {
            Color.green
            Text("v1.0.0")
                .foregroundColor(.white)
                .offset(x: UIScreen.screenWidth / 2 - 60, y: -UIScreen.screenHeight / 2 + 70)
            VStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
                    .padding(.bottom, 40)

                VStack {
                    TextField("Username",text: $loginVM.username)
                        .padding()
                        .frame(width: 300, height: 40)
                        .textFieldStyle(PlainTextFieldStyle())

                       Divider()
                        .frame(width: 296)
                        //.background(Color.white)

                    TextField("Password", text: $loginVM.password)
                        .padding()
                        .frame(width: 300, height: 40)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                .background(.white)
                .cornerRadius(5)



                Button {
                    loginVM.login { success in
                        print("login result: \(success)")
                        authentication.updateValidation(success: success)
                    }
                } label: {
                    Text("Login")
                        .foregroundColor(Color.white)
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .padding(.top, 10)
                }


            }
            
            
        }
        .edgesIgnoringSafeArea(.all)
    
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
