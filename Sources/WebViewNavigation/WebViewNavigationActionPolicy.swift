import WebKit

/// A wrapper object of `WKNavigationActionPolicy` that has `WKWebpagePreferences` if needed.
public struct WebViewNavigationActionPolicy {
    var policy: WKNavigationActionPolicy
    var preferences: WKWebpagePreferences?

    /// A policy to cancel without preferences.
    public static let cancel = WebViewNavigationActionPolicy(policy: .cancel, preferences: nil)

    /// A policy to allow without preferences.
    public static let allow = WebViewNavigationActionPolicy(policy: .allow, preferences: nil)

    /// A policy to download without preferences.
    public static let download = WebViewNavigationActionPolicy(policy: .download, preferences: nil)

    /// A policy to cancel with a specified preferences.
    public static func cancel(with preferences: WKWebpagePreferences) -> WebViewNavigationActionPolicy {
        .init(policy: .cancel, preferences: preferences)
    }

    /// A policy to allow with a specified preferences.
    public static func allow(with preferences: WKWebpagePreferences) -> WebViewNavigationActionPolicy {
        .init(policy: .allow, preferences: preferences)
    }

    /// A policy to download with a specified preferences.
    public static func download(with preferences: WKWebpagePreferences) -> WebViewNavigationActionPolicy {
        .init(policy: .download, preferences: preferences)
    }
}
