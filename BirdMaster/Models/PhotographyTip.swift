import Foundation
import SwiftData

@Model
final class PhotographyTip {
    /// 技巧标题
    var title: String
    /// 分类 (器材/参数/构图/时机/后期/行为解读)
    var category: String
    /// 内容正文
    var content: String
    /// 要点提炼（用换行分隔多条）
    var keyPoints: String
    /// 适用鸟种场景
    var applicableScenes: String
    /// 难度级别 (1-3: 入门/进阶/高阶)
    var level: Int
    /// SF Symbol 图标
    var iconName: String
    /// 排序
    var sortOrder: Int

    var levelText: String {
        switch level {
        case 1: return "入门"
        case 2: return "进阶"
        case 3: return "高阶"
        default: return "入门"
        }
    }

    var levelColor: String {
        switch level {
        case 1: return "green"
        case 2: return "orange"
        case 3: return "red"
        default: return "green"
        }
    }

    init(
        title: String,
        category: String,
        content: String,
        keyPoints: String,
        applicableScenes: String = "",
        level: Int = 1,
        iconName: String = "camera.fill",
        sortOrder: Int = 0
    ) {
        self.title = title
        self.category = category
        self.content = content
        self.keyPoints = keyPoints
        self.applicableScenes = applicableScenes
        self.level = level
        self.iconName = iconName
        self.sortOrder = sortOrder
    }
}
