//
//  observable.swift
//  NewScrumdinger
//
//  Created by 백대홍 on 10/19/23.
//


// MARK: - 5.1 Making classes observable

/*

 
 1.클래스 관찰 가능 -> ObservableObject 프로토콜 채택하면 됨
 
 클래스 내 UI 업데이트를 트리거해야 하는 프로퍼티를 식별 -> 각 프로퍼티 선언에 @Published 속성을 추가하자!
 
 class ScrumTimer: ObservableObject {
    @Published var activeSpeaker = ""
    @Published var secondsElapsed = 0
    @Published var secondsRemaining = 0
    // ...
 }
 계속 업데이트 되는 프로퍼티의 값이 변경될 때 옵져버에게 알려준다.

 
 차이점 분석
 - ObservedObject : 관찰 가능한 객체가 변경될때 마다 뷰를 무효화하는 속성
 - StateObject : 관찰 가능한 객체를 만들기 위해서 사용
 - EnvironmentObject
 
 
 
 */




// MARK: - @State, @ObservedObject, @EnvironmentObject
/*
 https://zeddios.tistory.com/964 참고
 
 - State
 State로 모든 프로퍼티의 스토리지를 관리. 따라서 State값이 변경되면 뷰에서 보여지는 모습을? 무효화하고 다시 계산 함
 여기서 private로 선언을 하게 되면 다른 뷰에서는 절대 사용할수 없게 된다.
 따라서 @State로 선언하면 스유가 알아서 변경사항을 관찰하고 그걸 해당 state를 사용하는 뷰를 업데이트 한다!
 
 
 - ObservedObject
 @ObservedObject와 함께 사용하는 타입은 ObservableObject프로토콜을 따라야한다.
 ObservedObject가 데이터가 변경되었음을 뷰에 알리는 방법중 흔히 쓰는 방법 = @Published를 사용하자.
 
 
 - EnvironmentObject
 한마디로 정의 -> "it’s shared data that every view can read if they want to."
 
 */
