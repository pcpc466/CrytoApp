//
//  CoinRowView.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 8/16/22.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showHoldingColumn: Bool
   
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            if showHoldingColumn {
                centreColumn
            }
            rightColumn
        }
        .font(.subheadline)
      
        .background(Color.theme.background.opacity(0.001))
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin, showHoldingColumn: true)
            .preferredColorScheme(.dark)
    }
}


extension CoinRowView {
    private var leftColumn: some View {
        HStack(spacing: 0){
            Text("\(coin.rank)")

                .font(.system(size: 20))
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
           CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.focus)
        }
    }
    
    private var centreColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingValue.asCurrencyWith2Decimals())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text((coin.curentHoldings ?? 0).asNumberString())
                .foregroundColor(Color.theme.accent)
        }
    }
    
    private var rightColumn: some View{
        VStack (alignment: .trailing){
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0 >= 0) ?
                        Color.theme.green : Color.theme.red
                )
                
        }
        .frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing)
    }
}
