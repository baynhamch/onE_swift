import SwiftUI

struct HighlightsView: View {
    @ObservedObject var viewModel: SignalViewModel

    var topBuys: [Signal] {
        Array(
            viewModel.signals.values
                .filter { $0.signal.uppercased() == "BUY" }
                .sorted(by: { $0.confidence > $1.confidence })
                .prefix(3)
        )
    }

    var topSells: [Signal] {
        Array(
            viewModel.signals.values
                .filter { $0.signal.uppercased() == "SELL" }
                .sorted(by: { $0.confidence > $1.confidence })
                .prefix(3)
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Highlights")
                .font(.title3)
                .bold()
                .foregroundColor(.primary)

            if topBuys.isEmpty && topSells.isEmpty {
                Text("No highlights available yet.")
                    .foregroundColor(.gray)
            } else {
                HStack(alignment: .top, spacing: 24) {
                    highlightSection(title: "Top Buys", signals: topBuys, color: .green)
                    Spacer()
                    highlightSection(title: "Top Sells", signals: topSells, color: .red)
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(radius: 4)
    }

    @ViewBuilder
    private func highlightSection(title: String, signals: [Signal], color: Color) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(color)
                .bold()

            if signals.isEmpty {
                Text("No recommendations")
                    .foregroundColor(.gray)
                    .frame(height: 60)
            } else {
                ForEach(signals, id: \.ticker) { signal in
                    HStack {
                        Text(signal.ticker)
                            .font(.system(.body, design: .monospaced))
                            .bold()

                        Spacer()

                        Text("\(Int(signal.confidence * 100))%")
                            .font(.headline)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(color.opacity(0.1))
                            .foregroundColor(color)
                            .clipShape(Capsule())
                    }
                }
            }
        }
        .frame(minHeight: 100, alignment: .top)
    }
}
#Preview {
    let mockViewModel = SignalViewModel()
    mockViewModel.signals = [
        "AAPL": Signal(name: "Apple Inc.", ticker: "AAPL", signal: "BUY", confidence: 0.95, timestamp: nil, reason: "RSI oversold", price: 180.50),
        "TSLA": Signal(name: "Tesla Inc.", ticker: "TSLA", signal: "SELL", confidence: 0.91, timestamp: nil, reason: "RSI overbought", price: 720.00),
        "NVDA": Signal(name: "NVIDIA Corp.", ticker: "NVDA", signal: "BUY", confidence: 0.90, timestamp: nil, reason: "Strong breakout", price: 290.12),
        "META": Signal(name: "Meta Platforms", ticker: "META", signal: "SELL", confidence: 0.89, timestamp: nil, reason: "Weak volume", price: 320.34)
    ]
    return HighlightsView(viewModel: mockViewModel)
        .padding()
        .previewLayout(.sizeThatFits)
}
