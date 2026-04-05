//
//  MainView.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 05.04.2026.
//

import SwiftUI
import RswiftResources

@MainActor
struct MainView: View {
    
    @StateObject private var viewModel: MainViewModel
    
    public init(viewModel: MainViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        configureTabBar()
    }
    
    var body: some View {
        TabView(selection: $viewModel.coordinator.selectedTab) {
            VStack {
                viewModel.coordinator.showWeatherView()
            }
            .ignoresSafeArea()
            .tag(MainViewTabs.current)
            .tabItem {
                Image(systemName: MainViewTabs.current.image)
                Text(MainViewTabs.current.localizedTitle)
            }
            
            VStack {
                viewModel.coordinator.showListView()
            }
            .ignoresSafeArea()
            .tag(MainViewTabs.list)
            .tabItem {
                Image(systemName: MainViewTabs.list.image)
                Text(MainViewTabs.list.localizedTitle)
            }
        }
        .tint(Colors.selectedTab)
        
    }
    
    private func configureTabBar() {
        let standardAppearance = UITabBarAppearance()
        let scrollAppearance = UITabBarAppearance()
        let itemAppearance = UITabBarItemAppearance()
        
        itemAppearance.normal.titleTextAttributes = [.foregroundColor : Colors.deselectedTab]
        itemAppearance.normal.iconColor = Colors.deselectedTab
        
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.stackedLayoutAppearance = itemAppearance
        standardAppearance.backgroundColor = Colors.tabBarStandartBackground
        
        scrollAppearance.configureWithOpaqueBackground()
        scrollAppearance.stackedLayoutAppearance = itemAppearance
        scrollAppearance.backgroundColor = Colors.tabBarScrollBackground
        
        UITabBar.appearance().standardAppearance = standardAppearance
        UITabBar.appearance().scrollEdgeAppearance = scrollAppearance
    }
}

// MARK: - Extension with private subobjects

private extension MainView {
    
    enum Colors {
        static let background: Color = Color(R.color.backgroundColor() ?? .systemBackground)
        static let tabBarStandartBackground: UIColor = R.color.secondBackgroundColor() ?? .secondarySystemBackground
        static let tabBarScrollBackground: UIColor = (R.color.secondBackgroundColor() ?? .secondarySystemBackground).withAlphaComponent(0.95)
        static let selectedTab: Color = Color(R.color.fontColor() ?? .white)
        static let deselectedTab: UIColor = R.color.secondFontColor() ?? .lightText
    }
    
}

#Preview {
    var coordinator = MainViewCoordinator()
    let viewModel = MainViewModel(coordinator: coordinator)
    
    MainView(viewModel: viewModel)
}
