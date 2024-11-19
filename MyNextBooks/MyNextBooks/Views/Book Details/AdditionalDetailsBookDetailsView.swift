//
//  AdditionalDetailsBookDetailsView.swift
//  MyNextBooks
//
//  Created by Erich.Flock on 19.11.24.
//

import SwiftUI

struct AdditionalDetailsBookDetailsView: View {
    let additionalDetails: [AdditionalDetail]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                ForEach(additionalDetails) { detail in
                    additionalInformationView(
                        systemImageName: detail.systemImageName,
                        text: detail.title
                    )
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func additionalInformationView(systemImageName: String, text: String) -> some View {
        VStack(spacing: 0) {
            Image(systemName: systemImageName)
                .font(.title2)
            Spacer()
            Text(text)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(2)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .frame(width: 70, height: 80)
    }
    
    struct AdditionalDetail: Identifiable {
        let id = UUID()
        let systemImageName: String
        let title: String
    }
}

#Preview {
    AdditionalDetailsBookDetailsView(additionalDetails: [
        .init(systemImageName: "building.2", title: "Publisher Name"),
        .init(systemImageName: "ruler", title: "333\nPages"),
        .init(systemImageName: "calendar", title: "Nov. 2024"),
        .init(systemImageName: "banknote", title: "100,99 €"),
        .init(systemImageName: "globe", title: "EN")
    ])
}
