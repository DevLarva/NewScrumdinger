//
//  deployment target .swift
//  NewScrumdinger
//
//  Created by 백대홍 on 10/25/23.
//

/**
- deployment target
    - 앱을 실행 할 수 있는 운영 체제의 가장 초기 버전을 지정하는 배포 대상 설정을 해야한다.
    - 왜? NavigationStack이 등장한건 iOS 16.0부터인데 만약 여기서 버전 설정을 iOS 15.0으로 설정해버리면?
    -  NaivgationStack을 사용하는곳에서 컴파일러 에러가 파파파팍하고 나버리니깐!
 
 - 예시
 struct ScrumsView: View {
     @Binding var scrums: [DailyScrum]
     var body: some View {
         if #available(iOS 16.0, *) {
             NavigationStack {
                 ScrumsList(scrums: $scrums)
             }
         } else {
             NavigationView {
                 ScrumsList(scrums: $scrums)
             }
         }
     }
 }
 */
