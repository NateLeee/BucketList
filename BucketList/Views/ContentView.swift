//
//  ContentView.swift
//  BucketList
//
//  Created by Nate Lee on 8/4/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit


struct ContentView: View {
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, annotations: locations)
                .edgesIgnoringSafeArea(.all)
            
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        // TODO: - create a new location
                        let newLocation = MKPointAnnotation()
                        newLocation.coordinate = self.centerCoordinate
                        
                        self.locations.append(newLocation)
                        
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color.black.opacity(0.63))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .shadow(color: .black, radius: 18, x: 0, y: 0)
                    .padding([.trailing, .bottom])
                }
            }
        }
    }
    
    // Custom Funcs Go Below.
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
