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
    @State private var selectedPlaceAnnotation: MKPointAnnotation?
    @State private var showingPlaceDetails: Bool = false
    @State private var locations = [MKPointAnnotation]()
    @State private var showingEditScreen = false
    
    var hasNotch: Bool {
        return UIScreen.main.bounds.height >= 812
    }
    
    var body: some View {
        ZStack {
            MapView(
                centerCoordinate: $centerCoordinate,
                selectedPlaceAnnotation: $selectedPlaceAnnotation,
                showingPlaceDetails: $showingPlaceDetails,
                annotations: locations
            )
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
                        // Create a new location
                        let newLocation = MKPointAnnotation()
                        // Do something
                        newLocation.title = "Example Title"
                        newLocation.subtitle = "Example Subtitle"
                        newLocation.coordinate = self.centerCoordinate
                        
                        self.selectedPlaceAnnotation = newLocation
                        self.locations.append(newLocation)
                        self.showingEditScreen = true
                        
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color.black.opacity(0.63))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .shadow(color: .black, radius: 18, x: 0, y: 0)
                    .padding(hasNotch ? [.trailing] : [.trailing, .bottom])
                }
            }
        }
        .alert(isPresented: $showingPlaceDetails) {
            Alert(
                title: Text(selectedPlaceAnnotation?.title ?? "Unknown"),
                message: Text(selectedPlaceAnnotation?.subtitle ?? "Missing place information."),
                primaryButton: .default(Text("OK")),
                secondaryButton: .default(Text("Edit")) {
                    // edit this place
                    self.showingEditScreen = true
                })
        }
        .sheet(isPresented: $showingEditScreen) {
            if self.selectedPlaceAnnotation != nil {
                EditView(placemark: self.selectedPlaceAnnotation!)
            }
        }
    }
    
    // Custom Funcs Go Below.
    
}
