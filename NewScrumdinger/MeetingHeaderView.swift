//
//  MeetingHeaderView.swift
//  NewScrumdinger
//
//  Created by 백대홍 on 10/20/23.
//

import SwiftUI

struct MeetingHeaderView: View {
    let secondsElapsed: Int
    let secondsRemaining: Int
    let theme: Theme
    private var totalSeconds: Int { // 총 시간 계산 속성 추가
        secondsElapsed + secondsRemaining
    }
    
    private var progress: Double {  //진행 상황 계산하는 속성, 계산 값을 ProgressView에 전달
        guard totalSeconds > 0 else { return 1 }
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    
    private var minutesRemaining: Int {
        secondsRemaining / 60
    }
    var body: some View {
        
        VStack {
            ProgressView(value: progress) // 현재 진행중인 상태 확인
                .progressViewStyle(ScrumProgressViewStyle(theme: theme))
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Second Elapsed")
                        .font(.caption) //Text에 대한 modifiers 추가
                    Label("\(secondsElapsed)", systemImage: "hourglass.tophalf.fill")
                   
                }
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption) //Text에 대한 modifiers 추가
                    Label("\(secondsRemaining)", systemImage: "hourglass.bottomhalf.fill")
                        .labelStyle(.trailingIcon)
                }
            }
        }
        .accessibilityElement(children: .ignore) //새로운 접근성 요소를 무시
        .accessibilityLabel("Time remaining")
        .accessibilityValue("\(minutesRemaining) minutes")
        .padding([.top, .horizontal])
    }
}

#Preview {
    MeetingHeaderView(secondsElapsed: 60, secondsRemaining: 180, theme: .lavender)
        .previewLayout(.sizeThatFits)
}
