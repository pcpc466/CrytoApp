//
//  SettingsView.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 9/25/22.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let personalURL = URL(string: "https://www.dropbox.com/sh/or0tud4f4i8xmvk/AABo2VGbADQPh1B9CB1eYxsja?dl=0")!
    var body: some View {
        NavigationView {
            List {
                section1
                section2
                section3
            }
            .accentColor(.blue)
            .font(.headline)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Xmark()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}

extension SettingsView {
    
    private var section1: some View {
        Section(header: Text("Crypto App")) {
            VStack (alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This is a demo crypto currency tracker applcation. Based on swift and swiftUI and uses MVVM Architecture, Combine framework and CoreData.")
                    .font(.callout)
                    .foregroundColor(Color.theme.accent)
            }
            .padding()
            Link(destination: youtubeURL, label: {
                Text("Youtube link here.")
                   
            })
            Link(destination: defaultURL, label: {
                Text("Polices")
                   
            })

        }
    }
    private var section2: some View {
        Section(header: Text("CoinGecko")) {
            VStack (alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .frame( height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The API that has been used to pull the crypto currency data is coingecko.")
                    .font(.callout)
                    .foregroundColor(Color.theme.accent)
            }
            .padding()
            Link(destination: coingeckoURL, label: {
                Text("Visit Coingecko")
                   
            })

        }
    }
    private var section3: some View {
        Section(header: Text("Developer")) {
            VStack (alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was developer by prashant Chauhan. Explore his journey as a self taught developer on instagram and check out his other projects using the link below.")
                    .font(.callout)
                    .foregroundColor(Color.theme.accent)
            }
            .padding()
            Link(destination: personalURL, label: {
                Text("Checkout other projects")
                   
            })
            Link(destination: defaultURL, label: {
                Text("IGLink")
                   
            })
            Link(destination: defaultURL, label: {
                Text("Terms Of Service")
                   
            })
            Link(destination: defaultURL, label: {
                Text("Privacy Policy")
                   
            })
            Link(destination: defaultURL, label: {
                Text("Learn More")
                   
            })

        }
    }
}
