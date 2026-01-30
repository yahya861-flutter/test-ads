import Flutter
import UIKit
import google_mobile_ads

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // Register 10 native ad factories
    for i in 1...10 {
        let factoryId = "native_ad_factory_\(i)"
        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
            self, factoryId: factoryId, nativeAdFactory: MyNativeAdFactory(styleIndex: i)
        )
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

class MyNativeAdFactory: NSObject, FLTNativeAdFactory {
    let styleIndex: Int

    init(styleIndex: Int) {
        self.styleIndex = styleIndex
        super.init()
    }

    func createNativeAd(_ nativeAd: NativeAd, customOptions: [AnyHashable : Any]?) -> NativeAdView? {
        let adView = NativeAdView()
        adView.translatesAutoresizingMaskIntoConstraints = false
        
        // Root padding container
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        adView.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: adView.topAnchor),
            container.leadingAnchor.constraint(equalTo: adView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: adView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: adView.bottomAnchor)
        ])

        switch styleIndex {
        case 1: setupClassicDesign(container, adView, nativeAd: nativeAd) // Small
        case 2: setupDarkDesign(container, adView, nativeAd: nativeAd)    // Medium
        case 3: setupLightDesign(container, adView, nativeAd: nativeAd)   // Large
        case 4: setupMediaHighDesign(container, adView, nativeAd: nativeAd) // Small
        case 5: setupCompactDesign(container, adView, nativeAd: nativeAd)   // Medium
        case 6: setupLuxuryDesign(container, adView, nativeAd: nativeAd)   // Large
        case 7: setupColorfulDesign(container, adView, nativeAd: nativeAd)  // Small
        case 8: setupRetroDesign(container, adView, nativeAd: nativeAd)    // Medium
        case 9: setupModernDesign(container, adView, nativeAd: nativeAd)   // Large
        case 10: setupFullMediaDesign(container, adView, nativeAd: nativeAd) // Small
        default: setupClassicDesign(container, adView, nativeAd: nativeAd)
        }
        
        adView.nativeAd = nativeAd
        return adView
    }

    private func setupClassicDesign(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd) {
        adView.backgroundColor = .white
        let mainStack = createMainStack(container)
        
        let header = createHeaderStack(nativeAd, adView: adView)
        let headline = createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 16), color: .red)
        adView.headlineView = headline
        
        let media = createMediaView(100, adView: adView)
        let body = createLabel(nativeAd.body, font: .systemFont(ofSize: 13), color: .black, lines: 2)
        adView.bodyView = body
        
        let cta = createButton(nativeAd.callToAction, bgColor: .systemBlue)
        adView.callToActionView = cta
        
        mainStack.addArrangedSubview(header)
        mainStack.addArrangedSubview(headline)
        mainStack.addArrangedSubview(media)
        mainStack.addArrangedSubview(body)
        mainStack.addArrangedSubview(cta)
    }

    private func setupDarkDesign(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd) {
        adView.backgroundColor = UIColor(white: 0.1, alpha: 1)
        let mainStack = createMainStack(container)
        
        let headline = createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 18), color: .white)
        adView.headlineView = headline
        
        let media = createMediaView(180, adView: adView)
        
        let cta = createButton(nativeAd.callToAction, bgColor: .systemOrange)
        adView.callToActionView = cta
        
        mainStack.addArrangedSubview(headline)
        mainStack.addArrangedSubview(media)
        mainStack.addArrangedSubview(cta)
    }

    private func setupLightDesign(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd) {
        adView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        let mainStack = createMainStack(container, spacing: 15)
        
        let headline = createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 22), color: .black)
        adView.headlineView = headline
        
        let media = createMediaView(260, adView: adView)
        
        let body = createLabel(nativeAd.body, font: .systemFont(ofSize: 14), color: .darkGray, lines: 4)
        adView.bodyView = body
        
        let cta = createButton(nativeAd.callToAction, bgColor: .black)
        adView.callToActionView = cta
        
        mainStack.addArrangedSubview(headline)
        mainStack.addArrangedSubview(media)
        mainStack.addArrangedSubview(body)
        mainStack.addArrangedSubview(cta)
    }

    private func setupMediaHighDesign(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd) {
        let mainStack = createMainStack(container, padding: 0, spacing: 0)
        let media = createMediaView(100, adView: adView)
        let headline = createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 16), color: .black)
        headline.textAlignment = .center
        adView.headlineView = headline
        
        mainStack.addArrangedSubview(media)
        mainStack.addArrangedSubview(headline)
    }

    private func setupCompactDesign(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd) {
        adView.backgroundColor = .white
        let mainStack = createMainStack(container, spacing: 10)
        
        let header = createHeaderStack(nativeAd, adView: adView)
        let media = createMediaView(170, adView: adView)
        let cta = createButton(nativeAd.callToAction, bgColor: .lightGray)
        adView.callToActionView = cta
        
        mainStack.addArrangedSubview(header)
        mainStack.addArrangedSubview(media)
        mainStack.addArrangedSubview(cta)
    }

    private func setupLuxuryDesign(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd) {
        adView.backgroundColor = .black
        let mainStack = createMainStack(container, spacing: 20)
        
        let headline = createLabel(nativeAd.headline, font: .italicSystemFont(ofSize: 24), color: .gold)
        adView.headlineView = headline
        
        let media = createMediaView(260, adView: adView)
        let cta = createButton(nativeAd.callToAction, bgColor: .gold)
        adView.callToActionView = cta
        
        mainStack.addArrangedSubview(headline)
        mainStack.addArrangedSubview(media)
        mainStack.addArrangedSubview(cta)
    }

    private func setupColorfulDesign(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd) {
        adView.backgroundColor = .systemPink
        let mainStack = createMainStack(container)
        let headline = createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 16), color: .white)
        adView.headlineView = headline
        let cta = createButton(nativeAd.callToAction, bgColor: .white)
        cta.setTitleColor(.systemPink, for: .normal)
        adView.callToActionView = cta
        
        mainStack.addArrangedSubview(headline)
        mainStack.addArrangedSubview(cta)
    }

    private func setupRetroDesign(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd) {
        adView.backgroundColor = .systemYellow
        let mainStack = createMainStack(container)
        let media = createMediaView(180, adView: adView)
        let cta = createButton(nativeAd.callToAction, bgColor: .brown)
        adView.callToActionView = cta
        
        mainStack.addArrangedSubview(media)
        mainStack.addArrangedSubview(cta)
    }

    private func setupModernDesign(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd) {
        adView.backgroundColor = .systemTeal
        let mainStack = createMainStack(container, spacing: 25)
        let headline = createLabel(nativeAd.headline, font: .systemFont(ofSize: 26), color: .white)
        adView.headlineView = headline
        let media = createMediaView(260, adView: adView)
        
        let cta = createButton(nativeAd.callToAction, bgColor: .white)
        cta.setTitleColor(.systemTeal, for: .normal)
        adView.callToActionView = cta
        
        mainStack.addArrangedSubview(headline)
        mainStack.addArrangedSubview(media)
        mainStack.addArrangedSubview(cta)
    }

    private func setupFullMediaDesign(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd) {
        let media = createMediaView(150, adView: adView)
        container.addSubview(media)
        NSLayoutConstraint.activate([
            media.topAnchor.constraint(equalTo: container.topAnchor),
            media.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            media.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            media.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }

    // Helper Factory Methods
    private func createMainStack(_ container: UIView, padding: CGFloat = 12, spacing: CGFloat = 8) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = spacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: container.topAnchor, constant: padding),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding),
            stack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -padding)
        ])
        return stack
    }

    private func createHeaderStack(_ nativeAd: NativeAd, adView: NativeAdView) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = nativeAd.icon?.image
        icon.contentMode = .scaleAspectFill
        icon.layer.cornerRadius = 8
        icon.clipsToBounds = true
        icon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        adView.iconView = icon
        
        let titleStack = UIStackView()
        titleStack.axis = .vertical
        titleStack.addArrangedSubview(createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 14), color: .black))
        titleStack.addArrangedSubview(createLabel(nativeAd.advertiser, font: .systemFont(ofSize: 12), color: .gray))
        
        stack.addArrangedSubview(icon)
        stack.addArrangedSubview(titleStack)
        return stack
    }

    private func createMediaView(_ height: CGFloat, adView: NativeAdView) -> MediaView {
        let media = MediaView()
        media.translatesAutoresizingMaskIntoConstraints = false
        media.heightAnchor.constraint(equalToConstant: height).isActive = true
        adView.mediaView = media
        return media
    }

    private func createLabel(_ text: String?, font: UIFont, color: UIColor, lines: Int = 1) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = color
        label.numberOfLines = lines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func createButton(_ title: String?, bgColor: UIColor) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.backgroundColor = bgColor
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }
}

extension UIColor {
    static var gold: UIColor { return UIColor(red: 212/255, green: 175/255, blue: 55/255, alpha: 1) }
}
