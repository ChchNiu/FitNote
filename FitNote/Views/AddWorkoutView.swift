//
//  AddWorkoutView.swift
//  FitNote
//
//  这个文件负责记录页，用表单添加一条新的训练记录。
//

import SwiftData
import SwiftUI

struct AddWorkoutView: View {
    @Environment(\.modelContext) private var modelContext

    @State private var exerciseName = ""
    @State private var bodyPart = "胸"
    @State private var sets = ""
    @State private var reps = ""
    @State private var weight = ""
    @State private var date = Date()
    @State private var showSavedMessage = false

    private let bodyParts = ["胸", "背", "腿", "肩", "手臂", "有氧"]

    private var canSave: Bool {
        !exerciseName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && Int(sets) != nil
        && Int(reps) != nil
        && Double(weight) != nil
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("训练内容") {
                    TextField("动作名称，例如 卧推", text: $exerciseName)

                    Picker("训练部位", selection: $bodyPart) {
                        ForEach(bodyParts, id: \.self) { part in
                            Text(part)
                        }
                    }
                }

                Section("训练数据") {
                    TextField("组数", text: $sets)
                        .keyboardType(.numberPad)

                    TextField("次数", text: $reps)
                        .keyboardType(.numberPad)

                    TextField("重量 kg", text: $weight)
                        .keyboardType(.decimalPad)
                }

                Section("日期") {
                    DatePicker("训练日期", selection: $date, displayedComponents: .date)
                }

                Section {
                    Button("保存记录") {
                        saveWorkout()
                    }
                    .disabled(!canSave)

                    if showSavedMessage {
                        Text("保存成功")
                            .foregroundStyle(.green)
                    }
                }
            }
            .navigationTitle("记录")
        }
    }

    private func saveWorkout() {
        guard let setCount = Int(sets),
              let repCount = Int(reps),
              let weightValue = Double(weight) else {
            return
        }

        let record = WorkoutRecord(
            exerciseName: exerciseName.trimmingCharacters(in: .whitespacesAndNewlines),
            bodyPart: bodyPart,
            sets: setCount,
            reps: repCount,
            weight: weightValue,
            date: date
        )

        modelContext.insert(record)
        clearForm()
        showSavedMessage = true
    }

    private func clearForm() {
        exerciseName = ""
        bodyPart = "胸"
        sets = ""
        reps = ""
        weight = ""
        date = Date()
    }
}

#Preview {
    AddWorkoutView()
        .modelContainer(for: WorkoutRecord.self, inMemory: true)
}
