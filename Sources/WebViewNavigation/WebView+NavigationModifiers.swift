import WebKit

extension WebView {
    /// Adds a modifier for this web view that decides whether to allow or cancel a navigation.
    ///
    /// If you do not add this modifier, the web view will load the request or, if appropriate, forward it to another
    /// application.
    /// The preferences argument may be changed by setting `defaultWebpagePreferences` on `WKWebViewConfiguration`.
    ///
    /// - Parameters:
    ///   - block: A closure to run when a navigation is detected.
    ///     It returns the policy to allow or cancel the navigation.
    ///   - navigationAction: Descriptive information about the action triggering the navigation request.
    ///   - preferences: The default set of webpage preferences.
    public func decidingPolicyForNavigationAction(
        _ block: @escaping @MainActor @Sendable (
            _ navigationAction: WKNavigationAction,
            _ preferences: WKWebpagePreferences
        ) async -> WebViewNavigationActionPolicy
    ) -> WebView {
        registering(\.decidingPolicyForNavigationAction, block)
    }

    /// Adds a modifier for this web view that decides whether to allow or cancel a navigation after its response is
    /// known.
    ///
    /// If you do not add this modifier, the web view will allow the response, if the web view can show it.
    ///
    /// - Parameters:
    ///   - block: A closure to run when a navigation is detected.
    ///     It returns the policy to allow or cancel the navigation.
    ///   - navigationResponse: Descriptive information about the navigation response.
    public func decidingPolicyForNavigationResponse(
        _ block: @escaping @MainActor @Sendable (
            _ navigationResponse: WKNavigationResponse
        ) async -> WKNavigationResponsePolicy
    ) -> WebView {
        registering(\.decidingPolicyForNavigationResponse, block)
    }

    /// Adds a modifier for this web view that fires an action when a main frame navigation starts.
    /// - Parameters:
    ///   - block: A closure to run when a navigation is detected.
    ///   - navigation: The navigation.
    public func didStartProvisionalNavigation(
        _ block: @escaping @MainActor @Sendable (_ navigation: WKNavigation) -> Void
    ) -> WebView {
        registering(\.didStartProvisionalNavigation, block)
    }

    /// Adds a modifier for this web view that fires an action when a server redirect is received for the main frame.
    /// - Parameters:
    ///   - webView: The web view invoking the delegate method.
    ///   - navigation: The navigation.
    public func didReceiveServerRedirectForProvisionalNavigation(
        _ block: @escaping @MainActor @Sendable (_ navigation: WKNavigation) -> Void
    ) -> WebView {
        registering(\.didReceiveServerRedirectForProvisionalNavigation, block)
    }

    /// Adds a modifier for this web view that fires an action when an error occurs while starting to load data for
    /// the main frame.
    /// - Parameters:
    ///   - block: A closure to run when a navigation is detected.
    ///   - navigation: The navigation.
    ///   - error: The error that occurred.
    public func didFailProvisionalNavigation(
        _ block: @escaping @MainActor @Sendable (_ navigation: WKNavigation, _ error: any Error) -> Void
    ) -> WebView {
        registering(\.didFailProvisionalNavigation, block)
    }

    /// Adds a modifier for this web view that fires an action when content starts arriving for the main frame.
    /// - Parameters:
    ///   - block: A closure to run when a navigation is detected.
    ///   - navigation: The navigation.
    public func didCommitNavigation(
        _ block: @escaping @MainActor @Sendable (_ navigation: WKNavigation) -> Void
    ) -> WebView {
        registering(\.didCommit, block)
    }

    /// Adds a modifier for this web view that fires an action when a main frame navigation completes.
    /// - Parameters:
    ///   - block: A closure to run when a navigation is detected.
    ///   - navigation: The navigation.
    public func didFinishNavigation(
        _ block: @escaping @MainActor @Sendable (_ navigation: WKNavigation) -> Void
    ) -> WebView {
        registering(\.didFinish, block)
    }

    /// Adds a modifier for this web view that fires an action when an error occurs during a committed main frame
    /// navigation.
    /// - Parameters:
    ///   - block: A closure to run when a navigation is detected.
    ///   - navigation: The navigation.
    ///   - error: The error that occurred.
    public func didFailNavigation(
        _ block: @escaping @MainActor @Sendable (_ navigation: WKNavigation, _ error: any Error) -> Void
    ) -> WebView {
        registering(\.didFail, block)
    }

    /// Adds a modifier for this web view that fires an action when the web view needs to respond to an authentication
    /// challenge.
    ///
    /// If you do not add this modifier, the web view will respond to the authentication challenge with the
    /// `URLSession.AuthChallengeDisposition.rejectProtectionSpace` disposition.
    ///
    /// - Parameters:
    ///   - block: A closure to run when a navigation is detected.
    ///     It returns the disposition with credentials if needed
    ///   - challenge: The authentication challenge.
    public func respondingToAuthenticationChallenge(
        _ block: @escaping @MainActor @Sendable (
            _ challenge: URLAuthenticationChallenge
        ) async -> URLAuthenticationChallengeDisposition
    ) -> WebView {
        registering(\.respondingToAuthenticationChallenge, block)
    }

    /// Adds a modifier for this web view that fires an action when the web view's web content process is terminated.
    /// - Parameters:
    ///   - block: A closure to run when a navigation is detected.
    public func didTerminateWebContentProcess(
        _ block: @escaping @MainActor @Sendable () -> Void
    ) -> WebView {
        registering(\.onTerminateWebContentProcess, block)
    }

    // /// Invoked when the web view is establishing a network connection using a deprecated version of TLS.
    // /// - Parameters:
    // ///   - block: A closure to run when a navigation is detected.
    // ///     It returns whether or not to continue with the connection establishment.
    // ///   - challenge: The authentication challenge.
    // public func decidingPolicyForDeprecatedTLS(
    //     _ block: @escaping @MainActor @Sendable (_ challenge: URLAuthenticationChallenge) async -> Bool
    // ) -> WebView {
    //     registering(\.decidingPolicyForDeprecatedTLS, block)
    // }

    /// Adds a modifier for this web view that fires an action after using WKNavigationActionPolicyDownload.
    ///
    /// The download needs its delegate to be set to receive updates about its progress.
    ///
    /// - Parameters:
    ///   - block: A closure to run when a navigation is detected.
    ///   - navigationAction: The action that is being turned into a download.
    ///   - download: The download.
    public func didBecomeDownloadForNavigationAction(
        _ block: @escaping @MainActor @Sendable (
            _ navigationAction: WKNavigationAction,
            _ download: WKDownload
        ) -> Void
    ) -> WebView {
        registering(\.onBecomeDownloadForNavigationAction, block)
    }

    /// Adds a modifier for this web view that fires an action after using WKNavigationResponsePolicyDownload.
    ///
    /// The download needs its delegate to be set to receive updates about its progress.
    ///
    /// - Parameters:
    ///   - block: A closure to run when a navigation is detected.
    ///   - navigationResponse: The response that is being turned into a download.
    ///   - download: The download.
    public func didBecomeDownloadForNavigationResponse(
        _ block: @escaping @MainActor @Sendable (
            _ navigationResponse: WKNavigationResponse,
            _ download: WKDownload
        ) -> Void
    ) -> WebView {
        registering(\.onBecomeDownloadForNavigationResponse, block)
    }
}

// MARK: - Private methods

extension WebView {
    func registering<T>(_ keyPath: WritableKeyPath<WebViewNavigationModifiers, T>, _ modifier: T) -> WebView {
        modifying(\.navigationModifiers) { $0.modifying(keyPath, modifier) }
    }
}
