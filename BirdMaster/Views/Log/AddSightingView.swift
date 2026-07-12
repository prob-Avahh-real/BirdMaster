import SwiftUI
import SwiftData

struct AddSightingView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    var onSave: ((SightingRecord) -> Void)?

    @State private var speciesName = ""
    @State private var location = ""
    @State private var date = Date()
    @State private var count = 1
    @State private var weather = "晴"
    @State private var notes = ""
    @State private var behaviorObserved = ""

    let weatherOptions = ["晴", "多云", "阴", "小雨", "雾", "雪"]

    // 从手册中获取已知鸟种作为建议
    @Query(sort: \BirdSpecies.name) private var knownBirds: [BirdSpecies]
    @State private var showSpeciesSuggestions = false

    var speciesSuggestions: [String] {
        let allNames = knownBirds.map(\.name)
        guard !speciesName.isEmpty else { return Array(allNames.prefix(8)) }
        return allNames.filter {
            $0.localizedCaseInsensitiveContains(speciesName)
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                // 基本信息
                Section("基本信息") {
                    HStack {
                        TextField("鸟种名称", text: $speciesName)
                            .onChange(of: speciesName) { _, _ in
                                showSpeciesSuggestions = !speciesName.isEmpty
                            }
                        if !speciesName.isEmpty {
                            Button {
                                speciesName = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }

                    if showSpeciesSuggestions && !speciesSuggestions.isEmpty {
                        ForEach(speciesSuggestions, id: \.self) { name in
                            Button {
                                speciesName = name
                                showSpeciesSuggestions = false
                            } label: {
                                HStack {
                                    Image(systemName: "bird.fill")
                                        .foregroundStyle(.green)
                                    Text(name)
                                        .foregroundStyle(.primary)
                                }
                            }
                        }
                    }

                    TextField("地点", text: $location)

                    Stepper("数量: \(count)", value: $count, in: 1...999)

                    DatePicker("日期", selection: $date, displayedComponents: .date)
                }

                // 环境
                Section("环境与行为") {
                    Picker("天气", selection: $weather) {
                        ForEach(weatherOptions, id: \.self) { w in
                            HStack {
                                Image(systemName: weatherIcon(for: w))
                                Text(w)
                            }
                            .tag(w)
                        }
                    }

                    TextField("行为记录 (如：觅食、飞行、育雏)", text: $behaviorObserved)
                }

                // 笔记
                Section("笔记") {
                    TextEditor(text: $notes)
                        .frame(minHeight: 80)
                }
            }
            .navigationTitle("添加记录")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("取消") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("保存") { saveRecord() }
                        .disabled(speciesName.trimmingCharacters(in: .whitespaces).isEmpty ||
                                  location.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }

    private func saveRecord() {
        let record = SightingRecord(
            date: date,
            location: location.trimmingCharacters(in: .whitespaces),
            speciesName: speciesName.trimmingCharacters(in: .whitespaces),
            count: count,
            notes: notes.trimmingCharacters(in: .whitespaces),
            behaviorObserved: behaviorObserved.trimmingCharacters(in: .whitespaces),
            weather: weather
        )
        context.insert(record)
        try? context.save()
        onSave?(record)
    }

    private func weatherIcon(for weather: String) -> String {
        switch weather {
        case "晴": return "sun.max.fill"
        case "多云": return "cloud.sun.fill"
        case "阴": return "cloud.fill"
        case "小雨": return "cloud.drizzle.fill"
        case "雾": return "cloud.fog.fill"
        case "雪": return "cloud.snow.fill"
        default: return "cloud.sun.fill"
        }
    }
}
