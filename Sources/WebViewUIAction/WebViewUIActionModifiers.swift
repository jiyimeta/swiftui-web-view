import WebKit

struct WebViewUIActionModifiers: Modifiable {
    var creatingWebView: (
        @MainActor @Sendable (
            _ configuration: WKWebViewConfiguration,
            _ navigationAction: WKNavigationAction,
            _ windowFeatures: WKWindowFeatures
        ) -> WKWebView?
    )?

    var didClose: (@MainActor @Sendable () -> Void)?
    var runningJavaScriptAlertPanelWithMessage: (
        @MainActor @Sendable (_ message: String, _ frame: WKFrameInfo) async -> Void
    )?
    var runningJavaScriptConfirmPanelWithMessage: (
        @MainActor @Sendable (_ message: String, _ frame: WKFrameInfo) async -> Bool
    )?

    var runningJavaScriptTextInputPanelWithPrompt: (
        @MainActor @Sendable (
            _ prompt: String,
            _ defaultText: String?,
            _ frame: WKFrameInfo
        ) async -> String?
    )?

    var decidingMediaCapturePermissions: (
        @MainActor @Sendable (
            _ origin: WKSecurityOrigin,
            _ frame: WKFrameInfo,
            _ type: WKMediaCaptureType
        ) async -> WKPermissionDecision
    )?

    var decidingDeviceOrientationAndMotionPermission: (
        @MainActor @Sendable (
            _ origin: WKSecurityOrigin,
            _ frame: WKFrameInfo
        ) async -> WKPermissionDecision
    )?

    var configuringContextMenu: (
        @MainActor @Sendable (
            _ elementInfo: WKContextMenuElementInfo
        ) async -> UIContextMenuConfiguration?
    )?

    var willPresentContextMenu: (@MainActor @Sendable (_ elementInfo: WKContextMenuElementInfo) -> Void)?

    var willCommitContextMenuWithAnimator: (
        @MainActor @Sendable (
            _ elementInfo: WKContextMenuElementInfo,
            _ animator: any UIContextMenuInteractionCommitAnimating
        ) -> Void
    )?

    var didEndContextMenu: (@MainActor @Sendable (_ elementInfo: WKContextMenuElementInfo) -> Void)?
    // var showingLockdownModeFirstUseMessage: (@MainActor @Sendable (_ message: String) async -> WKDialogResult)?
    var willPresentEditMenuWithAnimator: (
        @MainActor @Sendable (_ animator: any UIEditMenuInteractionAnimating) -> Void
    )?
    var willDismissEditMenuWithAnimator: (
        @MainActor @Sendable (_ animator: any UIEditMenuInteractionAnimating) -> Void
    )?
}
