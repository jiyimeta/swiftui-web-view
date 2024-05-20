import WebKit

struct WebViewNavigationModifiers: Modifiable {
    var decidingPolicyForNavigationAction: (
        @MainActor @Sendable (
            _ navigationAction: WKNavigationAction,
            _ preferences: WKWebpagePreferences
        ) async -> WebViewNavigationActionPolicy
    )?

    var decidingPolicyForNavigationResponse: (
        @MainActor @Sendable (
            _ navigationResponse: WKNavigationResponse
        ) async -> WKNavigationResponsePolicy
    )?

    var didStartProvisionalNavigation: (@MainActor @Sendable (_ navigation: WKNavigation) -> Void)?
    var didReceiveServerRedirectForProvisionalNavigation: (@MainActor @Sendable (_ navigation: WKNavigation) -> Void)?
    var didFailProvisionalNavigation: (@MainActor @Sendable (_ navigation: WKNavigation, _ error: any Error) -> Void)?
    var didCommit: (@MainActor @Sendable (_ navigation: WKNavigation) -> Void)?
    var didFinish: (@MainActor @Sendable (_ navigation: WKNavigation) -> Void)?
    var didFail: (@MainActor @Sendable (_ navigation: WKNavigation, _ error: any Error) -> Void)?

    var respondingToAuthenticationChallenge: (
        @MainActor @Sendable (
            _ challenge: URLAuthenticationChallenge
        ) async -> URLAuthenticationChallengeDisposition
    )?

    var onTerminateWebContentProcess: (@MainActor @Sendable () -> Void)?

    // var decidingPolicyForDeprecatedTLS: (
    //     @MainActor @Sendable (
    //         _ challenge: URLAuthenticationChallenge
    //     ) async -> Bool
    // )?

    var onBecomeDownloadForNavigationAction: (
        @MainActor @Sendable (
            _ navigationAction: WKNavigationAction,
            _ download: WKDownload
        ) -> Void
    )?

    var onBecomeDownloadForNavigationResponse: (
        @MainActor @Sendable (
            _ navigationResponse: WKNavigationResponse,
            _ download: WKDownload
        ) -> Void
    )?
}
