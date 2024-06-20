//
// RoomView.swift
// HomeKitTeam
//
// Created by Huijeong Bae on 6/19/24.
//

import SwiftUI

//homeApp에서 받아오는 악세서리
enum AccessoryType {
    case select
    case aquraHub
    case PhilpsHue
    case NanoleafShape
}

//사용자 정의 전구 색상
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
    
    //Picker, Timer와 같은 ListView를 위한 변수
    @State private var showingTimePicker = false
    @State private var selectedTime = Date()
    @State private var isButtonPressed = false
    @State private var navigateToEmptyView = false
    @State private var favoriteSet = false
    
    //timer의 wheelPicker 시간, 분, 초를 나타내는 변수
    @State private var selectedHour = 0
    @State private var selectedMinute = 0
    @State private var selectedSecond = 0
    
    // 외부에서 받아올 수 있는 아이템 수
    var itemCount: Int = 9
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.BGSecondary.ignoresSafeArea(.all)
                VStack {
                    //list
                    Form {
                        //Accessory Select
                        Section {
                            Picker("악세서리", selection: $accessoryType) {
                                Text("악세서리 선택...").tag(AccessoryType.select)
                                Text("aquarHub").tag(AccessoryType.aquraHub)
                                Text("PhilpsHue").tag(AccessoryType.PhilpsHue)
                                Text("NanoleafShape").tag(AccessoryType.NanoleafShape)
                            }
                        }
                        //Timer
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
                            
                            //Timer에서 Button을 누를 경우,WheelPicker가 보이도록 한다.
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
                        //Timer 제목 입력, 색상 선택
                        Section {
                            TextField("타이머 제목을 입력하세요", text: $title)
                            Picker("깜빡일 때 조명 색상 선택", selection: $colorType) {
                                //Timer 색상 선택 시 보여주는 Pop-up list
                                Text("색상 선택...").tag(ColorType.select)
                                HStack{
                                    Text("빨강").tag(ColorType.red)
                                    Spacer()
                                    Image(systemName: "square.fill")
                                        .foregroundColor(.red)
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
                    //navigationToolBar의 완료 버튼
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
                    //Spacer같은 역할
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56)
                    HStack(alignment: .center, spacing: 0) {
                        Text("악세서리")
                            .font(.title3.bold())
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 0)
                    .frame(width: 393, alignment: .leading)
                    
                    
                    /* LazyGrid는 스크롤이 따로 적용되는 문제: form과 동시 적용이 되지 않아 한 번에 하려면
                     form을 Stack들로 바꾸어야 한다. 아래는 LazyGrid를 작성은 하였으나 이중 Scroll 문제가 있다.*/
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                            ForEach(0..<itemCount, id: \.self) { _ in
                                VStack(alignment: .leading, spacing: 0) {
                                    HStack(alignment: .top, spacing: 10) {
                                        Image(systemName: "bed.double")
                                    }
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                    
                                    Rectangle()
                                        .frame(maxWidth: .infinity, minHeight: 46, maxHeight: 46)
                                        .foregroundColor(.clear)
                                    
                                    Text("일이삼사오육")
                                        .font(Font.body.bold())
                                        .foregroundColor(.black)
                                        .frame(width: 92, alignment: .topLeading)
                                }
                                .padding(10)
                                .frame(maxHeight: .infinity, alignment: .topLeading)
                                .background(Color.white)
                                .cornerRadius(16)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    Spacer()
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



