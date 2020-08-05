//
//  ContentView.swift
//  BucketList
//
//  Created by Nate Lee on 8/4/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import Foundation
import SwiftUI
import LocalAuthentication



struct ContentView: View {
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if (isUnlocked) {
                Text("Unlocked!")
            } else {
                Text("Locked.")
            }
        }
        .onAppear(perform: authenticate)
        
    }
    
    // Custom Funcs Go Below.
    func authenticate() {
        let laContext = LAContext()
        var error: NSError?
        
        // check whether biometric authentication is possible
        if (laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."
            
            laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, authenticationError) in
                DispatchQueue.main.async {
                    if (success) {
                        // authenticated successfully
                        self.isUnlocked = true
                    } else {
                        // Failed!
                        self.isUnlocked = false
                    }
                }
            }
        } else {
            print("no biometrics")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
