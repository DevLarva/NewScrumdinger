//
//  Life Cycle.swift
//  NewScrumdinger
//
//  Created by 백대홍 on 10/19/23.
//

import Foundation

// MARK: - 5.2 Scene Architecture
/*
 https://developer.apple.com/tutorials/app-dev-training/responding-to-events
 
 앱을 만들기 위해서는 앱 프로토콜을 준수하는 구조를 정의해야한다.
 - @main을 추가하면 이게 앱의 유일한 시작점인걸 시스템에게 알릴수 있다.
 
 
 앱 실행 중에 scene의 단계는 총 3단계로 전환된다.
 1. active - 장면이 전경에 있으며 사용자가 장면과 상호 작용할 수 있다.
 2. inactive - 장면이 표시되지만 시스템이 장면과의 상호 작용을 비활성화
 3. background - 앱이 실행 중이지만 장면이 사용자 인터페이스에 표시되지 않는다.
 
 
 SwiftUI의 뷰 생명주기 이벤트에 응답하는 3가지의 modifier
 1. onAppear - 뷰가 화면에 나올때마다 작업을 트리거
 2. onDisapperar - 뷰가 화면에서 사라질때 작업을 트리거
 3. task - 뷰가 화면에 나오기전에 비동기적으로 실행되는 작업을 트리거
 
 요런 친구들을 이용해서 뷰가 나타나거나 사라질때 앱 상태를 변경하는 작업을 할 수 있다.

 
 */


