//
//  Image+Format.swift
//  MyNextBooks
//
//  Created by Erich.Flock on 29.08.24.
//

import SwiftUI

extension Image {
    func formattedImage(width: CGFloat, height: CGFloat) -> some View {
        self
        .resizable()
        .frame(width: width, height: height)
        .clipShape(.rect(cornerRadius: 10))
    }
}
