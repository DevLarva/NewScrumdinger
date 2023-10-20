//
//  CardView.swift
//  NewScrumdinger
//
//  Created by 백대홍 on 10/13/23.
//

import SwiftUI

struct CardView: View {
    let scrum: DailyScrum
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(scrum.title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                Label("\(scrum.attendees.count)", systemImage: "person.3")
                    .accessibilityLabel("\(scrum.attendees.count) attendees")
                Spacer()
                Label("\(scrum.lengthInMinutes)", systemImage: "clock")
                    .accessibilityLabel("\(scrum.lengthInMinutes) minute meeting")
                    .labelStyle(.trailingIcon)
            }
            .font(.caption) //한방에 폰트 지정
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
    }
}


struct CardView_Previews: PreviewProvider {
    static var scrum = DailyScrum.sampleData[0]
    static var previews: some View {
        CardView(scrum: scrum)
            .background(scrum.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}




// MARK: - 조사

/**
 - accessibilityAddTraits
어떤 특성인지를 설명해준다. 뷰면 뷰, 라벨이면 라벨 텍스트면 텍스트 이런식으로!
우리가 흔히 사용하는 accessibility 느낌으로 비슷하다고 생각하면 된다!!
 */
