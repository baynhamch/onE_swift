import Foundation
import SwiftUI

struct Signal: Codable {
    let name: String
    let ticker: String
    let signal: String
    let confidence: Double
    let timestamp: String?
    let reason: String
    let price: Double
}
extension Signal {
    var formattedTime: String {
        guard let timestamp = timestamp else { return "—" }
        
        let inputFormatter = ISO8601DateFormatter()

        if let date = inputFormatter.date(from: timestamp) {
            let outputFormatter = DateFormatter()
            outputFormatter.timeStyle = .short
            outputFormatter.dateStyle = .short // or `.none` if you want just time
            return outputFormatter.string(from: date)
        } else {
            return "Invalid date"
        }
    }
}

class SignalViewModel: ObservableObject {
    @AppStorage("ngrokURL") var ngrokURL: String = ""
    @Published var signals: [String: Signal] = [:]
    @Published var isLoading = false
    
    let favorites: [String] = [
        "AAPL", "MSFT", "GOOG", "NVDA", "AMZN", "META", "TSLA", "AMD", "CRM", "NFLX",
        "PLTR", "SMCI", "AVGO", "INTC", "MU", "ARM", "QCOM", "ASML", "AI", "SOUN",
        "RIVN", "LCID", "ARKK", "ARKW", "ROKU", "SHOP", "COIN", "SPOT", "UPST", "U",
        "JPM", "BAC", "GS", "V", "MA", "PYPL", "AXP", "DFS", "SOFI",
        "UNH", "PFE", "MRNA", "CVS", "LLY", "HIMS", "VRTX", "ISRG", "REGN", "BMY"
    ]
    
    func fetchSignal(for ticker: String) {

//        guard let url = URL(string: "http://localhost:5001/signal/\(ticker)") else {
//            print("❌ Invalid URL for ticker: \(ticker)")
//            return
//        }
        guard let url = URL(string: "\(ngrokURL)/signal/\(ticker)") else {
            print("❌ Invalid URL for ticker: \(ticker)")
            return
        }
        isLoading = true

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let result = try? JSONDecoder().decode(Signal.self, from: data) else {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }

            DispatchQueue.main.async {
                self.signals[ticker] = result
                self.isLoading = false
                print("✅ Signal loaded:", result)
            }
        }.resume()
    }

    func homePageLoad() {
        for ticker in favorites {
            fetchSignal(for: ticker)
        }
    }
}
