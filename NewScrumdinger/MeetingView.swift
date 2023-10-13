//
//  ContentView.swift
//  NewScrumdinger
//
//  Created by 백대홍 on 10/13/23.
//

import SwiftUI

struct MeetingView: View {
    var body: some View {
        VStack {
            ProgressView(value: 5, total: 15) // 현재 진행중인 상태 확인
            /// total = 총 값을 의미
            
            HStack {
                
                VStack(alignment: .leading) {
                    Text("Second Elapsed")
                        .font(.caption) //Text에 대한 modifiers 추가
                    Label("300", systemImage: "hourglass.tophalf.fill")
                        
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption) //Text에 대한 modifiers 추가
                    Label("600", systemImage: "hourglass.bottomhalf.fill")
                }
            }
            
            .accessibilityElement(children: .ignore) //새로운 접근성 요소를 무시
            .accessibilityLabel("Time remaining")
            .accessibilityValue("10 minutes")
            
            Circle()
                .stroke(lineWidth: 24) // 테두리 추가
            
            HStack {
                Text("Speaker 1 of 3")
                Spacer()
                Button(action: {}) {
                    Image(systemName: "forward.fill")
                }
                .accessibilityLabel("Next speaker") //이걸 이용해서 VoiceOver에서 이미지 텍스트와 고유 접근성 라벨을 읽어준다.
            }
        }
        .padding()
    }
}

#Preview {
    MeetingView()
}





// MARK: - 질문

/*
1. 이미지를 안쓰고 왜 라벨로 접근하는지?
라벨은 이미지 + 제목 표시를 같이
ex) Label("Lightning", systemImage: "bolt.fill")
이미지는 only 이미지만
ex) Image("가나다라마바사"
- 참고
https://developer.apple.com/documentation/swiftui/label
 
 
2. accessibilityElement? ignore이 부분이 완벽하게 이해가 X
 - VoiceOver와 관련된건 알겠지만, 더 자세한 조사 필요
*/
