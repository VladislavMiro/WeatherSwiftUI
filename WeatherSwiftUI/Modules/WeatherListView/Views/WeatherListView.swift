import SwiftUI
import RswiftResources

struct WeatherListView: View {
    
    // MARK: - Private properties
    
    @StateObject private var viewModel: WeatherListViewModel

    @State private var path: NavigationPath = NavigationPath()
    
    // MARK: - UI elements
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                if viewModel.state.isSearching {
                    SearchView(
                        data: Binding(get: { viewModel.state.regions },
                                      set: { _ in })
                    ) { item in
                        viewModel.send(action: .selectRegion(item))
                    }
                } else {
                    List {
                        ForEach(viewModel.state.weather) { item in
                            WeatherListCell(temperature: item.temperature,
                                            region: item.location,
                                            icon: item.icon)
                            .modifier(WeatherListCellStyle())
                        }
                        .onDelete { indexes in
                            viewModel.send(action: .deleteItems(indexes))
                        }
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
                    EditButton()
                }
            }
        }
        .searchable(text: Binding(get: { viewModel.state.searchText },
                                  set: { viewModel.send(action: .searchTextChanged($0)) }),
                    isPresented: Binding(get: { viewModel.state.isSearching },
                                         set: { viewModel.send(action: .searchModeChanged($0)) }),
                    placement: .navigationBarDrawer)
        .keyboardType(.default)
        .submitLabel(.done)
        .onAppear {
            viewModel.send(action: .loadRegions)
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
        static let errorTitle: String = "Error"
        static let okButtonTitle: String = "OK"
    }
    
    enum Constants {
        static let listRowSpacing: CGFloat = 10.0
    }
}

#Preview {
    let viewModel = WeatherListViewModel(networkService: NetworkService(),
                                         storageManager: StorageManger())
    
    WeatherListView(viewModel: viewModel)
}
