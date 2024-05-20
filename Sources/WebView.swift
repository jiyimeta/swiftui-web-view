import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
    private var proxy: WebViewProxy

    var navigationModifiers = WebViewNavigationModifiers()

    public init(_ proxy: WebViewProxy) {
        self.proxy = proxy
    }

    public func makeUIView(context: Context) -> some UIView {
        proxy.wkWebView.navigationDelegate = context.coordinator
        return proxy.wkWebView
    }

    public func updateUIView(_ uiView: UIViewType, context: Context) {}

    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    public class Coordinator: NSObject {
        let parent: WebView

        init(parent: WebView) {
            self.parent = parent
        }
    }
}

// MARK: - Protocol conformances

extension WebView: Modifiable {}
