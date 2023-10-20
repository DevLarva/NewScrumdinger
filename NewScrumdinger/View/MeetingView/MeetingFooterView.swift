//
//  MeetingFooterView.swift
//  NewScrumdinger
//
//  Created by 백대홍 on 10/20/23.
//

import SwiftUI

struct MeetingFooterView: View {
    let speakers: [ScrumTimer.Speaker] ///스피커 속성 추가
    var skipAction: () ->Void ///사용자가 다음 발언자로 건너뛸 수 있도록 하기 위해 사용
    
    
    private var speakerNumber: Int? { ///스피커 번호를 결정하는 계산 속성 추가
        guard let index = speakers.firstIndex(where: { !$0.isCompleted})
        else { return nil }
        return index + 1
    }
    
    private var isLastSpeaker: Bool { ///현재 발언자가 마지막인지 여부 판단 계산
        return speakers.dropLast().allSatisfy { $0.isCompleted }
    }
    
    private var speakerText: String {
        guard let speakerNumber = speakerNumber
        else { return "No more speakers" }
        return "Speaker \(speakerNumber) of \(speakers.count)"
    }
    
    var body: some View {
        
        VStack {
            HStack {
                
                if isLastSpeaker {
                    Text("Last Speaker")
                } else {
                    Text(speakerText)
                    Spacer()
                    Button(action: skipAction) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker") //이걸 이용해서 VoiceOver에서 이미지 텍스트와 고유 접근성 라벨을 읽어준다.
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

#Preview {
    MeetingFooterView(speakers: DailyScrum.sampleData[0].attendees.speakers, skipAction: {})
        .previewLayout(.sizeThatFits)
}



/**
 - 조사 필요
    - allSatisfy
 - 헷갈리니깐 다시찾아볼것
    - dropLast , firstIndex
 */
