//
//  ProfileView.swift
//  FitNote
//
//  这个文件负责我的页面，暂时展示静态目标，不处理登录和联网。
//

import SwiftUI

struct ProfileView: View {
    private let goals = ["增肌", "减脂", "提升体能"]

    var body: some View {
        NavigationStack {
            List {
                Section("用户目标") {
                    ForEach(goals, id: \.self) { goal in
                        HStack {
                            Image(systemName: "target")
                                .foregroundStyle(.green)

                            Text(goal)
                        }
                    }
                }

                Section("账号") {
                    Text("暂时不需要登录")
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("我的")
        }
    }
}

#Preview {
    ProfileView()
}
