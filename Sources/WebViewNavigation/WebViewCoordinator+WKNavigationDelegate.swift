import WebKit

// swiftlint:disable implicitly_unwrapped_optional
extension WebView.Coordinator: WKNavigationDelegate {
    public func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        preferences: WKWebpagePreferences
    ) async -> (WKNavigationActionPolicy, WKWebpagePreferences) {
        let policy = await parent.navigationModifiers.decidingPolicyForNavigationAction?(
            navigationAction,
            preferences
        ) ?? .allow

        return (
            policy.policy,
            policy.preferences ?? preferences
        )
    }

    public func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse: WKNavigationResponse
    ) async -> WKNavigationResponsePolicy {
        await parent.navigationModifiers.decidingPolicyForNavigationResponse?(navigationResponse) ?? .allow
    }

    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        parent.navigationModifiers.onStartProvisionalNavigation?(navigation)
    }

    public func webView(
        _ webView: WKWebView,
        didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!
    ) {
        parent.navigationModifiers.onReceiveServerRedirectForProvisionalNavigation?(navigation)
    }

    public func webView(
        _ webView: WKWebView,
        didFailProvisionalNavigation navigation: WKNavigation!,
        withError error: any Error
    ) {
        parent.navigationModifiers.onFailProvisionalNavigation?(navigation, error)
    }

    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        parent.navigationModifiers.onCommit?(navigation)
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        parent.navigationModifiers.onFinish?(navigation)
    }

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        parent.navigationModifiers.onFail?(navigation, error)
    }

    public func webView(
        _ webView: WKWebView,
        respondTo challenge: URLAuthenticationChallenge
    ) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        await parent.navigationModifiers.respondingToAuthenticationChallenge?(challenge).tuple
            ?? (.performDefaultHandling, nil)
    }

    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        parent.navigationModifiers.onTerminateWebContentProcess?()
    }

    // public func webView(
    //     _ webView: WKWebView,
    //     shouldAllowDeprecatedTLSFor challenge: URLAuthenticationChallenge
    // ) async -> Bool {
    //     await parent.navigationModifiers.decidingPolicyForDeprecatedTLS?(challenge) ?? false
    // }

    public func webView(
        _ webView: WKWebView,
        navigationAction: WKNavigationAction,
        didBecome download: WKDownload
    ) {
        parent.navigationModifiers.onBecomeDownloadForNavigationAction?(navigationAction, download)
    }

    public func webView(
        _ webView: WKWebView,
        navigationResponse: WKNavigationResponse,
        didBecome download: WKDownload
    ) {
        parent.navigationModifiers.onBecomeDownloadForNavigationResponse?(navigationResponse, download)
    }
}

// swiftlint:enable implicitly_unwrapped_optional
