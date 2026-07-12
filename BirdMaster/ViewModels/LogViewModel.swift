import SwiftUI
import SwiftData

@MainActor
final class LogViewModel: ObservableObject {
    @Published var showingAddSheet = false
    @Published var sortOrder: SortOrder = .dateDesc

    enum SortOrder: String, CaseIterable {
        case dateDesc = "最新优先"
        case dateAsc = "最早优先"
        case speciesAsc = "鸟种 A-Z"
    }

    func records(query: Query<SightingRecord, [SightingRecord]>) -> [SightingRecord] {
        let sortDescriptors: [SortDescriptor<SightingRecord>] = {
            switch sortOrder {
            case .dateDesc:
                return [SortDescriptor(\.date, order: .reverse)]
            case .dateAsc:
                return [SortDescriptor(\.date)]
            case .speciesAsc:
                return [SortDescriptor(\.speciesName), SortDescriptor(\.date, order: .reverse)]
            }
        }()

        let descriptor = FetchDescriptor<SightingRecord>(sortBy: sortDescriptors)
        guard let context = query.modelContext else { return [] }
        return (try? context.fetch(descriptor)) ?? []
    }

    func deleteRecord(_ record: SightingRecord, context: ModelContext) {
        context.delete(record)
        try? context.save()
    }
}
