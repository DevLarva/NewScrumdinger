//
//  DetailEditView.swift
//  NewScrumdinger
//
//  Created by 백대홍 on 10/17/23.
//

import SwiftUI

struct DetailEditView: View {
    //@State private var scrum = DailyScrum.emptyScrum  //private로 해당 뷰 내에서만 사용, 아래 바인딩으로 변경
    @State private var newAttendeeName = ""
    @Binding var scrum: DailyScrum
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $scrum.title)
                
                HStack {
                    Slider(value: $scrum.lengthInMinutesAsDouble, in: 5...30, step: 1) {
                        Text("Length")
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes) minutes") //슬라이더에 접근성 값 추가
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $scrum.theme)
                    .frame(width: 300, height: 150)
            }
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    scrum.attendees.remove(atOffsets: indices) //List에서 항목 삭제 modifier(스와이프)
                }
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            scrum.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add Attendee")
                    }
                    .disabled(newAttendeeName.isEmpty) //텍스트 필드가 비어있으면 버튼 비활성화
                }
            }
        }
    }
}

#Preview {
    DetailEditView(scrum: .constant(DailyScrum.sampleData[0]))
}
