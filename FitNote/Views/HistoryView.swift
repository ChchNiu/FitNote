//
//  HistoryView.swift
//  FitNote
//
//  这个文件负责历史页，从 SwiftData 读取、展示和删除训练记录。
//

import SwiftData
import SwiftUI

struct HistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \WorkoutRecord.date, order: .reverse) private var records: [WorkoutRecord]

    var body: some View {
        NavigationStack {
            List {
                if records.isEmpty {
                    ContentUnavailableView(
                        "暂无训练记录",
                        systemImage: "figure.strengthtraining.traditional",
                        description: Text("去记录页添加第一条训练吧")
                    )
                } else {
                    ForEach(records) { record in
                        WorkoutRecordRow(record: record)
                    }
                    .onDelete(perform: deleteRecords)
                }
            }
            .navigationTitle("历史")
        }
    }

    private func deleteRecords(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(records[index])
        }
    }
}

private struct WorkoutRecordRow: View {
    let record: WorkoutRecord

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(record.exerciseName)
                    .font(.headline)

                Spacer()

                Text(record.bodyPart)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Text("\(record.sets) 组 x \(record.reps) 次 · \(record.weight, format: .number.precision(.fractionLength(0...1))) kg")
                .font(.subheadline)

            Text(record.date, format: .dateTime.year().month().day())
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    HistoryView()
        .modelContainer(for: WorkoutRecord.self, inMemory: true)
}
