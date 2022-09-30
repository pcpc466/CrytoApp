//
//  HomeStatsView.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 8/25/22.
//

import SwiftUI

struct HomeStatsView: View {
   
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortFolio: Bool
    var body: some View {
        HStack {
            ForEach(vm.statistic) { (stat)  in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortFolio ? .trailing : .leading)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPortFolio: .constant(true))
            .environmentObject(dev.homeVM)
    }
}
