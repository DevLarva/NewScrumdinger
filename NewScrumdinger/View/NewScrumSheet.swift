//
//  NewScrumSheet.swift
//  NewScrumdinger
//
//  Created by 백대홍 on 10/23/23.
//

import SwiftUI

struct NewScrumSheet: View {
    @State private var newScrum = DailyScrum.emptyScrum
    @Binding var scrums: [DailyScrum]
    @Binding var isPresentiongNewScrumView: Bool ///ScrumsView에서 선언된 부울값을 바인딩 받음
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $newScrum)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentiongNewScrumView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            scrums.append(newScrum) /// 추가 버튼으로 스크럼 배열에 새로운 작업 추가
                            isPresentiongNewScrumView = false
                        }
                    }
                }
            
        }
    }
}

#Preview {
    NewScrumSheet(scrums: .constant(DailyScrum.sampleData), isPresentiongNewScrumView: .constant(true))
}
