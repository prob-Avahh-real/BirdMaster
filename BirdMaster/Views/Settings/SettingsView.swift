import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var context
    @Query private var birds: [BirdSpecies]
    @Query private var tips: [PhotographyTip]
    @Query private var records: [SightingRecord]

    var body: some View {
        NavigationStack {
            List {
                // 数据统计
                Section("数据库") {
                    HStack {
                        Label("鸟种图鉴", systemImage: "bird.fill")
                        Spacer()
                        Text("\(birds.count) 种")
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        Label("摄影技巧", systemImage: "camera.fill")
                        Spacer()
                        Text("\(tips.count) 篇")
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        Label("观鸟记录", systemImage: "bookmark.fill")
                        Spacer()
                        Text("\(records.count) 条")
                            .foregroundStyle(.secondary)
                    }
                }

                // 关于
                Section("关于") {
                    HStack {
                        Label("版本", systemImage: "info.circle")
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(.secondary)
                    }

                    Link(destination: URL(string: "https://ebird.org/china")!) {
                        Label("推荐资源: eBird 中国", systemImage: "safari")
                    }
                    Link(destination: URL(string: "https://www.birdreport.cn")!) {
                        Label("推荐资源: 中国观鸟记录中心", systemImage: "safari")
                    }
                }

                // 功能说明
                Section("功能介绍") {
                    VStack(alignment: .leading, spacing: 6) {
                        Label("🐦 观鸟手册", systemImage: "book.fill")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Text("内置中国常见鸟类图鉴，按涉禽、猛禽、鸣禽等分类浏览。每鸟含识别特征、习性、分布和拍摄指南。")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 2)

                    VStack(alignment: .leading, spacing: 6) {
                        Label("📷 出片秘笈", systemImage: "camera.fill")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Text("从器材选择到参数设置，从构图法则到后期处理。入门到高阶，分门别类，即学即用。")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 2)

                    VStack(alignment: .leading, spacing: 6) {
                        Label("📝 观鸟记录", systemImage: "pencil.and.list.clipboard")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Text("随时记录观测——鸟种、地点、数量、天气、行为。支持按日期、鸟种排序和统计。")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 2)
                }
            }
            .navigationTitle("设置")
        }
    }
}
