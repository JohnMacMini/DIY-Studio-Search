import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            StudioDirectoryScreen()
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }

            AboutScreen()
                .tabItem {
                    Label("About", systemImage: "hammer")
                }
        }
    }
}

private struct StudioDirectoryScreen: View {
    var body: some View {
        NavigationStack {
            StudioDirectoryWebView()
                .navigationTitle("DIY Studio Search")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct AboutScreen: View {
    private let siteURL = URL(string: "https://diystudiosearch.com")!

    var body: some View {
        NavigationStack {
            List {
                Section("What This App Is") {
                    Text("A North Carolina craft directory for pottery, woodworking, glassblowing, jewelry making, leatherworking, and more.")
                    Text("This first iPhone version bundles the existing directory so people can browse studios on mobile with an app-native shell.")
                }

                Section("Current Coverage") {
                    Label("North Carolina studios only", systemImage: "location.north.carolina.fill")
                    Label("Around 88 total listings", systemImage: "building.2")
                    Label("Featured listings by city and craft", systemImage: "star")
                }

                Section("Project Direction") {
                    Text("The near-term focus is listing density and organic discovery before outreach or heavier monetization.")
                }

                Section("Links") {
                    Link(destination: siteURL) {
                        Label("Visit DIYStudioSearch.com", systemImage: "safari")
                    }

                    ShareLink(item: siteURL) {
                        Label("Share the directory", systemImage: "square.and.arrow.up")
                    }
                }
            }
            .navigationTitle("About")
        }
    }
}
