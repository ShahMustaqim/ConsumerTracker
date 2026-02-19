//
//  ConsumerTrackerApp.swift
//  ConsumerTracker Watch App
//
//  Created by Shahril S M B (FCES) on 16/02/2026.
//

import SwiftUI

@main
struct ConsumerTracker_Watch_AppApp: App {
    @StateObject var dataModel: DataModel = DataModel()
    var body: some Scene {
        WindowGroup {
            ContentView(model:dataModel)
        }
    }
}
