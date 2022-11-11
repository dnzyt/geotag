//
//  infoSheetView.swift
//  geotag
//
//  Created by Ningze Dai on 11/10/22.
//

import SwiftUI
import CoreLocation
import CoreLocationUI

struct infoSheetView: View {
    
    @Binding var clubIndex: Int
    @Binding var clubs: [Club]
    @EnvironmentObject var locationManager: LocationManager
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                List{
                    HStack {
                        Text("Club key:")
                        Spacer()
                        Text("\(clubs[clubIndex].clubKey ?? "error")")
                    }
                    HStack {
                        Text("Club name:")
                        Spacer()
                        Text("\(clubs[clubIndex].clubName ?? "error")")
                    }
                    HStack {
                        Text("Address:")
                        Spacer()
                        Text("\(clubs[clubIndex].addresss ?? "error")")
                            .frame(width: 300,alignment: .trailing)

                    }
                    
                }
                .frame(width: 500,height: 300)
                LocationButton {
                  locationManager.requestLocation()
                    
                    
                }
                 .frame(width: 300, height: 60)
                 .font(.system(size: 20))
                 .foregroundColor(.white)
                 .background(.blue)
                 .cornerRadius(5)
                
                
//                Button {
//                    locationManager.requestLocation()
//                } label: {
//                    HStack{
//                        Image(systemName: "scope")
//                        Text("Capture current locatoin")
//
//                    }
//                    .frame(width: 300, height: 60)
//                    .font(.system(size: 20))
//                    .foregroundColor(.white)
//                    .background(.blue)
//                    .cornerRadius(5)
//                    // .padding(.top, 300)
//
//
//                }
                .navigationBarTitle("Club Information",displayMode: .inline)
                .navigationBarItems(leading:
                                        Button {
                    
                } label: {
                    Image(systemName: "arrowshape.turn.up.left")
                }
                                    
                                    
                )
                .navigationBarItems(trailing:
                                        Button {
                    
                } label: {
                    Image(systemName: "square.and.arrow.up.on.square.fill")
                }
                                    
                                    
                )
                
                
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    //    struct infoSheetView_Previews: PreviewProvider {
    //        static var previews: some View {
    //            infoSheetView(clubIndex: cl, clubs: <#T##Binding<[Club]>#>)
    //        }
    //    }
    //}
}
