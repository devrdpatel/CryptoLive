//
//  StatisticView.swift
//  CryptoLive
//
//  Created by Dev Patel on 8/10/23.
//

import SwiftUI

struct StatisticView: View {
    let stat: Statistic
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(.degrees(stat.unwrappedPercentage >= 0 ? 0 : 180))
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                .bold()
            }
            .foregroundColor(stat.unwrappedPercentage >= 0 ? .theme.green : .theme.red)
            .opacity(stat.percentageChange == nil ? 0 : 1.0)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticView(stat: dev.stat1)
            StatisticView(stat: dev.stat2)
            StatisticView(stat: dev.stat3)
        }
        .previewLayout(.sizeThatFits)
    }
}
