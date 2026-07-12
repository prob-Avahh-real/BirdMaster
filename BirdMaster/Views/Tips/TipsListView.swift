import SwiftUI
import SwiftData

struct TipsListView: View {
    @StateObject private var vm = TipsViewModel()
    @Query(sort: \PhotographyTip.sortOrder) private var tipsQuery: [PhotographyTip]

    var displayedTips: [PhotographyTip] {
        vm.tips(query: _tipsQuery)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // 分类块
                    categoryGrid

                    // 技巧列表
                    LazyVStack(spacing: 12) {
                        ForEach(displayedTips) { tip in
                            NavigationLink(destination: TipDetailView(tip: tip)) {
                                tipCard(tip)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 20)
            }
            .navigationTitle("出片秘笈")
            .background(Color(.systemGroupedBackground))
        }
    }

    // MARK: - Category Grid
    private var categoryGrid: some View {
        VStack(alignment: .leading, spacing: 12) {
            if vm.selectedCategory == nil {
                Text("选择分类")
                    .font(.headline)
                    .padding(.horizontal)
            }

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                // 全部按钮
                categoryCell("全部", icon: "square.grid.2x2.fill", color: .gray,
                             isSelected: vm.selectedCategory == nil) {
                    vm.selectedCategory = nil
                }

                ForEach(vm.categories, id: \.self) { cat in
                    categoryCell(
                        cat,
                        icon: vm.categoryIcons[cat] ?? "camera.fill",
                        color: vm.categoryColors[cat] ?? .gray,
                        isSelected: vm.selectedCategory == cat
                    ) {
                        vm.selectedCategory = (vm.selectedCategory == cat) ? nil : cat
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    private func categoryCell(
        _ title: String, icon: String, color: Color,
        isSelected: Bool, action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(isSelected ? .white : color)
                Text(title)
                    .font(.caption)
                    .fontWeight(isSelected ? .semibold : .regular)
                    .foregroundStyle(isSelected ? .white : .primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(isSelected ? color : color.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    // MARK: - Tip Card
    private func tipCard(_ tip: PhotographyTip) -> some View {
        HStack(spacing: 14) {
            // 左侧图标
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill((vm.categoryColors[tip.category] ?? .gray).opacity(0.12))
                    .frame(width: 46, height: 46)
                Image(systemName: tip.iconName)
                    .font(.title3)
                    .foregroundStyle(vm.categoryColors[tip.category] ?? .gray)
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(tip.title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                    Spacer()
                    Text(tip.levelText)
                        .font(.caption2)
                        .fontWeight(.medium)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(levelColor(tip.level).opacity(0.12))
                        .foregroundStyle(levelColor(tip.level))
                        .clipShape(Capsule())
                }

                Text(tip.category)
                    .font(.caption)
                    .foregroundStyle(vm.categoryColors[tip.category] ?? .secondary)
            }
        }
        .padding(14)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.04), radius: 4, y: 2)
    }

    private func levelColor(_ level: Int) -> Color {
        switch level {
        case 1: return .green
        case 2: return .orange
        case 3: return .red
        default: return .green
        }
    }
}
