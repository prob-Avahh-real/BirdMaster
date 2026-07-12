import Foundation
import SwiftData

@Model
final class SightingRecord {
    /// 观鸟日期
    var date: Date
    /// 地点
    var location: String
    /// 鸟种名称
    var speciesName: String
    /// 数量
    var count: Int
    /// 笔记
    var notes: String
    /// 行为记录
    var behaviorObserved: String
    /// 天气
    var weather: String
    /// 记录时间
    var createdAt: Date

    init(
        date: Date = Date(),
        location: String = "",
        speciesName: String = "",
        count: Int = 1,
        notes: String = "",
        behaviorObserved: String = "",
        weather: String = "晴"
    ) {
        self.date = date
        self.location = location
        self.speciesName = speciesName
        self.count = count
        self.notes = notes
        self.behaviorObserved = behaviorObserved
        self.weather = weather
        self.createdAt = Date()
    }
}
