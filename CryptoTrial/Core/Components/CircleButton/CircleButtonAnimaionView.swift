//
//  CircleButtonAnimaionView.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 8/16/22.
//

import SwiftUI

struct CircleButtonAnimaionView: View {
    @Binding var animate: Bool
    var body: some View {
        Circle()
           
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeOut(duration: 1.0) : .none)
//            .onAppear(perform: {
//                animate.toggle()
//            })
            .foregroundColor(Color.theme.accent)
    }
}

struct CircleButtonAnimaionView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimaionView(animate: .constant(false))
            .preferredColorScheme(.dark)
            .frame(width: 100, height: 100)
    }
}
