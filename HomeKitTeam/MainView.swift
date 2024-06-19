//
//  ContentView.swift
//  HomeKitTeam
//
//  Created by Huijeong Bae on 6/19/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: RoomView()) {
                    Text("RoomView")
                        .font(.body)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Home")
        }
    }
}


#Preview {
    MainView()
}
