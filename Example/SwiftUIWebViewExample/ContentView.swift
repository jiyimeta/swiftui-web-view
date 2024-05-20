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
                        .decidingPolicyForNavigationAction { navigationAction, preferences in
                            print("decidingPolicyForNavigationAction", navigationAction, preferences)
                            return .allow
                        }
                        .decidingPolicyForNavigationResponse { navigationResponse in
                            print("decidingPolicyForNavigationResponse", navigationResponse)
                            return .allow
                        }
                        .didStartProvisionalNavigation { navigation in
                            print("didStartProvisionalNavigation", navigation)
                        }
                        .didReceiveServerRedirectForProvisionalNavigation { navigation in
                            print("didReceiveServerRedirectForProvisionalNavigation", navigation)
                        }
                        .didFailProvisionalNavigation { navigation, error in
                            print("didFailProvisionalNavigation", navigation, error)
                        }
                        .didCommitNavigation { navigation in
                            print("didCommitNavigation", navigation)
                        }
                        .didFinishNavigation { navigation in
                            print("didFinishNavigation", navigation)
                        }
                        .didFailNavigation { navigation, error in
                            print("didFailNavigation", navigation, error)
                        }
                        .respondingToAuthenticationChallenge { challenge in
                            print("respondingToAuthenticationChallenge", challenge)
                            return .performDefaultHandling
                        }
                        .didTerminateWebContentProcess {
                            print("didTerminateWebContentProcess")
                        }
                        .didBecomeDownloadForNavigationAction { navigationAction, download in
                            print("didBecomeDownloadForNavigationAction", navigationAction, download)
                        }
                        .didBecomeDownloadForNavigationResponse { navigationResponse, download in
                            print("didBecomeDownloadForNavigationResponse", navigationResponse, download)
                        }
                        .ignoresSafeArea(.container, edges: .bottom)
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
