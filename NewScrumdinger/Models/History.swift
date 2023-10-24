//
//  History.swift
//  NewScrumdinger
//
//  Created by 백대홍 on 10/23/23.
//

import Foundation


struct History: Identifiable, Codable {  ///스크럼 세션의 필수 세부 정보를 저장하는 속성들
    let id: UUID
    let date: Date
    var attendees: [DailyScrum.Attendee]
    
    init(id: UUID = UUID(), date: Date = Date(), attendees: [DailyScrum.Attendee]) {  ///기본 매개변수를 초기화
        self.id = id
        self.date = date
        self.attendees = attendees
    }
}
