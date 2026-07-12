import SwiftUI
import SwiftData

struct SightingLogView: View {
    @StateObject private var vm = LogViewModel()
    @Query private var recordsQuery: [SightingRecord]
    @Environment(\.modelContext) private var context

    var displayedRecords: [SightingRecord] {
        vm.records(query: _recordsQuery)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // 排序切换 + 统计
                toolbarSection

                if displayedRecords.isEmpty {
                    ContentUnavailableView(
                        "还没有观鸟记录",
                        systemImage: "bookmark.slash",
                        description: Text("点击右上角 + 添加你的第一次记录")
                    )
                } else {
                    List {
                        ForEach(displayedRecords) { record in
                            recordRow(record)
                        }
                        .onDelete(perform: deleteRecords)
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("观鸟记录")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        vm.showingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $vm.showingAddSheet) {
                AddSightingView { _ in
                    vm.showingAddSheet = false
                }
            }
        }
    }

    // MARK: - Toolbar
    private var toolbarSection: some View {
        VStack(spacing: 0) {
            // 统计条
            if !displayedRecords.isEmpty {
                HStack {
                    Label("\(displayedRecords.count) 条记录", systemImage: "list.bullet")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Spacer()

                    // 独特鸟种统计
                    let uniqueSpecies = Set(displayedRecords.map(\.speciesName)).count
                    Label("\(uniqueSpecies) 种", systemImage: "bird.fill")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 8)

                Divider()

                // 排序
                Picker("排序", selection: $vm.sortOrder) {
                    ForEach(LogViewModel.SortOrder.allCases, id: \.self) { order in
                        Text(order.rawValue).tag(order)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
        }
        .background(.regularMaterial)
    }

    // MARK: - Record Row
    private func recordRow(_ record: SightingRecord) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "bird.fill")
                    .foregroundStyle(.green)
                Text(record.speciesName)
                    .font(.headline)
                Spacer()
                Text("×\(record.count)")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.green)
            }

            HStack(spacing: 16) {
                Label(record.date.formatted(date: .numeric, time: .omitted), systemImage: "calendar")
                Label(record.location, systemImage: "mappin.and.ellipse")
                Label(record.weather, systemImage: "cloud.sun.fill")
            }
            .font(.caption)
            .foregroundStyle(.secondary)

            if !record.notes.isEmpty {
                Text(record.notes)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
    }

    private func deleteRecords(at offsets: IndexSet) {
        for index in offsets {
            vm.deleteRecord(displayedRecords[index], context: context)
        }
    }
}
