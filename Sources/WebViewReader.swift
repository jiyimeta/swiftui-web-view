import SwiftUI
import WebKit

public struct WebViewReader<Content: View>: View {
    @StateObject private var proxy: WebViewProxy
    private var content: (_ proxy: WebViewProxy) -> Content

    public init(
        initialURLRequest: URLRequest,
        configuration: WKWebViewConfiguration? = nil,
        @ViewBuilder content: @escaping (_ proxy: WebViewProxy) -> Content
    ) {
        let wkWebView = if let configuration {
            WKWebView(frame: .zero, configuration: configuration)
        } else {
            WKWebView(frame: .zero)
        }
        wkWebView.translatesAutoresizingMaskIntoConstraints = false
        wkWebView.load(initialURLRequest)
        let proxy = WebViewProxy(wkWebView: wkWebView)
        _proxy = StateObject(wrappedValue: proxy)

        self.content = content
    }

    public var body: some View {
        content(proxy)
    }
}
