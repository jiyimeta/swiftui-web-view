import WebKit

extension WebView {
    /// Adds a modifier for this web view to create a new web view.
    ///
    /// The web view returned must be created with the specified configuration.
    /// WebKit will load the request in the returned web view.
    ///
    /// If you do not add the modifier, the web view will cancel the navigation.
    ///
    /// - Parameters:
    ///   - block: A closure to run when a navigation is detected.
    ///     It returns a new web view or nil.
    ///   - configuration: The configuration to use when creating the new web view.
    ///     This configuration is a copy of `webView.configuration`.
    ///   - navigationAction: The navigation action causing the new web view to be created.
    ///   - windowFeatures: Window features requested by the webpage.
    public func creatingWebView(
        _ block: @escaping @MainActor @Sendable (
            _ configuration: WKWebViewConfiguration,
            _ navigationAction: WKNavigationAction,
            _ windowFeatures: WKWindowFeatures
        ) -> WKWebView?
    ) -> WebView {
        registering(\.creatingWebView, block)
    }

    /// Adds a modifier for this web view to notify your app that the DOM window object's close() method completed
    /// successfully.
    ///
    /// Your app should remove the web view from the view hierarchy and update the UI as needed, such as by closing
    /// the containing browser tab or window.
    ///
    /// - Parameters:
    ///   - block: A closure to run when the web view is closed.
    public func didClose(_ block: @escaping @MainActor @Sendable () -> Void) -> WebView {
        registering(\.didClose, block)
    }

    /// Adds a modifier for this web view to display a JavaScript alert panel.
    ///
    /// For user security, your app should call attention to the fact that a specific website controls the content
    /// in this panel.
    /// A simple formula for identifying the controlling website is `frame.request.URL.host`.
    /// The panel should have a single OK button.
    ///
    /// If you do not add the modifier, the web view will behave as if the user selected the OK button.
    ///
    /// - Parameters:
    ///   - block: A closure to run after the alert panel has been dismissed.
    ///   - message: The message to display.
    ///   - frame: Information about the frame whose JavaScript initiated this call.
    public func runningJavaScriptAlertPanelWithMessage(
        _ block: @escaping @MainActor @Sendable (
            _ message: String,
            _ frame: WKFrameInfo
        ) async -> Void
    ) -> WebView {
        registering(\.runningJavaScriptAlertPanelWithMessage, block)
    }

    /// Adds a modifier for this web view to display a JavaScript confirm panel.
    /// For user security, your app should call attention to the fact that a specific website controls the content in
    /// this panel. A simple formula for identifying the controlling website is `frame.request.URL.host`.
    /// The panel should have two buttons, such as OK and Cancel.
    ///
    /// If you do not add the modifier, the web view will behave as if the user selected the Cancel button.
    ///
    /// - Parameters:
    ///   - block: A closure to run after the confirm panel has been dismissed.
    ///     It returns true if the user chose OK, false if the user chose Cancel.
    ///   - message: The message to display.
    ///   - frame: Information about the frame whose JavaScript initiated this call.
    public func runningJavaScriptConfirmPanelWithMessage(
        _ block: @escaping @MainActor @Sendable (
            _ message: String,
            _ frame: WKFrameInfo
        ) async -> Bool
    ) -> WebView {
        registering(\.runningJavaScriptConfirmPanelWithMessage, block)
    }

    /// Adds a modifier for this web view to display a JavaScript text input panel.
    ///
    /// For user security, your app should call attention to the fact that a specific website controls the content
    /// in this panel.
    /// A simple formula for identifying the controlling website is `frame.request.URL.host`.
    /// The panel should have two buttons, such as OK and Cancel, and a field in which to enter text.
    ///
    /// If you do not add the modifier, the web view will behave as if the user selected the Cancel button.
    ///
    /// - Parameters:
    ///   - block: A closure to run after the input panel has been dismissed.
    ///     It returns the entered text if the user chose OK, otherwise nil
    ///   - prompt: The prompt to display.
    ///   - default: Text The initial text to display in the text entry field.
    ///   - frame: Information about the frame whose JavaScript initiated this call.
    public func runningJavaScriptTextInputPanelWithPrompt(
        _ block: @escaping @MainActor @Sendable (
            _ prompt: String,
            _ defaultText: String?,
            _ frame: WKFrameInfo
        ) async -> String?
    ) -> WebView {
        registering(\.runningJavaScriptTextInputPanelWithPrompt, block)
    }

    /// Adds a modifier for this web view to request permission for microphone audio and camera video access.
    ///
    /// If you do not add the modifier, the result is the same as calling the decisionHandler
    /// with `WKPermissionDecisionPrompt`.
    ///
    /// - Parameters:
    ///   - block: A closure to run when the media capture permissions are requested.
    ///     It returns the decision whether to allow or not.
    ///   - origin: The origin of the page.
    ///   - frame: Information about the frame whose JavaScript initiated this call.
    ///   - type: The type of capture (camera, microphone).
    public func decidingMediaCapturePermissions(
        _ block: @escaping @MainActor @Sendable (
            _ origin: WKSecurityOrigin,
            _ frame: WKFrameInfo,
            _ type: WKMediaCaptureType
        ) async -> WKPermissionDecision
    ) -> WebView {
        registering(\.decidingMediaCapturePermissions, block)
    }

    /// Adds a modifier for this web view to allow your app to determine whether or not the given security origin
    /// should have access to the device's orientation and motion.
    /// - Parameters:
    ///   - block: A closure to run when the orientation and motion permission is requested.
    ///     It returns the decision whether to allow or not.
    ///   - securityOrigin: The security origin which requested access to the device's orientation and motion.
    ///   - frame: The frame that initiated the request.
    public func decidingDeviceOrientationAndMotionPermission(
        _ block: @escaping @MainActor @Sendable (
            _ origin: WKSecurityOrigin,
            _ frame: WKFrameInfo
        ) async -> WKPermissionDecision
    ) -> WebView {
        registering(\.decidingDeviceOrientationAndMotionPermission, block)
    }

    /// Adds a modifier for this web view that fires an action when a context menu interaction begins.
    /// - Parameters:
    ///   - block: A closure to run when the context menu configuration is requested.
    ///     It returns a valid `UIContextMenuConfiguration` to show a context menu, or nil to not show a context menu.
    ///   - elementInfo: The elementInfo for the element the user is touching.
    public func configuringContextMenu(
        _ block: @escaping @MainActor @Sendable (
            _ elementInfo: WKContextMenuElementInfo
        ) async -> UIContextMenuConfiguration?
    ) -> WebView {
        registering(\.configuringContextMenu, block)
    }

    /// Adds a modifier for this web view that fires an action when the context menu will be presented.
    /// - Parameters:
    ///   - block: A closure to run before the context menu is presented.
    ///   - elementInfo: The elementInfo for the element the user is touching.
    public func willPresentContextMenu(
        _ block: @escaping @MainActor @Sendable (
            _ elementInfo: WKContextMenuElementInfo
        ) -> Void
    ) -> WebView {
        registering(\.willPresentContextMenu, block)
    }

    /// Adds a modifier for this web view that fires an action when the context menu configured by the
    /// `UIContextMenuConfiguration` from `configuringContextMenu` is committed.
    /// That is, when the user has selected the view provided in the `UIContextMenuContentPreviewProvider`.
    /// - Parameters:
    ///   - block: A closure to run before the context menu is committed.
    ///   - elementInfo: The elementInfo for the element the user is touching.
    ///   - animator: The animator to use for the commit animation.
    public func willCommitContextMenuWithAnimator(
        _ block: @escaping @MainActor @Sendable (
            _ elementInfo: WKContextMenuElementInfo,
            _ animator: any UIContextMenuInteractionCommitAnimating
        ) -> Void
    ) -> WebView {
        registering(\.willCommitContextMenuWithAnimator, block)
    }

    /// Adds a modifier for this web view that fires an action when the context menu ends, either by being dismissed
    /// or when a menu action is taken.
    /// - Parameters:
    ///   - block: A closure to run when the context menu has been ended.
    ///   - elementInfo: The elementInfo for the element the user is touching.
    public func didEndContextMenu(
        _ block: @escaping @MainActor @Sendable (
            _ elementInfo: WKContextMenuElementInfo
        ) -> Void
    ) -> WebView {
        registering(\.didEndContextMenu, block)
    }

    // /// Adds a modifier for this web view to display a Lockdown Mode warning panel.
    // ///
    // /// The panel should have a single OK button.
    // ///
    // /// If you do not add the modifier, the web view will display the default Lockdown Mode message.
    // ///
    // /// - Parameters:
    // ///   - block: A closure to run to resume after the first use message is displayed.
    // ///     It returns the result of the displayed dialog.
    // ///   - message: The message WebKit would display if this delegate were not invoked.
    // public func showingLockdownModeFirstUseMessage(
    //     _ block: @escaping @@MainActor Sendable (
    //         _ message: String
    //     ) async -> WKDialogResult
    // ) -> WebView {
    //     registering(\.showingLockdownModeFirstUseMessage, block)
    // }

    /// Adds a modifier for this web view that fires an action when the web view is about to present its edit menu.
    /// - Parameters:
    ///   - block: A closure to run before edit menu is presented.
    ///   - animator: Appearance animator. Add animations to this object to run them alongside the appearance
    ///     transition.
    @available(iOS 16.4, *)
    public func willPresentEditMenuWithAnimator(
        _ block: @escaping @MainActor @Sendable (
            _ animator: any UIEditMenuInteractionAnimating
        ) -> Void
    ) -> WebView {
        registering(\.willPresentEditMenuWithAnimator, block)
    }

    /// Adds a modifier for this web view that fires an action when the web view is about to dismiss its edit menu.
    /// - Parameters:
    ///   - block: A closure to run before the edit menu is dismissed.
    ///   - animator: Dismissal animator. Add animations to this object to run them alongside the dismissal transition.
    @available(iOS 16.4, *)
    public func willDismissEditMenuWithAnimator(
        _ block: @escaping @MainActor @Sendable (
            _ animator: any UIEditMenuInteractionAnimating
        ) -> Void
    ) -> WebView {
        registering(\.willDismissEditMenuWithAnimator, block)
    }
}

// MARK: - Private methods

extension WebView {
    func registering<T>(_ keyPath: WritableKeyPath<WebViewUIActionModifiers, T>, _ modifier: T) -> WebView {
        modifying(\.uiActionModifiers) { $0.modifying(keyPath, modifier) }
    }
}
