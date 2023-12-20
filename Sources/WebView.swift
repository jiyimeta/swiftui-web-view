import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
    private let proxy: WebViewProxy

    public init(_ proxy: WebViewProxy) {
        self.proxy = proxy
    }

    public func makeUIView(context: Context) -> some UIView {
        proxy.wkWebView
    }

    public func updateUIView(_ uiView: UIViewType, context: Context) {}
}
