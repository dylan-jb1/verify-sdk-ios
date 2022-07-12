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
        NavigationView {
            VStack(spacing: 16) {
                Spacer()
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
        
                VStack(spacing: 8) {
                    Text("This sample app demonstrates initiating an OAuth2 authorization code flow and exchanging it for an access token.")
                        .foregroundColor(.secondary)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    
                    HStack {
                        Button {
                        } label: {
                            Text("Get started")
                                .frame(maxWidth:.infinity)
                                .foregroundColor(.white)
                                .padding()
                                .background(.blue)
                                .cornerRadius(8)
                        }
                        
                        
                    }.frame(maxWidth:.infinity)
                    .padding(16)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

