import SwiftUI
import RswiftResources

struct WeatherListView: View {
    
    @State private var path: NavigationPath = NavigationPath()
    @State private var isEdit: Bool = false
    @State private var searchText: String = ""
    
    @State private var mockData: [String] = ["1", "2", "3"]
    
    var body: some View {
        NavigationStack(path: $path) {
            List($mockData, id: \.self) { data in
                VStack {
                    Color.red
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Colors.background)
            }
            .background(Colors.background)
            .listStyle(.plain)
            .listRowSpacing(15)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Colors.navBarBackground, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(StringConstants.title)
            .searchable(text: $searchText, placement: .navigationBarDrawer)
            .searchScopes($searchText, scopes: {
                VStack {
                    Color.blue
                }
            })
            .keyboardType(.default)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isEdit.toggle()
                    }) {
                        Text(StringConstants.editButtonTitle)
                            .foregroundStyle(Colors.editButton)
                    }
                }
            }
            .onChange(of: searchText) {
                debugPrint("search: " + searchText)
            }
            
        }
    }
}

// MARK: - Extension with private subobjects

private extension WeatherListView {
    
    enum Colors {
        static let background: Color = Color(R.color.backgroundColor() ?? .systemBackground)
        static let editButton: Color = Color(R.color.fontColor() ?? .systemBlue)
        static let navBarBackground: Color = Color(R.color.backgroundColor() ?? .secondarySystemBackground)
    }
    
    enum StringConstants {
        static let title: String = "Weather"
        static let editButtonTitle: String = "Edit"
    }
}

#Preview {
    WeatherListView()
}
