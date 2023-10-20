//
//  ScrumTimer.swift
//  NewScrumdinger
//
//  Created by 백대홍 on 10/20/23.
//

import Foundation


/// 스크럼 회의 시간을 유지한다. 총 회의시간, 각 발표자의 시간, 현재 발표자의 이름을 추적해준다.


@MainActor
final class ScrumTimer: ObservableObject {
    /// 회의 중에 회의 참석자를 추적하는 구조체
    struct Speaker: Identifiable {
        /// 참석자 이름
        let name: String
        /// 참석자가 발언할 차례가 끝난 경우 참이다.
        var isCompleted: Bool
        /// 식별 가능하게끔 하기 위한 ID값
        let id = UUID()
    }
    
    /// 말하고 있는 참석자의 이름
    @Published var activeSpeaker = ""
    /// 회의 시간 이후 경과된 시간
    @Published var secondsElapsed = 0
    /// 모든 참석자가 발언할 차례가 될 때까지의 시간
    @Published var secondsRemaining = 0
    /// 모든 회의 참석자는 발언할 순서대로 나열
    private(set) var speakers: [Speaker] = []


    /// 회의 길이
    private(set) var lengthInMinutes: Int
    /// 새로운 참석자가 발언을 시작할 때 실행되는 클러저?
    var speakerChangedAction: (() -> Void)?


    private weak var timer: Timer?
    private var timerStopped = false
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var lengthInSeconds: Int { lengthInMinutes * 60 }
    private var secondsPerSpeaker: Int {
        (lengthInMinutes * 60) / speakers.count
    }
    private var secondsElapsedForSpeaker: Int = 0
    private var speakerIndex: Int = 0
    private var speakerText: String {
        return "Speaker \(speakerIndex + 1): " + speakers[speakerIndex].name
    }
    private var startDate: Date?
    
    /**
     새로운 타이머를 초기화.
     
     - Parameters:
        - lengthInMinutes: 회의 시간
        -  attendees: 해당 회의에 참석한 참석자 목록
     */
    init(lengthInMinutes: Int = 0, attendees: [DailyScrum.Attendee] = []) {
        self.lengthInMinutes = lengthInMinutes
        self.speakers = attendees.speakers
        secondsRemaining = lengthInSeconds
        activeSpeaker = speakerText
    }
    
    /// Start the timer.
    func startScrum() {
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            self?.update()
        }
        timer?.tolerance = 0.1
        changeToSpeaker(at: 0)
    }
    
    /// Stop the timer.
    func stopScrum() {
        timer?.invalidate()
        timerStopped = true
    }
    
    /// 타이머를 다음 발언자로 앞당길때 사용
    nonisolated func skipSpeaker() {
        Task { @MainActor in
            changeToSpeaker(at: speakerIndex + 1)
        }
    }
    
    private func changeToSpeaker(at index: Int) {
        if index > 0 {
            let previousSpeakerIndex = index - 1
            speakers[previousSpeakerIndex].isCompleted = true
        }
        secondsElapsedForSpeaker = 0
        guard index < speakers.count else { return }
        speakerIndex = index
        activeSpeaker = speakerText


        secondsElapsed = index * secondsPerSpeaker
        secondsRemaining = lengthInSeconds - secondsElapsed
        startDate = Date()
    }


    nonisolated private func update() {


        Task { @MainActor in
            guard let startDate,
                  !timerStopped else { return }
            let secondsElapsed = Int(Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
            secondsElapsedForSpeaker = secondsElapsed
            self.secondsElapsed = secondsPerSpeaker * speakerIndex + secondsElapsedForSpeaker
            guard secondsElapsed <= secondsPerSpeaker else {
                return
            }
            secondsRemaining = max(lengthInSeconds - self.secondsElapsed, 0)


            if secondsElapsedForSpeaker >= secondsPerSpeaker {
                changeToSpeaker(at: speakerIndex + 1)
                speakerChangedAction?()
            }
        }
    }
    
    /**
     Reset the timer with a new meeting length and new attendees.
     
     - Parameters:
         - lengthInMinutes: The meeting length.
         - attendees: The name of each attendee.
     */
    func reset(lengthInMinutes: Int, attendees: [DailyScrum.Attendee]) {
        self.lengthInMinutes = lengthInMinutes
        self.speakers = attendees.speakers
        secondsRemaining = lengthInSeconds
        activeSpeaker = speakerText
    }
}




extension Array<DailyScrum.Attendee> {
    var speakers: [ScrumTimer.Speaker] {
        if isEmpty {
            return [ScrumTimer.Speaker(name: "Speaker 1", isCompleted: false)]
        } else {
            return map { ScrumTimer.Speaker(name: $0.name, isCompleted: false) }
        }
    }
}


/**
 - 궁금한거 모아보기:
    - nonisolated?
    -
 */
