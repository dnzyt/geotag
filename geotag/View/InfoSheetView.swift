//
//  infoSheetView.swift
//  geotag
//
//  Created by Ningze Dai on 11/10/22.
//

import SwiftUI
import CoreLocation
import CoreLocationUI

struct InfoSheetView: View {

    @ObservedObject var club: Club
    @EnvironmentObject var vm: HomeViewVM
    @Environment(\.presentationMode) var presentationMode
    let persistenceController = PersistenceController.shared
    

    init(club: Club) {
        _club = ObservedObject(wrappedValue: club)
    }
    
    
    var body: some View {
        
        NavigationView {
                VStack {
                    List{
                        HStack {
                            Text("Club key:")
                            Spacer()
                            Text("\(vm.selectedClub?.clubKey ?? "error")")
                        }
                        HStack {
                            Text("Club name:")
                            Spacer()
                            Text("\(vm.selectedClub?.clubName ?? "error")")
                        }
                        HStack {
                            Text("Address:")
                            Spacer()
                            Text("\(vm.selectedClub?.addresss ?? "error")")
                                .frame(width: 300,alignment: .trailing)
                            
                        }
                        
                    }
                    .frame(width: 500,height: 300)
    //                Button(action: {
    //                    vm.updateCurrentClub()
    //                }, label: {
    //                    Text("Capture current location")
    //                    .frame(width: 300, height: 60)
    //                    .font(.system(size: 20))
    //                    .foregroundColor(.white)
    //                    .background(.blue)
    //                    .cornerRadius(5)
    //                })
                    LocationButton {
                        vm.updateCurrentClub()
                    }
                    .frame(width: 300, height: 60)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(5)

                    .navigationBarTitle("Club Information",displayMode: .inline)
                    .navigationBarItems(leading:
                                            Button {
                        
                    } label: {
                        Image(systemName: "arrowshape.turn.up.left")
                    }
                                        
                                        
                    )
                    .navigationBarItems(
                        trailing:
                            Button {
                                self.presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "square.and.arrow.up.on.square.fill")
                            }
                    )
                    
                }
            
            
            
           
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

