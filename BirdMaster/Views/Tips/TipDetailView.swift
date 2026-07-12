import SwiftUI

struct TipDetailView: View {
    let tip: PhotographyTip

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // 头部
                headerSection

                Divider()
                    .padding(.horizontal, 20)

                // 正文
                VStack(alignment: .leading, spacing: 24) {
                    contentSection
                    keyPointsSection

                    if !tip.applicableScenes.isEmpty {
                        applicableScenesSection
                    }
                }
                .padding(20)
            }
        }
        .navigationTitle(tip.title)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }

    // MARK: - Header
    private var headerSection: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(categoryColor.opacity(0.1))
                    .frame(width: 80, height: 80)
                Image(systemName: tip.iconName)
                    .font(.system(size: 36))
                    .foregroundStyle(categoryColor)
            }

            HStack(spacing: 8) {
                Text(tip.category)
                    .font(.caption)
                    .fontWeight(.medium)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(categoryColor.opacity(0.12))
                    .foregroundStyle(categoryColor)
                    .clipShape(Capsule())

                Text(tip.levelText)
                    .font(.caption)
                    .fontWeight(.medium)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(levelColor.opacity(0.12))
                    .foregroundStyle(levelColor)
                    .clipShape(Capsule())
            }
        }
        .padding(.vertical, 28)
        .frame(maxWidth: .infinity)
        .background(.background)
    }

    // MARK: - Content
    private var contentSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("详细说明", systemImage: "doc.text.fill")
                .font(.headline)

            Text(tip.content)
                .font(.body)
                .foregroundStyle(.secondary)
                .lineSpacing(6)
        }
    }

    // MARK: - Key Points
    private var keyPointsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("核心要点", systemImage: "lightbulb.fill")
                .font(.headline)
                .foregroundStyle(.yellow)

            let points = tip.keyPoints.components(separatedBy: "\n").filter { !$0.isEmpty }
            ForEach(Array(points.enumerated()), id: \.offset) { index, point in
                HStack(alignment: .top, spacing: 10) {
                    Text("\(index + 1)")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(width: 18, height: 18)
                        .background(categoryColor)
                        .clipShape(Circle())

                    Text(point)
                        .font(.subheadline)
                        .foregroundStyle(.primary)
                }
            }
        }
    }

    // MARK: - Applicable Scenes
    private var applicableScenesSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("适用场景", systemImage: "mappin.and.ellipse")
                .font(.headline)

            Text(tip.applicableScenes)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(12)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }

    // MARK: - Helpers
    private var categoryColor: Color {
        let colors: [String: Color] = [
            "器材": .blue, "参数": .orange, "构图": .purple,
            "时机": .yellow, "后期": .teal, "行为解读": .pink
        ]
        return colors[tip.category] ?? .gray
    }

    private var levelColor: Color {
        switch tip.level {
        case 1: return .green
        case 2: return .orange
        case 3: return .red
        default: return .green
        }
    }
}
