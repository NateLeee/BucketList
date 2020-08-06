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
import LocalAuthentication


struct UnlockedView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    
    @Binding var selectedPlaceAnnotation: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    @Binding var locations: [CodableMKPointAnnotation]
    @Binding var showingEditScreen: Bool
    
    var hasNotch: Bool {
        return UIScreen.main.bounds.height >= 812
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                MapView(
                    centerCoordinate: self.$centerCoordinate,
                    selectedPlaceAnnotation: self.$selectedPlaceAnnotation,
                    showingPlaceDetails: self.$showingPlaceDetails,
                    annotations: self.locations
                )
                    .edgesIgnoringSafeArea(.all)
                
                Circle()
                    .fill(Color.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                
                // "+" Button
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            // Create a new location
                            let newLocation = CodableMKPointAnnotation()
                            // Do something
                            newLocation.title = "Example Title"
                            newLocation.subtitle = "Example Subtitle"
                            newLocation.coordinate = self.centerCoordinate
                            
                            self.selectedPlaceAnnotation = newLocation
                            self.locations.append(newLocation)
                            self.showingEditScreen = true
                            
                        }) {
                            Image(systemName: "plus")
                                .padding()
                                .background(Color.black.opacity(0.63))
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(Circle())
                                .shadow(color: .black, radius: 18, x: 0, y: 0)
                                .padding(self.hasNotch ? [.trailing] : [.trailing, .bottom])
                        }
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    @State private var isUnlocked = false
    
    //    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var selectedPlaceAnnotation: MKPointAnnotation? // This is necessary!
    @State private var locations = [CodableMKPointAnnotation]() // This is necessary!
    
    @State private var showingPlaceDetails: Bool = false
    @State private var showingEditScreen = false
    
    
    var body: some View {
        ZStack {
            if (isUnlocked) {
                UnlockedView(selectedPlaceAnnotation: $selectedPlaceAnnotation, showingPlaceDetails: $showingPlaceDetails, locations: $locations, showingEditScreen: $showingEditScreen)
            } else {
                // Unlock Button
                Button("Unlock") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
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
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if self.selectedPlaceAnnotation != nil {
                EditView(placemark: self.selectedPlaceAnnotation!)
            }
        }
        .onAppear(perform: loadData)
    }
    
    // Custom Funcs Go Below.
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        
        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                    }
                }
            }
        } else {
            // no biometrics
        }
    }
}
