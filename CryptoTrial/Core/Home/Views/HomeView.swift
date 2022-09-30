//
//  HomeView.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 8/16/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false //animate right
    @State private var showPortfolioView: Bool = false //new sheet
    @State private var showSettingsView: Bool = false // new sheet
    
    @State private var selectCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false
    
    var body: some View {
        ZStack {
            // background Layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                        .environmentObject(vm)
                })
            
            //Content Layer
            VStack{
                homeHeader
                
                HomeStatsView(showPortFolio: $showPortfolio)
                
                SearchBarView(searchText: $vm.searchText)
                
                descriptionColoumn
            
                
                if !showPortfolio {
                    allCoinsList
                    .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    ZStack (alignment: .top) {
                        if vm.portfolioCoins.isEmpty && vm.searchText.isEmpty {
                            Text("You haven't added any coins to your portfolio yet. Click the + button to add coins to your portfolio")
                                .font(.callout)
                                .foregroundColor(Color.theme.secondaryText)
                                .fontWeight(.medium)
                                .padding(50)
                        } else
                        {
                            portfolioCoinsList
                        }
                    }
                    .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
            .sheet(isPresented: $showSettingsView, content: {
                SettingsView()
            })
        }
        .background(
        NavigationLink(
            destination: DetailLoadingView(coin: $selectCoin),
            isActive: $showDetailView,
            label: {
                EmptyView()
            })
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        HomeView()
            .foregroundColor(Color.theme.focus)
            .preferredColorScheme(.dark)
            .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}

extension HomeView {
    private var homeHeader: some View {
        
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture(perform: {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    } else {
                        showSettingsView.toggle()
                    }
                })
                
                .background(
                CircleButtonAnimaionView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.focus)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture(perform: {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                })
        }
       
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List{
            ForEach(vm.allCoins) {coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture{
                        segue(coin: coin)
                    }

            
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinsList: some View {
        List{
            ForEach(vm.portfolioCoins) {coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture{
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private func segue(coin: CoinModel) {
        selectCoin = coin
        showDetailView.toggle()
    }
    
    private var descriptionColoumn: some View {
        HStack {
            HStack {
                Text("Coin")
                Image(systemName: "chevron.down")
              
                    .opacity((vm.sortOptions == .rank || vm.sortOptions == .rankReversed) ? 0.5 : 1.0)
                    .rotationEffect(Angle(degrees: vm.sortOptions == .rank ? 180: 0))
                    .onTapGesture{
                        withAnimation(.default) {
                            vm.sortOptions = vm.sortOptions == .rank ? .rankReversed : .rank
                        }
                    }
            }
            
            Spacer()
            if showPortfolio {
                HStack {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOptions == .holdings || vm.sortOptions == .holdingReversed) ? 0.5 : 1.0)
                        .rotationEffect(Angle(degrees: vm.sortOptions == .holdings ? 0: 180))
                        .onTapGesture(perform: {
                            withAnimation(.default) {
                                vm.sortOptions = vm.sortOptions == .holdings ? .holdingReversed : .holdings
                            }
                        
                        })
                }
                    .padding()
            }
            HStack {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOptions == .price || vm.sortOptions == .priceReversed) ? 0.5 : 1.0)
                    .rotationEffect(Angle(degrees: vm.sortOptions == .price ? 180: 0))
                    .onTapGesture{
                        withAnimation(.default) {
                            vm.sortOptions = vm.sortOptions == .price ? .priceReversed : .price
                        }
                    }
                Button(action: {
                    withAnimation(.linear(duration: 2.0)) {
                        vm.reloadData()
                    }
                }, label: {
                    Image(systemName: "goforward")
                })
                .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
            }
            
        }
                .padding(.horizontal)
        .font(.callout)
    }
}
