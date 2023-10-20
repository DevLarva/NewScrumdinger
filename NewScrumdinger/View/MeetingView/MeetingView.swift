//
//  ContentView.swift
//  NewScrumdinger
//
//  Created by 백대홍 on 10/13/23.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer}
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                
                Circle()
                    .strokeBorder(lineWidth: 24) // 테두리 추가
                
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .onAppear { ///onAppear 모디파이어로 회의 길이와 참석자 수를 전달
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            scrumTimer.speakerChangedAction = {
                player.seek(to: .zero)
                player.play()
            }
            scrumTimer.startScrum()
        }
        .onDisappear { ///onAppear 모디파이어로 타이머 멈추는 stopScrum 호출
            scrumTimer.stopScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
}





// MARK: - 질문

/**
 1. 이미지를 안쓰고 왜 라벨로 접근하는지?
 라벨은 이미지 + 제목 표시를 같이
 ex) Label("Lightning", systemImage: "bolt.fill")
 이미지는 only 이미지만
 ex) Image("가나다라마바사")
 - 참고
 https://developer.apple.com/documentation/swiftui/label
 
 
 2. accessibilityElement? ignore이 부분이 완벽하게 이해가 X
 - VoiceOver와 관련된건 알겠지만, 더 자세한 조사 필요
 
 
 3. player.seek(to: .zero) 이거 조사 필요
 */
