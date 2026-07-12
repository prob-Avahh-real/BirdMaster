import SwiftUI
import SwiftData
import Combine

@MainActor
final class HandbookViewModel: ObservableObject {
    @Published var selectedCategory: String?
    @Published var searchText: String = ""

    let categories = ["涉禽", "猛禽", "鸣禽", "游禽", "攀禽", "陆禽"]
    let categoryIcons: [String: String] = [
        "涉禽": "drop.fill",
        "猛禽": "flame.fill",
        "鸣禽": "music.note",
        "游禽": "water.waves",
        "攀禽": "tree.fill",
        "陆禽": "leaf.fill"
    ]
    let categoryColors: [String: Color] = [
        "涉禽": .blue,
        "猛禽": .red,
        "鸣禽": .orange,
        "游禽": .cyan,
        "攀禽": .green,
        "陆禽": .brown
    ]

    func birds(query: Query<BirdSpecies, [BirdSpecies]>, searchActive: Bool) -> [BirdSpecies] {
        let descriptor = FetchDescriptor<BirdSpecies>(
            sortBy: [SortDescriptor(\.sortOrder)]
        )
        guard let context = query.modelContext else { return [] }
        guard let allBirds = try? context.fetch(descriptor) else { return [] }

        var result = allBirds

        if let category = selectedCategory {
            result = result.filter { $0.category == category }
        }

        if searchActive, !searchText.isEmpty {
            result = result.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.englishName.localizedCaseInsensitiveContains(searchText) ||
                $0.scientificName.localizedCaseInsensitiveContains(searchText)
            }
        }

        return result
    }
}
