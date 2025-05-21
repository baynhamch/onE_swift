//
//  SignalView.swift
//  Algo
//
//  Created by Nicholas Conant-Hiley on 5/19/25.
//

import SwiftUI

struct SignalView: View {
    @State private var ticker = "AAPL"
//    @StateObject private var viewModel = SignalViewModel()

    var body: some View {
        Text(ticker)
//        VStack(spacing: 20) {
//            TextField("Enter ticker", text: $ticker)
//                .textInputAutocapitalization(.characters)
//                .autocorrectionDisabled()
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//
//            Button("Get Signal") {
//                viewModel.fetchSignal(for: ticker)
//            }
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//
//            if viewModel.isLoading {
//                ProgressView()
//            } else if let signal = viewModel.signal {
//                VStack(spacing: 10) {
//                    Text("📈 \(signal.ticker)")
//                        .font(.title2)
//                        .bold()
//                    Text("Signal: \(signal.signal)")
//                        .font(.title)
//                        .foregroundColor(color(for: signal.signal))
//                    Text("Confidence: \(Int(signal.confidence * 100))%")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                }
//                .padding()
//            }
//        }
//        .padding()
    }

//    func color(for signal: String) -> Color {
//        switch signal.uppercased() {
//        case "BUY": return .green
//        case "SELL": return .red
//        default: return .orange
//        }
//    }
}

#Preview {
    SignalView()
}
