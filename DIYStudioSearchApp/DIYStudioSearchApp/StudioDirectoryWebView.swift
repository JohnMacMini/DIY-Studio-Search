import SwiftUI
import UIKit
import WebKit

struct StudioDirectoryWebView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        loadDirectory(into: webView)
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
    }

    private func loadDirectory(into webView: WKWebView) {
        guard
            let htmlURL = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "AppContent")
        else {
            webView.loadHTMLString("""
            <html>
              <body style="font-family: -apple-system; padding: 24px;">
                <h2>Unable to load DIY Studio Search</h2>
                <p>The bundled directory files are missing from the app target.</p>
              </body>
            </html>
            """, baseURL: nil)
            return
        }

        let contentDirectory = htmlURL.deletingLastPathComponent()
        webView.loadFileURL(htmlURL, allowingReadAccessTo: contentDirectory)
    }

    final class Coordinator: NSObject, WKNavigationDelegate {
        func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationAction: WKNavigationAction,
            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
        ) {
            guard let url = navigationAction.request.url else {
                decisionHandler(.allow)
                return
            }

            if url.isFileURL {
                decisionHandler(.allow)
                return
            }

            if ["http", "https", "tel"].contains(url.scheme?.lowercased()) {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
                return
            }

            decisionHandler(.allow)
        }
    }
}
