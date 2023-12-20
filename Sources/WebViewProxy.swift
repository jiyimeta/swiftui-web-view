import WebKit

/// A proxy value that supports programmatic controlling of the web views within a view hierarchy.
///
/// You don't create instances of `WebViewProxy` directly.
/// Instead, your ``WebViewReader`` receives an instance of `WebViewProxy` in its `content` view builder.
/// You use actions within this view builder, such as button and gesture handlers or the ``View/onChange(of:perform:)``
/// method, to call the proxy's method.
public class WebViewProxy: NSObject, ObservableObject {
    let wkWebView: WKWebView
    private var observations: [NSKeyValueObservation] = []

    @Published public var currentURL: URL?
    @Published public var canGoBack = false
    @Published public var canGoForward = false
    @Published public var isLoading = true

    init(wkWebView: WKWebView) {
        self.wkWebView = wkWebView
        currentURL = wkWebView.url

        super.init()

        setupObservations()
    }
}

// MARK: - Public methods

extension WebViewProxy {
    /// Navigates to the back item in the back-forward list.
    public func goBack() {
        wkWebView.goBack()
    }

    /// Navigates to the forward item in the back-forward list.
    public func goForward() {
        wkWebView.goForward()
    }

    /// Reloads the current page.
    public func reload() {
        wkWebView.reload()
    }
}

// MARK: - Private methods

extension WebViewProxy {
    private func setupObservations() {
        observations = [
            wkWebView.observe(\.url, options: [.new]) { [weak self] _, change in
                self?.currentURL = change.newValue.flatMap { $0 }
            },
            wkWebView.observe(\.canGoBack, options: [.new]) { [weak self] _, change in
                self?.canGoBack = change.newValue ?? false
            },
            wkWebView.observe(\.canGoForward, options: [.new]) { [weak self] _, change in
                self?.canGoForward = change.newValue ?? false
            },
            wkWebView.observe(\.isLoading, options: [.new]) { [weak self] _, change in
                self?.isLoading = change.newValue ?? false
            },
        ]
    }
}
