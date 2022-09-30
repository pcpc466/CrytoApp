//
//  Xmark.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 8/28/22.
//

import SwiftUI

struct Xmark: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

struct Xmark_Previews: PreviewProvider {
    static var previews: some View {
        Xmark()
    }
}
