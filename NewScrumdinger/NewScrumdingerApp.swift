//
//  NewScrumdingerApp.swift
//  NewScrumdinger
//
//  Created by 백대홍 on 10/13/23.
//

import SwiftUI

@main
struct NewScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $store.scrums) {
                Task {
                    do {
                        try await store.save(scrums: store.scrums)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
            
        }
    }
}
