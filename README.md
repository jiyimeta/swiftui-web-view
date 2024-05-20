# swiftui-web-view

This library is a wrapper of WKWebView provided by [WebKit](https://github.com/WebKit/WebKit) to easily use web view even in SwiftUI.

## Usage

You can display a web view by positioning `WebView` in the view builder of `WebViewReader`.
In addition, you can manipulate the web view (e.g. reload) by calling the methods of `proxy`, which is provided by `WebViewReader`

```swift
import SwiftUI
import SwiftUIWebView

struct ContentView: View {
    let url = URL(string: "https://www.apple.com/")!

    var body: some View {
        WebViewReader(initialURLRequest: URLRequest(url: url)) { proxy in
            VStack {
                WebView(proxy)
                    .didFinishNavigation { navigation in
                        print("didFinishNavigation", navigation)
                    }

                Button("Reload") {
                    proxy.reload()
                }
            }
        }
    }
}
```

See also [example code](/Example/SwiftUIWebViewExample/ContentView.swift) for details.

## Quick start

Make sure that xcodegen has been installed, and run the following commands.

```console
$ cd Example
$ xcodegen
$ open SwiftUIWebViewExample.xcodeproj
```

You can run the example app by Xcode.

## License

This library is released under the MIT license. See [LICENSE](LICENSE) for details.
