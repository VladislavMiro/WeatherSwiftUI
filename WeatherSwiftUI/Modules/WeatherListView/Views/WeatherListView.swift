import SwiftUI
import RswiftResources

struct WeatherListView: View {
    
    // MARK: - Private properties
    
    @StateObject private var viewModel: WeatherListViewModel
    
    @State private var isSearching = false
    @State private var path: NavigationPath = NavigationPath()
    @State private var isEdit: Bool = false
    @State private var searchText: String = ""
    
    @State private var mockData: [String] = ["1", "2", "3"]
    
    // MARK: - UI elements
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                if isSearching {
                    SearchView(selectedItem: $viewModel.state.selectedRegion, data: $viewModel.state.regions)
                        .onDisappear {
                            viewModel.send(action: .cancelTasks)
                        }
                } else {
                    List($mockData, id: \.self) { data in
                        WeatherListCell(temperature: "10", region: "Moscow, Russia", icon: "d113")
                            .modifier(WeatherListCellStyle())
                    }
                    .listStyle(.plain)
                    .listRowSpacing(Constants.listRowSpacing)
                }
            }
            .background(Colors.background)
            .modifier(WeatherListNavBarStyle())
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
        .submitLabel(.done)
        .onChange(of: searchText) {
            viewModel.send(action: .search(query: searchText))
        }
        .onDisappear {
            viewModel.send(action: .cancelTasks)
        }
        .alert(StringConstants.errorTitle, isPresented: $viewModel.state.isError) {
            Button {
                viewModel.send(action: .closeAlert)
            } label: {
                Text(StringConstants.okButtonTitle)
            }
        } message: {
            Text(viewModel.state.errorMessage)
        }

    }
    
    // MARK: - Initialaizers
    
    public init(viewModel: WeatherListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
}

// MARK: - Extension with private subobjects

private extension WeatherListView {
    
    enum Colors {
        static let background: Color = Color(R.color.backgroundColor() ?? .systemBackground)
        static let editButton: Color = Color(R.color.fontColor() ?? .systemBlue)
    }
    
    enum StringConstants {
        static let title: String = "Weather"
        static let editButtonTitle: String = "Edit"
        static let errorTitle: String = "Error"
        static let okButtonTitle: String = "OK"
    }
    
    enum Constants {
        static let listRowSpacing: CGFloat = 10.0
    }
}

#Preview {
    let viewModel = WeatherListViewModel(networkService: NetworkService())
    
    WeatherListView(viewModel: viewModel)
}
