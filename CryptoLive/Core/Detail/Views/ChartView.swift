//
//  ChartView.swift
//  CryptoLive
//
//  Created by Dev Patel on 8/18/23.
//

import SwiftUI

struct ChartView: View {
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    
    @State private var percentage: Double = 0
    
    init(coin: Coin) {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange >= 0 ? .theme.green : .theme.red
        
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7 * 24 * 60 * 60)
    }
    
    var body: some View {
        VStack {
            chart
                .frame(height: 200)
                .background(chartBackground)
                .overlay(chartYAxis.padding(.horizontal, 4), alignment: .leading)
            
            chartDateLabels
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
    }

}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}

extension ChartView {
    private var chart: some View {
        GeometryReader { geo in
            Path { path in
                for i in data.indices {
                    let xPos = geo.size.width / CGFloat(data.count) * CGFloat(i + 1)
                    
                    let yAxis = maxY - minY
                    
                    let yPos = (1 - (data[i] - minY) / yAxis) * geo.size.height
                    
                    
                    if i == 0 {
                        path.move(to: CGPoint(x: xPos, y: yPos))
                    }
                    path.addLine(to: CGPoint(x: xPos, y: yPos))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0, y: 10)

        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((minY + maxY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartDateLabels: some View {
        HStack {
            Text(startingDate.formatted(date: .numeric, time: .omitted))
            Spacer()
            Text(endingDate.formatted(date: .numeric, time: .omitted))
        }
    }
}
