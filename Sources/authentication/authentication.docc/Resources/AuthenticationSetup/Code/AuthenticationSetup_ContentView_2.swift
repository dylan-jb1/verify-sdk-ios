//
//  ContentView.swift
//  AuthTest
//
//  Created by Dylan Bowler on 26/5/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var authorizationURL: String = ""
    @State private var tokenURL: String = ""
    @State private var clientID: String = ""
    @State private var redirectURL: String = "verifysdk://auth/callback"
    @State private var shareSession: Bool = true
    @State private var includeState: Bool = false
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

