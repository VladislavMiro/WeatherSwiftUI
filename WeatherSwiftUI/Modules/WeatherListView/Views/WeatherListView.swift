import SwiftUI
import RswiftResources

struct WeatherListView: View {
    
    // MARK: - Private properties
    
    @StateObject private var viewModel: WeatherListViewModel = WeatherListViewModel()
    
    @State private var isSearching = false
    @State private var path: NavigationPath = NavigationPath()
    @State private var isEdit: Bool = false
    @State private var searchText: String = ""
    
    @State private var selectedItem: String = ""
    @State private var mockData: [String] = ["1", "2", "3"]
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                if isSearching {
                    SearchView(selectedItem: $viewModel.state.selectedRegion, data: $viewModel.state.regions)
                } else {
                    List($mockData, id: \.self) { data in
                        VStack {
                            Color.red
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Colors.background)
                    }
                    .listStyle(.plain)
                    .listRowSpacing(Constants.listRowSpacing)
                }
            }
            .background(Colors.background)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Colors.navBarBackground, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(StringConstants.title)
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
        }
        .searchable(text: $searchText, isPresented: $isSearching, placement: .navigationBarDrawer)
        .keyboardType(.default)
        .onChange(of: searchText) {
            viewModel.send(action: .search(query: searchText))
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
    
    enum Constants {
        static let listRowSpacing: CGFloat = 15.0
    }
}

#Preview {
    WeatherListView()
}
