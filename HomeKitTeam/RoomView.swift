//
// RoomView.swift
// HomeKitTeam
//
// Created by Huijeong Bae on 6/19/24.
//

import SwiftUI

enum AccessoryType {
case select
case aquraHub
case PhilpsHue
case NanoleafShape
}

enum ColorType {
case select
case red
case orange
case yellow
case green
case blue
case indigo
case purple
case random
}

struct RoomView: View {
@State var accessoryType = AccessoryType.select
@State var colorType = ColorType.select
@State var addFavorite = false
@State var title: String = ""

@State private var showingTimePicker = false
@State private var selectedTime = Date()
@State private var isButtonPressed = false
@State private var navigateToEmptyView = false
@State private var favoriteSet = false

@State private var selectedHour = 0
@State private var selectedMinute = 0
@State private var selectedSecond = 0

var body: some View {
    NavigationStack {
        ZStack {
            //얘만 들어가면 패딩이 자꾸 이상해짐...
            Color.BGSecondary.ignoresSafeArea(.all)
            Form {
                Section {
                    Picker("악세서리", selection: $accessoryType) {
                        Text("악세서리 선택...").tag(AccessoryType.select)
                        Text("aquarHub").tag(AccessoryType.aquraHub)
                        Text("PhilpsHue").tag(AccessoryType.PhilpsHue)
                        Text("NanoleafShape").tag(AccessoryType.NanoleafShape)
                    }
                }
                Section {
                    HStack {
                        Text("타이머")
                        Spacer()
                        Button(action: {
                            showingTimePicker.toggle()
                            isButtonPressed.toggle()
                        }) {
                            Text(formattedTime)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.BGSecondary)
                                .foregroundColor(isButtonPressed ? Color.DarkYellow : Color.black)
                                .cornerRadius(8)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .padding(.leading, 16)
                    .padding(.trailing, 8)
                    
                    if showingTimePicker {
                        HStack {
                            Spacer()
                            Picker("Hour", selection: $selectedHour) {
                                ForEach(0..<24) { Text("\($0) 시").tag($0) }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 100)
                            Picker("Minute", selection: $selectedMinute) {
                                ForEach(0..<60) { Text("\($0) 분").tag($0) }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 100)
                            Picker("Second", selection: $selectedSecond) {
                                ForEach(0..<60) { Text("\($0) 초").tag($0) }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 100)
                            Spacer()
                        }
                    }
                }
                Section {
                    TextField("타이머 제목을 입력하세요", text: $title)
                    Picker("깜빡일 때 조명 색상 선택", selection: $colorType) {
                        Text("색상 선택...").tag(ColorType.select)
                        HStack{
                            Text("빨강").tag(ColorType.red)
                            Spacer()
                            Image(systemName: "square.fill")
                            .foregroundColor(.blue)
                        }
                        HStack{
                            Text("주황").tag(ColorType.orange)
                            Spacer()
                            Image(systemName: "square.fill")
                            .foregroundColor(.blue)
                        }
                        HStack{
                            Text("노랑").tag(ColorType.yellow)
                            Spacer()
                            Image(systemName: "square.fill")
                            .foregroundColor(.blue)
                        }
                        HStack{
                            Text("초록").tag(ColorType.green)
                            Spacer()
                            Image(systemName: "square.fill")
                            .foregroundColor(.blue)
                        }
                        HStack{
                            Text("파랑").tag(ColorType.blue)
                            Spacer()
                            Image(systemName: "square.fill")
                            .foregroundColor(.blue)
                        }
                        HStack{
                            Text("남색").tag(ColorType.indigo)
                            Spacer()
                            Image(systemName: "square.fill")
                            .foregroundColor(.blue)
                        }
                        HStack{
                            Text("보라").tag(ColorType.purple)
                            Spacer()
                            Image(systemName: "square.fill")
                            .foregroundColor(.blue)
                        }
                        HStack{
                            Text("무작위").tag(ColorType.random)
                            Spacer()
                            Image(systemName: "square.fill")
                            .foregroundColor(.blue)
                        }
                    }
                }
            }
            .padding(.top, 10)
            .navigationTitle("RoomName")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("완료") {
                        navigateToEmptyView = true
                    }
                    .foregroundColor(Color.DarkYellow)
                }
            }
            .navigationDestination(isPresented: $navigateToEmptyView) {
                EmptyView()
            }
        }
    }
}

var formattedTime: String {
    String(format: "%02d:%02d:%02d", selectedHour, selectedMinute, selectedSecond)
}
}

#Preview {
RoomView()
}
