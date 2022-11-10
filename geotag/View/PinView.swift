//
//  PinView.swift
//  geotag
//
//  Created by Ningze Dai on 11/9/22.
//

import SwiftUI

struct PinView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            Image("logo1")
                .resizable()
                .scaledToFit()
                .foregroundColor(.green)
                .frame(width: 30, height: 30)
                .font(.headline)
                .padding(1)
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.green)
                .frame(width: 10,height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .padding(.bottom, 40)
        }
       
    }
}

struct PinView_Previews: PreviewProvider {
    static var previews: some View {
        PinView()
    }
}
