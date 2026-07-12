import SwiftUI
import SwiftData

@main
struct BirdMasterApp: App {
    let container: ModelContainer

    init() {
        do {
            container = try ModelContainer(
                for: BirdSpecies.self, PhotographyTip.self, SightingRecord.self
            )
            SeedDataService.seedIfNeeded(context: container.mainContext)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
