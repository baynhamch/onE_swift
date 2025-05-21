import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SignalViewModel()
    @State private var showingURLSheet = false
    @AppStorage("ngrokURL") private var ngrokURL: String = ""

    var body: some View {
        NavigationView {
            List {
                //  Top section with highlights
                Section {
                    HighlightsView(viewModel: viewModel)
                        .listRowInsets(EdgeInsets()) // Optional: edge-to-edge layout
                        .padding(.bottom, 8)
                }

                // Stock signals
                ForEach(viewModel.favorites, id: \.self) { ticker in
                    if let signal = viewModel.signals[ticker] {
                        TickerCard(signal: signal)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .refreshable {
                viewModel.homePageLoad()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Signals")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showingURLSheet = true
                    }) {
                        Image(systemName: "gear")
                    }
                }
            }
        }
        .sheet(isPresented: $showingURLSheet) {
            NavigationView {
                Form {
                    Section(header: Text("ngrok URL")) {
                        TextField("https://example.ngrok-free.app", text: $ngrokURL)
                            .keyboardType(.URL)
                            .autocapitalization(.none)
                    }
                }
                .navigationTitle("Server Settings")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            showingURLSheet = false
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.homePageLoad()
        }
    }
}
#Preview {
    ContentView()
}
