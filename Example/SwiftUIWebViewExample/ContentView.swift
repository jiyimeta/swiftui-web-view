import SwiftUI
import SwiftUIWebView

struct ContentView: View {
    // swiftlint:disable:next force_unwrapping
    let url = URL(string: "https://www.apple.com/")!

    var body: some View {
        WebViewReader(initialURLRequest: URLRequest(url: url)) { proxy in
            ZStack {
                VStack(spacing: 0) {
                    WebView(proxy)
                        .ignoresSafeArea(.container, edges: .bottom)
                    ScrollViewProxy
                }

                VStack {
                    Spacer()

                    VStack(spacing: 0) {
                        HStack {
                            Image.textFormatSize
                            Spacer()
                            if #available(iOS 16.0, *) {
                                if let host = proxy.currentURL?.host() {
                                    Text(host)
                                        .foregroundStyle(.black)
                                } else {
                                    Text("Search on enter website name")
                                        .foregroundStyle(.gray)
                                }
                            }
                            Spacer()
                            if proxy.isLoading {
                                IconButton(.xmark, action: {})
                                    .foregroundStyle(.gray)
                            } else {
                                IconButton(.arrowClockwise, action: proxy.reload)
                                    .foregroundStyle(.black)
                            }
                        }
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: .gray.opacity(0.4), radius: 8)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)

                        HStack {
                            IconButton(.chevronLeft, action: proxy.goBack)
                                .disabled(!proxy.canGoBack)
                            Spacer()
                            IconButton(.chevronRight, action: proxy.goForward)
                                .disabled(!proxy.canGoForward)
                            Spacer()
                            IconButton(.squareAndArrowUp, action: {})
                                .foregroundStyle(.gray)
                            Spacer()
                            IconButton(.book, action: {})
                                .foregroundStyle(.gray)
                            Spacer()
                            IconButton(.squareOnSquare, action: {})
                                .foregroundStyle(.gray)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                    .background(.regularMaterial)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
