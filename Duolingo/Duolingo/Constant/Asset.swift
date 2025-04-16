//
//  Asset.swift
//  Duolingo
//
//  Created by PC on 06/01/25.
//

import SwiftUI

let COLOR = AssetColor()

class AssetColor {
    let primaryGreen = Color(#colorLiteral(red: 0.3298856616, green: 0.7584818006, blue: 0.008744089864, alpha: 1))
    let secondaryGreen = Color(#colorLiteral(red: 0.3453077376, green: 0.6464449763, blue: 0, alpha: 1))
    let primaryBlue = Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
    let secondaryBlue = Color(#colorLiteral(red: 0.2401191733, green: 0.5627963879, blue: 0.9686274529, alpha: 1))
    let primaryOrange = Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))
    let secondaryOrange = Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
    let primaryTeal = Color(#colorLiteral(red: 0, green: 0.7803921569, blue: 0.5882352941, alpha: 1))
    let secondaryTeal = Color(#colorLiteral(red: 0, green: 0.6039215686, blue: 0.4588235294, alpha: 1))
    let primaryPink = Color(#colorLiteral(red: 0.8156862745, green: 0.462745098, blue: 0.9803921569, alpha: 1))
    let secondaryPink = Color(#colorLiteral(red: 0.6352941176, green: 0.3607843137, blue: 0.7647058824, alpha: 1))
    let gray = Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
}

extension View {
    
    @ViewBuilder
    func modifier<Content: View>(@ViewBuilder content: @escaping (Self) -> Content) -> some View {
        content(self)
    }
    
}


