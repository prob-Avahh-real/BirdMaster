import SwiftUI

struct BirdDetailView: View {
    let bird: BirdSpecies

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // 头部卡片
                headerCard

                // 信息区块
                VStack(spacing: 16) {
                    infoSection(icon: "magnifyingglass", title: "识别特征", content: bird.identificationFeatures)
                    Divider()
                    infoSection(icon: "house.fill", title: "栖息环境", content: bird.habitat)
                    Divider()
                    infoSection(icon: "map.fill", title: "分布区域", content: bird.distribution)
                    Divider()
                    infoSection(icon: "brain.head.profile", title: "生活习性", content: bird.behavior)
                    Divider()

                    // 拍摄建议卡片
                    photographyCard
                }
                .padding(20)
            }
        }
        .navigationTitle(bird.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }

    // MARK: - Header
    private var headerCard: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(.green.opacity(0.1))
                    .frame(width: 100, height: 100)
                Image(systemName: bird.iconName)
                    .font(.system(size: 44))
                    .foregroundStyle(.green)
            }

            Text(bird.name)
                .font(.title)
                .fontWeight(.bold)

            Text(bird.scientificName)
                .font(.subheadline)
                .italic()
                .foregroundStyle(.secondary)

            Text(bird.englishName)
                .font(.caption)
                .foregroundStyle(.secondary)

            // 标签行
            HStack(spacing: 8) {
                tagLabel(bird.category, color: .blue)
                tagLabel(bird.residenceType, color: .green)
                tagLabel(bird.protectionLevel, color: bird.protectionLevel.contains("一级") ? .red : .orange)
            }
            .padding(.top, 4)

            // 数据栏
            HStack(spacing: 24) {
                dataItem(value: "\(Int(bird.bodyLength))", unit: "cm", icon: "ruler")
                dataItem(value: bird.residenceType, unit: "", icon: "mappin.and.ellipse")
                dataItem(value: "\(bird.photographyDifficulty)", unit: "星", icon: "star.fill")
            }
            .padding(.top, 8)
        }
        .padding(.vertical, 32)
        .frame(maxWidth: .infinity)
        .background(.background)
    }

    // MARK: - Photography Card
    private var photographyCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("拍摄指南", systemImage: "camera.fill")
                .font(.headline)

            VStack(spacing: 10) {
                photoTipRow(
                    icon: "star.fill",
                    color: .yellow,
                    label: "拍摄难度",
                    value: String(repeating: "⭐", count: bird.photographyDifficulty)
                )
                photoTipRow(
                    icon: "calendar",
                    color: .blue,
                    label: "最佳季节",
                    value: bird.bestSeason
                )
                photoTipRow(
                    icon: "clock.fill",
                    color: .orange,
                    label: "活动时间",
                    value: bird.behavior.contains("晨昏") ? "晨昏" : "白天"
                )
            }
            .padding(12)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    // MARK: - Helpers
    private func infoSection(icon: String, title: String, content: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: icon)
                .font(.headline)
                .foregroundStyle(.primary)
            Text(content)
                .font(.body)
                .foregroundStyle(.secondary)
                .lineSpacing(4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func tagLabel(_ text: String, color: Color) -> some View {
        Text(text)
            .font(.caption)
            .fontWeight(.medium)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(color.opacity(0.12))
            .foregroundStyle(color)
            .clipShape(Capsule())
    }

    private func dataItem(value: String, unit: String, icon: String) -> some View {
        VStack(spacing: 2) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundStyle(.secondary)
            HStack(alignment: .lastTextBaseline, spacing: 2) {
                Text(value)
                    .font(.title3)
                    .fontWeight(.bold)
                if !unit.isEmpty {
                    Text(unit)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }

    private func photoTipRow(icon: String, color: Color, label: String, value: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(color)
                .frame(width: 20)
            Text(label)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
        }
    }
}
