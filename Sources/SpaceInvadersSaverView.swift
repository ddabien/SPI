import ScreenSaver
import WebKit

public class SpaceInvadersSaverView: ScreenSaverView {
    private var webView: WKWebView!

    public override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        animationTimeInterval = 1.0 / 30.0

        let config = WKWebViewConfiguration()
        config.preferences.javaScriptCanOpenWindowsAutomatically = false
        config.websiteDataStore = .nonPersistent()

        webView = WKWebView(frame: bounds, configuration: config)
        webView.autoresizingMask = [.width, .height]
        #if os(macOS)
        // Make background transparent (nice over black), avoids white flashes
        webView.setValue(false, forKey: "drawsBackground")
        #endif
        addSubview(webView)

        if let (url, base) = Self.indexURL() {
            _ = webView.loadFileURL(url, allowingReadAccessTo: base)
        } else {
            let html = """
            <html><body style='background:black;color:white;font:16px -apple-system;display:flex;align-items:center;justify-content:center;height:100%'>
            <div>Falta <code>Resources/web/index.html</code> en el bundle.</div>
            </body></html>
            """
            webView.loadHTMLString(html, baseURL: nil)
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public override func startAnimation() {
        super.startAnimation()
    }

    public override func stopAnimation() {
        super.stopAnimation()
    }

    public override func draw(_ rect: NSRect) {
        super.draw(rect)
    }

    public override func animateOneFrame() {
        // No-op, WKWebView maneja su timing
    }

    public override var hasConfigureSheet: Bool { false }
    public override var configureSheet: NSWindow? { nil }

    private static func indexURL() -> (URL, URL)? {
        // Try common locations created in this project
        let bundle = Bundle(for: self)
        if let url = bundle.url(forResource: "index", withExtension: "html", subdirectory: "web") {
            return (url, url.deletingLastPathComponent())
        }
        if let url = bundle.url(forResource: "web/index", withExtension: "html") {
            return (url, url.deletingLastPathComponent())
        }
        // Fallback: search for any index.html under bundle
        if let urls = bundle.urls(forResourcesWithExtension: "html", subdirectory: nil) {
            if let idx = urls.first(where: { $0.lastPathComponent.lowercased() == "index.html" }) {
                return (idx, idx.deletingLastPathComponent())
            }
        }
        return nil
    }
}
