import SwiftUI
import SwiftData

@Model
final class BirdSpecies {
    /// 中文名
    var name: String
    /// 学名
    var scientificName: String
    /// 英文名
    var englishName: String
    /// 分类 (涉禽/猛禽/鸣禽/游禽/攀禽/陆禽)
    var category: String
    /// 居留类型 (留鸟/候鸟/旅鸟/迷鸟)
    var residenceType: String
    /// 体长 (cm)
    var bodyLength: Double
    /// 保护级别
    var protectionLevel: String
    /// 识别特征
    var identificationFeatures: String
    /// 栖息环境
    var habitat: String
    /// 分布区域
    var distribution: String
    /// 生活习性
    var behavior: String
    /// 拍摄难度 (1-5 星)
    var photographyDifficulty: Int
    /// 最佳拍摄季节
    var bestSeason: String
    /// SF Symbol 图标名 (作为占位图标)
    var iconName: String
    /// 图片 URL (预留)
    var imageURL: String?
    /// 排序权重
    var sortOrder: Int

    init(
        name: String,
        scientificName: String,
        englishName: String,
        category: String,
        residenceType: String,
        bodyLength: Double,
        protectionLevel: String,
        identificationFeatures: String,
        habitat: String,
        distribution: String,
        behavior: String,
        photographyDifficulty: Int = 3,
        bestSeason: String = "全年",
        iconName: String = "bird.fill",
        imageURL: String? = nil,
        sortOrder: Int = 0
    ) {
        self.name = name
        self.scientificName = scientificName
        self.englishName = englishName
        self.category = category
        self.residenceType = residenceType
        self.bodyLength = bodyLength
        self.protectionLevel = protectionLevel
        self.identificationFeatures = identificationFeatures
        self.habitat = habitat
        self.distribution = distribution
        self.behavior = behavior
        self.photographyDifficulty = photographyDifficulty
        self.bestSeason = bestSeason
        self.iconName = iconName
        self.imageURL = imageURL
        self.sortOrder = sortOrder
    }
}
