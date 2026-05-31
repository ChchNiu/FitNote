//
//  FitNoteApp.swift
//  FitNote
//
//  这个文件是 App 入口，并配置 SwiftData 本地数据库。
//

import SwiftData
import SwiftUI

@main
struct FitNoteApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: WorkoutRecord.self)
    }
}
