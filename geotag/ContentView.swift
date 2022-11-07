//
//  ContentView.swift
//  geotag
//
//  Created by Ningze Dai on 11/6/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var username: String = ""
    @State var password: String = ""

    @EnvironmentObject var authentication: Authentication

    
    var body: some View {
        ZStack {
            Color.green
            VStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
                    .padding(.bottom,40)
                
                VStack {
                    TextField("Username",text: $username)
                            .font(Font.system(size: 30))
                            .foregroundColor(.gray)
                            .frame(width: 300, height: 50)
                            .textFieldStyle(PlainTextFieldStyle())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                       Divider()
                        .frame(width: 296)
                        //.background(Color.white)
                    
                    TextField("Password", text: $password)
                            .font(Font.system(size: 30))
                            .foregroundColor(Color.black)
                           // .background(Color.white)
                            .frame(width: 300, height: 50)
                            .textFieldStyle(PlainTextFieldStyle())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                }
                .background(.white)
                .cornerRadius(5)

               
                                        
                Button {
                    
                } label: {
                    Text("Login")
                        .foregroundColor(Color.white)
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        //.cornerRadius(20.0)
                        .padding(.top, 10)
                }

                
                
                
            }
            
            Spacer()
            
        }
    
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
