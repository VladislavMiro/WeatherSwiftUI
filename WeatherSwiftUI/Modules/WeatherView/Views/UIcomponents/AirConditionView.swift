//
//  AirConditionView.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 07.04.2026.
//

import SwiftUI
import RswiftResources

struct AirConditionView: View {
    
    private var buttonTapped: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text(StringConstants.title)
                    .font(Fonts.title)
                    .foregroundStyle(Colors.title)
                
                Spacer()
                    
                Button {
                    buttonTapped?()
                } label: {
                    Text(StringConstants.buttonTitle)
                        .foregroundStyle(Colors.buttonTitle)
                        .padding(.vertical, LayoutConstants.buttonVPadding)
                        .padding(.horizontal, LayoutConstants.buttonHPadding)
                }
                .background(
                    RoundedRectangle(cornerRadius: LayoutConstants.buttonCornerRadius)
                        .fill(Colors.buttonBackground)
                )
            }
            
            LazyVGrid(columns: [
                .init(.adaptive(minimum: LayoutConstants.gridItemSize)),
                .init(.adaptive(minimum: LayoutConstants.gridItemSize))
            ], alignment: .leading, spacing: LayoutConstants.gridSpacing) {
                ForEach(AirConditionItems.allCases, id: \.self) { item in
                    createGridItem(of: item)
                }
            }
            .padding(.vertical)
            
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                .fill(Colors.background)
        )
    }
    
    // MARK: - Initialaizers
    
    public init(buttonTapped: (() -> Void)? = nil) {
        self.buttonTapped = buttonTapped
    }
    
}

// MARK: - Extension with private methods

private extension AirConditionView {
    
    func createGridItem(of item: AirConditionItems) -> some View {
        var data: String = ""
        
        switch item {
        case .feelsLike:
            data = "\(14) " + Symbols.celciusSymbol.description
        case .wind:
            data = "\(14) " + Symbols.kmPerHour.description
        case .chanceOfRain:
            data = "\(14)" + Symbols.precent.description
        case .uvIndex:
            data = "\(14)"
        }
        
        return VStack(alignment: .leading, spacing: LayoutConstants.gridItemSpacing) {
            HStack(alignment: .center) {
                Image(systemName: item.image)
                Text(item.title)
            }
            
            Text(data)
                .foregroundStyle(Colors.gridItemDataLabel)
        }
        .font(Fonts.gridItem)
        .foregroundStyle(Colors.gridItemForeground)
        
    }
    
}

// MARK: - Extension with private subobjects

private extension AirConditionView {
    
    enum AirConditionItems: CaseIterable {
        case feelsLike
        case wind
        case chanceOfRain
        case uvIndex
        
        var title: String {
            switch self {
            case .feelsLike: R.string.localizable.airConditionViewRealFeelItemTitle()
            case .wind: R.string.localizable.airConditionViewWindItemTitle()
            case .chanceOfRain: R.string.localizable.airConditionViewRainChanceItemTitle()
            case .uvIndex: R.string.localizable.airConditionViewUvIndexItemTitle()
            }
        }
        
        var image: String {
            switch self {
            case .feelsLike: "thermometer.medium"
            case .wind: "wind"
            case .chanceOfRain: "drop.fill"
            case .uvIndex: "sun.max.fill"
            }
        }
    }
    
    enum LayoutConstants {
        static let headerStackHorizontalOffset: CGFloat = 15.0
        static let gridStackTopOffset: CGFloat = 10.0
        static let gridStackLeadingOffset: CGFloat = 5.0
        
        static let cornerRadius: CGFloat = 15.0
        static let gridItemSize: CGFloat = 100.0
        static let gridSpacing: CGFloat = 20.0
        static let gridItemSpacing: CGFloat = 15.0
        static let buttonVPadding: CGFloat = 6.0
        static let buttonHPadding: CGFloat = 18.0
        static let buttonCornerRadius: CGFloat = 10.0
    }
    
    enum Fonts {
        static let title: Font = .system(size: 16.0, weight: .bold)
        static let gridItem: Font = .system(size: 16.0)
    }
    
    enum StringConstants {
        static let title: String = R.string.localizable.airConditionViewTitle()
        static let buttonTitle: String = R.string.localizable.airConditionViewSeeMoreButtonTitle()
    }
    
    enum Colors {
        static let background: Color = Color(R.color.secondBackgroundColor() ?? .secondarySystemBackground)
        static let title: Color = Color(R.color.secondFontColor() ?? .secondaryLabel)
        static let buttonBackground: Color = Color(uiColor: .systemBlue)
        static let buttonTitle: Color = .white
        static let gridItemForeground: Color = Color(R.color.secondFontColor() ?? .secondaryLabel)
        static let gridItemDataLabel: Color = .white
    }
    
}

#Preview {
    AirConditionView()
}
