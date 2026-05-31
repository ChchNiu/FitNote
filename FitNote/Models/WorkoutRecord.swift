//
//  WorkoutRecord.swift
//  FitNote
//
//  这个文件定义一条训练记录，并交给 SwiftData 做本地存储。
//

import Foundation
import SwiftData

@Model
final class WorkoutRecord {
    var exerciseName: String
    var bodyPart: String
    var sets: Int
    var reps: Int
    var weight: Double
    var date: Date

    init(
        exerciseName: String,
        bodyPart: String,
        sets: Int,
        reps: Int,
        weight: Double,
        date: Date = .now
    ) {
        self.exerciseName = exerciseName
        self.bodyPart = bodyPart
        self.sets = sets
        self.reps = reps
        self.weight = weight
        self.date = date
    }
}
