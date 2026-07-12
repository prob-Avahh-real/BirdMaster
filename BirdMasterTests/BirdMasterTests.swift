import XCTest
@testable import BirdMaster

final class BirdMasterTests: XCTestCase {
    func testBirdSpeciesModel() {
        let species = BirdSpecies(
            id: "great-tit",
            commonName: "Great Tit",
            scientificName: "Parus major",
            family: "Paridae"
        )
        XCTAssertEqual(species.commonName, "Great Tit")
        XCTAssertEqual(species.scientificName, "Parus major")
    }

    func testSightingRecordModel() {
        let record = SightingRecord(
            id: UUID(),
            speciesId: "great-tit",
            date: Date(),
            location: "Park",
            notes: "Saw near the pond"
        )
        XCTAssertEqual(record.speciesId, "great-tit")
        XCTAssertEqual(record.location, "Park")
        XCTAssertEqual(record.notes, "Saw near the pond")
    }

    func testPhotographyTipModel() {
        let tip = PhotographyTip(
            id: UUID(),
            title: "Golden Hour",
            content: "Best time for bird photography is early morning",
            category: "lighting"
        )
        XCTAssertEqual(tip.title, "Golden Hour")
        XCTAssertEqual(tip.category, "lighting")
    }
}
