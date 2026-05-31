//
//  HomeView.swift
//  FitNote
//
//  这个文件负责首页，展示今天和本周的训练概览。
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Query(sort: \WorkoutRecord.date, order: .reverse) private var records: [WorkoutRecord]

    private var todayRecords: [WorkoutRecord] {
        records.filter { Calendar.current.isDateInToday($0.date) }
    }

    private var weekRecords: [WorkoutRecord] {
        guard let week = Calendar.current.dateInterval(of: .weekOfYear, for: .now) else {
            return []
        }

        return records.filter { week.contains($0.date) }
    }

    private var todaySets: Int {
        todayRecords.reduce(0) { $0 + $1.sets }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("FitNote")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("记录每一次训练，看见自己的进步。")
                            .foregroundStyle(.secondary)
                    }

                    SummaryCard(
                        title: "今日训练概览",
                        value: todayRecords.isEmpty ? "还没有记录" : "\(todayRecords.count) 条记录",
                        detail: todayRecords.isEmpty ? "去记录页添加今天的训练吧" : "合计 \(todaySets) 组训练"
                    )

                    SummaryCard(
                        title: "本周训练次数",
                        value: "\(weekRecords.count) 次",
                        detail: "坚持稳定训练，比一次练很多更重要"
                    )

                    Text("今天也完成一点点，长期看就是很大的变化。")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.green.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding()
            }
            .navigationTitle("首页")
        }
    }
}

private struct SummaryCard: View {
    let title: String
    let value: String
    let detail: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.title2)
                .fontWeight(.semibold)

            Text(detail)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    HomeView()
        .modelContainer(for: WorkoutRecord.self, inMemory: true)
}
