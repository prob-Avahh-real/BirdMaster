import SwiftUI
import SwiftData

struct HandbookListView: View {
    @StateObject private var vm = HandbookViewModel()
    @Query(sort: \BirdSpecies.sortOrder) private var birdsQuery: [BirdSpecies]
    @State private var isSearching = false
    @Environment(\.modelContext) private var context

    var displayedBirds: [BirdSpecies] {
        vm.birds(query: _birdsQuery, searchActive: isSearching)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // 分类横向滚动
                categoryBar

                // 鸟种列表
                if displayedBirds.isEmpty {
                    ContentUnavailableView(
                        "没有找到相关鸟种",
                        systemImage: "bird.fill",
                        description: Text("尝试其他分类或搜索词")
                    )
                } else {
                    List {
                        ForEach(displayedBirds) { bird in
                            NavigationLink(destination: BirdDetailView(bird: bird)) {
                                birdRow(bird)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("观鸟手册")
            .searchable(text: $vm.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: vm.searchText) { _, newValue in
                isSearching = !newValue.isEmpty
            }
        }
    }

    // MARK: - Category Bar
    private var categoryBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                // 全部按钮
                categoryChip("全部", icon: "square.grid.2x2.fill", color: .gray,
                             isSelected: vm.selectedCategory == nil) {
                    vm.selectedCategory = nil
                }

                ForEach(vm.categories, id: \.self) { cat in
                    categoryChip(
                        cat,
                        icon: vm.categoryIcons[cat] ?? "bird.fill",
                        color: vm.categoryColors[cat] ?? .gray,
                        isSelected: vm.selectedCategory == cat
                    ) {
                        vm.selectedCategory = (vm.selectedCategory == cat) ? nil : cat
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
        }
        .background(.regularMaterial)
    }

    private func categoryChip(
        _ title: String, icon: String, color: Color,
        isSelected: Bool, action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.caption)
                Text(title)
                    .font(.subheadline)
                    .fontWeight(isSelected ? .semibold : .regular)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .background(isSelected ? color.opacity(0.15) : Color(.systemGray6))
            .foregroundStyle(isSelected ? color : .secondary)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(isSelected ? color : .clear, lineWidth: 1)
            )
        }
    }

    // MARK: - Bird Row
    private func birdRow(_ bird: BirdSpecies) -> some View {
        HStack(spacing: 12) {
            // 图标占位
            ZStack {
                Circle()
                    .fill(vm.categoryColors[bird.category]?.opacity(0.15) ?? .gray.opacity(0.15))
                    .frame(width: 50, height: 50)
                Image(systemName: bird.iconName)
                    .font(.title3)
                    .foregroundStyle(vm.categoryColors[bird.category] ?? .gray)
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(bird.name)
                        .font(.headline)
                    if bird.protectionLevel.contains("一级") {
                        Text("一级")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background(.red, in: Capsule())
                    } else if bird.protectionLevel.contains("二级") {
                        Text("二级")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background(.orange, in: Capsule())
                    }
                }
                Text(bird.scientificName)
                    .font(.caption)
                    .italic()
                    .foregroundStyle(.secondary)
                HStack(spacing: 8) {
                    Label("\(Int(bird.bodyLength))cm", systemImage: "ruler")
                    Label(bird.category, systemImage: "tag.fill")
                    // 拍摄难度星级
                    HStack(spacing: 1) {
                        ForEach(0..<bird.photographyDifficulty, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .font(.system(size: 8))
                                .foregroundStyle(.yellow)
                        }
                        Text("拍")
                            .font(.system(size: 10))
                            .foregroundStyle(.secondary)
                    }
                }
                .font(.caption2)
                .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}
