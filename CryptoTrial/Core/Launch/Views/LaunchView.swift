//
//  LaunchView.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 9/25/22.
//

import SwiftUI

struct LaunchView: View {
    @State private var loadingText: [String] = "...".map{String($0)}
    @State private var showLoading: Bool = false
    private let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
 
    @State private var counter: Int = 0
    @Binding var showLaunchView: Bool
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            if showLoading {
                Image("logo-transparent")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .transition(AnyTransition.scale.animation(.easeIn))
                    .rotationEffect(.init(degrees: counter == 0 ? 0 : 360))

            }
            
            ZStack {
                if showLoading {
                    HStack {
                        Text("Loading")
                            .font(.system(size: 30))
                            .foregroundColor(Color.theme.secondaryText)
                            .italic()
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .font(.system(size: 30))
                                .foregroundColor(Color.theme.secondaryText)
                                .opacity(counter == index ? 0 : 1)
                        }
                    }
                    
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
                
            }
            .offset( y: 70)
        }
        .onAppear {
            showLoading.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                showLaunchView = false
            }
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.spring()) {
                let lastIndex = loadingText.count - 1
                if counter == lastIndex {
                    counter = 0
                   
                } else {
                    counter += 1
                }
               
            }
        })
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
