//
//  ContentView.swift
//  BucketList
//
//  Created by Nate Lee on 8/4/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import Foundation
import SwiftUI


struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}


struct ContentView: View {
    enum LoadingState {
        case loading, success, failed
    }
    
    var loadingState: LoadingState = .loading
    
    var body: some View {
        Group {
            if loadingState == .success {
                SuccessView()
            } else if (loadingState == .loading) {
                LoadingView()
            } else if (loadingState == .failed) {
                FailedView()
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
