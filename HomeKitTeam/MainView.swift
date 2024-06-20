//
//  ContentView.swift
//  HomeKitTeam
//
//  Created by Huijeong Bae on 6/19/24.
//

import SwiftUI

struct MainView: View {
    @State private var selectedRoom1 = ""
    @State private var selectedRoom2 = ""
    @State private var selectedRoom3 = ""
    
    var body: some View {
        NavigationStack{
            VStack {
                Form {
                    Section("방으로 가기") {
                        Picker("방 1", selection: $selectedRoom1) {
                        }
                        Picker("방 2", selection: $selectedRoom2) {
                        }
                        Picker("방 3", selection: $selectedRoom3) {
                        }
                    }
                }
                .pickerStyle(.navigationLink)
                
                HStack(alignment: .center, spacing: 0) {
                    Text("악세서리")
                        .font(.title3.bold())
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 0)
                .frame(width: 393, alignment: .leading)
                
                NavigationLink(destination: RoomView()) {
                    HStack(alignment: .top, spacing: 24) {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("일이삼사오육칠팔구십일이삼사오")
                                .font(
                                    .headline
                                )
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, minHeight: 16, maxHeight: 16, alignment: .leading)
                            
                            Text("00:00:00")
                                .font(Font.custom("SF Pro", size: 59))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                        VStack(alignment: .center) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color.LabelsPrimary)
                        }
                        .padding(0)
                        .frame(maxHeight: .infinity, alignment: .center)
                    }
                    .padding(12)
                    .frame(width: 361, height: 120, alignment: .topLeading)
                    .background(Color.AppYellow)
                    .cornerRadius(16)
                }
            }
            .navigationTitle("내 집")
        }
    }
}


#Preview {
    MainView()
}
