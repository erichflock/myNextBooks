//
//  CollapsibleTextView.swift
//  MyNextBooks
//
//  Created by Erich.Flock on 04.11.24.
//

import SwiftUI

struct CollapsibleTextView: View {
    let text: String
    let lineLimit: Int
    let isExpanded: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text(text)
                    .lineLimit(isExpanded ? nil : lineLimit)
                    .animation(.default, value: isExpanded)
                    .font(.body)
                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundStyle(.blue)
            }
        }
    }
}
