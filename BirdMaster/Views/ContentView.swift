import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HandbookListView()
                .tabItem {
                    Label("手册", systemImage: "bird.fill")
                }

            TipsListView()
                .tabItem {
                    Label("秘笈", systemImage: "camera.fill")
                }

            SightingLogView()
                .tabItem {
                    Label("记录", systemImage: "bookmark.fill")
                }

            SettingsView()
                .tabItem {
                    Label("设置", systemImage: "gearshape.fill")
                }
        }
        .tint(.green)
    }
}

#Preview {
    ContentView()
}
