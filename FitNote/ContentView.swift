//
//  ContentView.swift
//  FitNote
//
//  这个文件负责 App 的底部 TabView，组织四个主要页面。
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("首页", systemImage: "house")
                }

            AddWorkoutView()
                .tabItem {
                    Label("记录", systemImage: "plus.circle")
                }

            HistoryView()
                .tabItem {
                    Label("历史", systemImage: "clock")
                }

            ProfileView()
                .tabItem {
                    Label("我的", systemImage: "person")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: WorkoutRecord.self, inMemory: true)
}
