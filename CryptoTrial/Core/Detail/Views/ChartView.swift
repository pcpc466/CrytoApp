//
//  ChartView.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 9/12/22.
//

import SwiftUI

struct ChartView: View {
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    @State private var percentage: CGFloat = 0
    
    init(coin: CoinModel) {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    
    ///have to go through the logic again
    
    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background(
                    chartBackground
                )
                .overlay(chartValueY.padding(.horizontal, 4), alignment: .leading)
            chartValueX
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 1.5)) {
                    percentage = 1.0
                }
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
           
    }
}

extension ChartView {
    
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                
                for index in data.indices {
                    let xPostion = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let YPostion = (1 - CGFloat ((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: 0, y: 0))
                    }
                    path.addLine(to: CGPoint(x: xPostion, y: YPostion))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor , style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 30)
           


        }
    }
    
    private var chartBackground: some View {
        VStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.accentColor).opacity(0.3)
            Spacer()
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.accentColor).opacity(0.3)
        }
    }
    
    private var chartValueY: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
        .foregroundColor(Color.theme.secondaryText)
    }
    private var chartValueX: some View {
        HStack {
            Text(startingDate.shortDateString())
            Spacer()
            Text(endingDate.shortDateString())
        }
        .foregroundColor(Color.theme.secondaryText)
    }
}
