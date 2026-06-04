import SwiftUI
import RswiftResources

struct SearchView: View {

    // MARK: - Private property
    
    @Environment(\.dismissSearch) var dismissSearch
    @Binding private var selectedItem: Region?
    @Binding private var data: [Region]
    
    // MARK: - UI elements
    
    var body: some View {
        List(data, id: \.self) { item in
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(Fonts.cellLabel)
                Text(item.country)
                    .font(Fonts.cellSecondaryLabel)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .foregroundStyle(Colors.font)
            .listRowBackground(Colors.background)
            .listRowSeparatorTint(Colors.font)
            .onTapGesture {
                selectedItem = item
                dismissSearch()
                debugPrint("tapped")
            }
        }
        .background(Colors.background)
        .listStyle(.plain)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(Colors.navBarBackground, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    // MARK: - Initialaizers
    
    init(selectedItem: Binding<Region?>, data: Binding<[Region]>) {
        self._selectedItem = selectedItem
        self._data = data
    }
    
}

// MARK: - Extension with private subobjects

private extension SearchView {
    
    enum Colors {
        static let background: Color = Color(R.color.backgroundColor() ?? .systemBackground)
        static let font: Color = Color(R.color.secondFontColor() ?? .secondaryLabel)
        static let navBarBackground: Color = Color(R.color.backgroundColor() ?? .systemBackground)
    }
    
    enum Fonts {
        static let cellLabel: Font = .title3
        static let cellSecondaryLabel: Font = .subheadline
    }
    
}

#Preview {
    SearchView(
        selectedItem: .constant(.init(name: "test", region: "test", country: "Test", lat: 0.00, lon: 0.00)),
        data: .constant([
            .init(name: "test", region: "test", country: "Test", lat: 0.00, lon: 0.00),
            .init(name: "test", region: "test", country: "Test", lat: 0.00, lon: 0.00),
            .init(name: "test", region: "test", country: "Test", lat: 0.00, lon: 0.00)
        ])
    )
}
