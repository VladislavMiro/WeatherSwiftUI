import SwiftUI
import RswiftResources

struct AirConditionCell: View {
    
    // MARK: - Private properties
    
    private let label: String
    private let image: String
    private let data: String
    
    // MARK: - UI elements
    
    var body: some View {
        GroupBox(label: Label(label, systemImage: image)
            .lineLimit(Constants.lineLimit)
            .minimumScaleFactor(Constants.minimumScale)
            .foregroundStyle(Colors.labelTint)
            .font(Fonts.label)
        ) {
            HStack(alignment: .center) {
                Text(data)
                    .font(Fonts.dataText)
                    .lineLimit(Constants.lineLimit)
                    .minimumScaleFactor(Constants.minimumScale)
                Spacer()
            }
            .foregroundStyle(Colors.dataText)
            .padding(.vertical)
        }
        .frame(maxHeight: Constants.height)
        .cornerRadius(Constants.cornerRadius)
        .backgroundStyle(Colors.background)
    }
    
    // MARK: - Initialaizers
    
    public init(label: String, image: String, data: String) {
        self.label = label
        self.image = image
        self.data = data
    }
    
}

// MARK: - Extension with private subobjects

private extension AirConditionCell {
    
    enum Colors {
        static let dataText = Color(R.color.fontColor() ?? .font)
        static let labelTint = Color(R.color.secondFontColor() ?? .secondaryLabel)
        static let background = Color(R.color.secondBackgroundColor() ?? .secondarySystemBackground)
    }
    
    enum Fonts {
        static let label: Font = .system(size: 14.0, weight: .bold)
        static let dataText: Font = .system(size: 36.0, weight: .regular)
    }
    
    enum Constants {
        static let cornerRadius: CGFloat = 15.0
        static let height: CGFloat = 125.0
        static let lineLimit: Int = 1
        static let minimumScale: CGFloat = 0.5
    }
    
}

#Preview {
    AirConditionCell(label: "Wind", image: "wind", data: "10")
}
