//
//  PortfolioView.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 8/28/22.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var vm: HomeViewModel
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (alignment: .leading, spacing: 0){
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portFolioInputSection
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Xmark()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButton
                }
            })
            .onChange(of: vm.searchText , perform: { value in
                if value  == "" {
                    removeSelectedCoin()
                }
               
            })
            
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
            .preferredColorScheme(.dark)
    }
}

extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture{
                            withAnimation(.easeIn) {
                             updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(selectedCoin?.id == coin.id ?  Color.theme.focus : Color.clear, lineWidth: 1.0)
                        )
                }
            }
            .frame(height: 120)
            .padding(.leading)
        })
    }
    
    private var portFolioInputSection: some View {
        VStack(spacing: 20){
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""): ")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount Holding")
                Spacer()
                TextField("Ex: 1.4 ", text: $quantityText)
                    .foregroundColor(Color.theme.secondaryText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("current value: ")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
            
        }
        .animation(.none)
        .font(.headline)
        .padding()
    }
    
    private var trailingNavBarButton: some View {
        
        HStack{
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1.0 : 0.0)
            Button(action: {
                saveButtonPressed()
            }, label: {
                Text("Save".uppercased())
                    .opacity(
                        (selectedCoin != nil && selectedCoin?.curentHoldings != Double(quantityText)) ? 1.0 : 0.0
                    )
            })
        }
        .font(.headline)
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        if
        let portfolioCoin = vm.portfolioCoins.first(where: {$0.id == coin.id}),
            let amount = portfolioCoin.curentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
    
    private func getCurrentValue() -> Double {
        if let quanitity = Double(quantityText) {
            return quanitity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveButtonPressed() {
        guard
        let coin = selectedCoin,
        let amount = Double(quantityText)
        else
        { return }
        
        // save portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        //show chceckmark
        
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
        }
            //hide keyboard
            UIApplication.shared.endEditing()
            
            //hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.easeOut) {
                    showCheckMark = false
                }
            }
        
    }
    
    private func removeSelectedCoin() {
    selectedCoin = nil
        vm.searchText = ""
    }
}
