import WebKit

struct WebViewNavigationModifiers: Modifiable {
    var decidingPolicyForNavigationAction: (
        @Sendable (
            _ navigationAction: WKNavigationAction,
            _ preferences: WKWebpagePreferences
        ) async -> WebViewNavigationActionPolicy
    )?

    var decidingPolicyForNavigationResponse: (
        @Sendable (
            _ navigationResponse: WKNavigationResponse
        ) async -> WKNavigationResponsePolicy
    )?

    var didStartProvisionalNavigation: (@Sendable (_ navigation: WKNavigation) -> Void)?
    var didReceiveServerRedirectForProvisionalNavigation: (@Sendable (_ navigation: WKNavigation) -> Void)?
    var didFailProvisionalNavigation: (@Sendable (_ navigation: WKNavigation, _ error: any Error) -> Void)?
    var didCommit: (@Sendable (_ navigation: WKNavigation) -> Void)?
    var didFinish: (@Sendable (_ navigation: WKNavigation) -> Void)?
    var didFail: (@Sendable (_ navigation: WKNavigation, _ error: any Error) -> Void)?

    var respondingToAuthenticationChallenge: (@Sendable (
        _ challenge: URLAuthenticationChallenge
    ) async -> URLAuthenticationChallengeDisposition)?

    var onTerminateWebContentProcess: (@Sendable () -> Void)?
    // var decidingPolicyForDeprecatedTLS: (@Sendable (_ challenge: URLAuthenticationChallenge) async -> Bool)?

    var onBecomeDownloadForNavigationAction: (
        @Sendable (
            _ navigationAction: WKNavigationAction,
            _ download: WKDownload
        ) -> Void
    )?

    var onBecomeDownloadForNavigationResponse: (
        @Sendable (
            _ navigationResponse: WKNavigationResponse,
            _ download: WKDownload
        ) -> Void
    )?
}
