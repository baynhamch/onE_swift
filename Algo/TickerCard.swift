////
////  TickerCard.swift
////  Algo
////
////  Created by Nicholas Conant-Hiley on 5/19/25.
////
//
//import SwiftUI
//
//struct TickerCard: View {
//    let signal: Signal
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            HStack {
//                VStack(alignment: .leading) {
//                    Text(signal.name)
//                        .font(.headline)
//                    Text(signal.ticker)
//                    
//                }
//                Spacer()
//                VStack {
//                    Text(signal.signal)
//                        .font(.title2)
//                    
//                    Text(String(format: "$%.2f", signal.price))
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                    
//                }
//            }
//            Text("Confidence: \(Int(signal.confidence * 100))%")
//                .font(.subheadline)
//            
//        }
//        
//        .padding()
//        .background(color(for: signal.signal).opacity(signal.confidence))
//        .cornerRadius(12)
//        .shadow(radius: 5)
//    }
//    
//    func color(for signal: String) -> Color {
//        switch signal.uppercased() {
//        case "BUY": return .green
//        case "SELL": return .red
//        default: return .orange
//        }
//    }
//}
//
//#Preview {
//    TickerCard(signal: Signal(
//        name: "Apple Inc.",
//        ticker: "AAPL",
//        signal: "BUY",
//        confidence: 0.87,
//        timestamp: "2025-05-19T15:55:00Z",
//        reason: "SMA_20 > SMA_50 and RSI < 30",
//        price: 208.76
//    ))
//}
import SwiftUI

struct TickerCard: View {
    let signal: Signal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(signal.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(signal.ticker)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                        .textCase(.uppercase)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(signal.signal)
                        .font(.title3)
                        .bold()
                        .foregroundColor(color(for: signal.signal))
                    
                    Text(String(format: "$%.2f", signal.price))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            HStack {
                Label("\(Int(signal.confidence * 100))% confidence", systemImage: "checkmark.seal")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                if let timestamp = signal.timestamp {
                    Label(signal.formattedTime, systemImage: "clock")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(
            color(for: signal.signal)
                .opacity(0.1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: color(for: signal.signal).opacity(0.2), radius: 4, x: 0, y: 2)
    }
    
    func color(for signal: String) -> Color {
        switch signal.uppercased() {
        case "BUY": return .green
        case "SELL": return .red
        default: return .orange
        }
    }
}
#Preview {
    TickerCard(signal: Signal(
        name: "Apple Inc.",
        ticker: "AAPL",
        signal: "BUY",
        confidence: 0.87,
        timestamp: "2025-05-19T15:55:00Z",
        reason: "SMA_20 > SMA_50 and RSI < 30",
        price: 208.76
    ))
    .padding()
    .previewLayout(.sizeThatFits)
}
