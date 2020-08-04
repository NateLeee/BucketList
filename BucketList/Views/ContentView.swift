//
//  ContentView.swift
//  BucketList
//
//  Created by Nate Lee on 8/4/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Text("Hello World")
            .onTapGesture {
                let str = "Test Message - 2"
                
                let url = FileManager.default.getDocumentsDirectory().appendingPathComponent("message.txt")
                // let url = self.getDocumentsDir().appendingPathComponent("message.txt")
                
                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
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
