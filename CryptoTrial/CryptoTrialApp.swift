//
//  CryptoTrialApp.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 8/16/22.
//

import SwiftUI

@main
struct CryptoTrialApp: App {
    @StateObject private var vm = HomeViewModel()
    @State private var showLaunchView: Bool = true
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    HomeView()
                        .navigationBarHidden(true)
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .environmentObject(vm)
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                   
                }
                .zIndex(2.0)
            }
        }
    }
}


///GITHUB TOKEN

//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
