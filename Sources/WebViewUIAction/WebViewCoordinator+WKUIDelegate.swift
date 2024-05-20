import WebKit

extension WebView.Coordinator: WKUIDelegate {
    public func webView(
        _ webView: WKWebView,
        createWebViewWith configuration: WKWebViewConfiguration,
        for navigationAction: WKNavigationAction,
        windowFeatures: WKWindowFeatures
    ) -> WKWebView? {
        parent.uiActionModifiers.creatingWebView?(configuration, navigationAction, windowFeatures)
    }

    public func didClose(_ webView: WKWebView) {
        parent.uiActionModifiers.didClose?()
    }

    public func webView(
        _ webView: WKWebView,
        runJavaScriptAlertPanelWithMessage message: String,
        initiatedByFrame frame: WKFrameInfo
    ) async {
        await parent.uiActionModifiers.runningJavaScriptAlertPanelWithMessage?(message, frame)
    }

    public func webView(
        _ webView: WKWebView,
        runJavaScriptConfirmPanelWithMessage message: String,
        initiatedByFrame frame: WKFrameInfo
    ) async -> Bool {
        await parent.uiActionModifiers.runningJavaScriptConfirmPanelWithMessage?(message, frame) ?? false
    }

    public func webView(
        _ webView: WKWebView,
        runJavaScriptTextInputPanelWithPrompt prompt: String,
        defaultText: String?,
        initiatedByFrame frame: WKFrameInfo
    ) async -> String? {
        await parent.uiActionModifiers.runningJavaScriptTextInputPanelWithPrompt?(prompt, defaultText, frame)
    }

    public func webView(
        _ webView: WKWebView,
        decideMediaCapturePermissionsFor origin: WKSecurityOrigin,
        initiatedBy frame: WKFrameInfo,
        type: WKMediaCaptureType
    ) async -> WKPermissionDecision {
        await parent.uiActionModifiers.decidingMediaCapturePermissions?(origin, frame, type) ?? .prompt
    }

    public func webView(
        _ webView: WKWebView,
        requestDeviceOrientationAndMotionPermissionFor origin: WKSecurityOrigin,
        initiatedByFrame frame: WKFrameInfo,
        decisionHandler: @escaping (WKPermissionDecision) -> Void
    ) {
        Task { @MainActor in
            let decision = await parent.uiActionModifiers.decidingDeviceOrientationAndMotionPermission?(origin, frame)
                ?? .prompt
            decisionHandler(decision)
        }
    }

    public func webView(
        _ webView: WKWebView,
        contextMenuConfigurationFor elementInfo: WKContextMenuElementInfo
    ) async -> UIContextMenuConfiguration? {
        await parent.uiActionModifiers.configuringContextMenu?(elementInfo)
    }

    public func webView(
        _ webView: WKWebView,
        contextMenuWillPresentForElement elementInfo: WKContextMenuElementInfo
    ) {
        parent.uiActionModifiers.willPresentContextMenu?(elementInfo)
    }

    public func webView(
        _ webView: WKWebView,
        contextMenuForElement elementInfo: WKContextMenuElementInfo,
        willCommitWithAnimator animator: any UIContextMenuInteractionCommitAnimating
    ) {
        parent.uiActionModifiers.willCommitContextMenuWithAnimator?(elementInfo, animator)
    }

    public func webView(
        _ webView: WKWebView,
        contextMenuDidEndForElement elementInfo: WKContextMenuElementInfo
    ) {
        parent.uiActionModifiers.didEndContextMenu?(elementInfo)
    }

    // public func webView(
    //     _ webView: WKWebView,
    //     showLockdownModeFirstUseMessage message: String
    // ) async -> WKDialogResult {
    //     parent.uiActionModifiers.showingLockdownModeFirstUseMessage?(message)
    // }

    @available(iOS 16.4, *)
    public func webView(
        _ webView: WKWebView,
        willPresentEditMenuWithAnimator animator: any UIEditMenuInteractionAnimating
    ) {
        parent.uiActionModifiers.willPresentEditMenuWithAnimator?(animator)
    }

    @available(iOS 16.4, *)
    public func webView(
        _ webView: WKWebView,
        willDismissEditMenuWithAnimator animator: any UIEditMenuInteractionAnimating
    ) {
        parent.uiActionModifiers.willDismissEditMenuWithAnimator?(animator)
    }
}
