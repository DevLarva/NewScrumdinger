//
//  ScrumStore.swift
//  NewScrumdinger
//
//  Created by 백대홍 on 10/24/23.
//

import Foundation


@MainActor      /// 비동기 load메서드에서 스크럼 속성을 안전하게 업데이트하기 위해 클래스를 MainActor로 표시해야함!
class ScrumStore: ObservableObject {
    @Published var scrums: [DailyScrum] = []
    
    private static func fileURL() throws -> URL {   /// File매니저 클래스의 공유 인스턴스를 사용해서 현재 사용자의 문서 디렉토리 위치를 가져온다.
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathExtension("scrums.data")
    }
    
    func load() async throws {  ///load라는 비동기 함수를 선언
        let task = Task<[DailyScrum], Error> {   ///이후에 반환된 값에 오류를 포착할 수 있도록 작업을  let 상수에 저장
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL)     /// 파일 데이터를 선택적으로 로드(가드랫)
            else {
                return []
            }
            let dailyScrums = try JSONDecoder().decode([DailyScrum].self, from: data)   ///로컬 상수로 디코딩
            return dailyScrums
        }
        let scrums = try await task.value
        self.scrums = scrums
    }
    
    func save(scrums: [DailyScrum]) async throws {  ///저장 방법을 추가
        let task = Task {
            let data = try JSONEncoder().encode(scrums) ///데이터 인코딩
            let outfile = try Self.fileURL()
            try data.write(to: outfile)     ///인코딩된 데이터를 파일에 작성
        }
        _ = try await task.value            ///작업이 완료 될때 까지 기다림
        
    }
}

