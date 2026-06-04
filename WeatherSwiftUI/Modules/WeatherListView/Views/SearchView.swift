import SwiftUI
import RswiftResources

struct SearchView: View {

    // MARK: - Private property
    
    @Environment(\.dismissSearch) var dismissSearch
    @Binding private var selectedItem: String
    @State private var data: [String] = ["1", "2", "3"]
    
    // MARK: - UI elements
    
    var body: some View {
        List(data, id: \.self) { item in
            Text(item)
                .listRowBackground(Colors.background)
                .foregroundStyle(Colors.font)
                .listRowSeparatorTint(Colors.font)
                .onTapGesture {
                    selectedItem = item
                    dismissSearch()
                }
        }
        .background(Colors.background)
        .listStyle(.plain)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(Colors.navBarBackground, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    // MARK: - Initialaizers
    
    init(selectedItem: Binding<String>) {
        self._selectedItem = selectedItem
    }
    
}

// MARK: - Extension with private subobjects

private extension SearchView {
    
    enum Colors {
        static let background: Color = Color(R.color.backgroundColor() ?? .systemBackground)
        static let font: Color = Color(R.color.secondFontColor() ?? .secondaryLabel)
        static let navBarBackground: Color = Color(R.color.backgroundColor() ?? .systemBackground)
    }
    
}

#Preview {
    SearchView(selectedItem: .constant(""))
}
