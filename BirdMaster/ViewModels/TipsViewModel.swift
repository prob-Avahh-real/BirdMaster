import SwiftUI
import SwiftData

@MainActor
final class TipsViewModel: ObservableObject {
    @Published var selectedCategory: String?

    let categories = ["器材", "参数", "构图", "时机", "后期", "行为解读"]
    let categoryIcons: [String: String] = [
        "器材": "camera.fill",
        "参数": "slider.horizontal.3",
        "构图": "rectangle.3.group.fill",
        "时机": "clock.fill",
        "后期": "paintbrush.fill",
        "行为解读": "brain.fill"
    ]
    let categoryColors: [String: Color] = [
        "器材": .blue,
        "参数": .orange,
        "构图": .purple,
        "时机": .yellow,
        "后期": .teal,
        "行为解读": .pink
    ]
    let categoryDescriptions: [String: String] = [
        "器材": "镜头、机身、三脚架、云台——装备选对，事半功倍",
        "参数": "快门、光圈、ISO、对焦——参数设置决定成败",
        "构图": "三分法、前景、视角——让记录照升级为作品",
        "时机": "黄金时刻、迁徙季——在对的时间出现在对的地方",
        "后期": "裁剪、降噪、调色——还原真实，拒绝过度",
        "行为解读": "读懂鸟的语言——预判精彩瞬间"
    ]

    func tips(query: Query<PhotographyTip, [PhotographyTip]>) -> [PhotographyTip] {
        let descriptor = FetchDescriptor<PhotographyTip>(
            sortBy: [SortDescriptor(\.sortOrder)]
        )
        guard let context = query.modelContext else { return [] }
        guard let allTips = try? context.fetch(descriptor) else { return [] }

        if let category = selectedCategory {
            return allTips.filter { $0.category == category }
        }
        return allTips
    }
}
