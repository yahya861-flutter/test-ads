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
        case 1: NativeAdDesign1.setup(container, adView, nativeAd: nativeAd, factory: self)
        case 2: NativeAdDesign2.setup(container, adView, nativeAd: nativeAd, factory: self)
        case 3: NativeAdDesign3.setup(container, adView, nativeAd: nativeAd, factory: self)
        case 4: NativeAdDesign4.setup(container, adView, nativeAd: nativeAd, factory: self)
        case 5: NativeAdDesign5.setup(container, adView, nativeAd: nativeAd, factory: self)
        case 6: NativeAdDesign6.setup(container, adView, nativeAd: nativeAd, factory: self)
        case 7: NativeAdDesign7.setup(container, adView, nativeAd: nativeAd, factory: self)
        case 8: NativeAdDesign8.setup(container, adView, nativeAd: nativeAd, factory: self)
        case 9: NativeAdDesign9.setup(container, adView, nativeAd: nativeAd, factory: self)
        case 10: NativeAdDesign10.setup(container, adView, nativeAd: nativeAd, factory: self)
        default: NativeAdDesign1.setup(container, adView, nativeAd: nativeAd, factory: self)
        }
        
        adView.nativeAd = nativeAd
        return adView
    }

    // Helper Factory Methods
    func createMainStack(_ container: UIView, padding: CGFloat = 12, spacing: CGFloat = 8) -> UIStackView {
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

    func createHeaderStack(_ nativeAd: NativeAd, adView: NativeAdView) -> UIStackView {
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

    func createMediaView(_ height: CGFloat, adView: NativeAdView) -> MediaView {
        let media = MediaView()
        media.translatesAutoresizingMaskIntoConstraints = false
        media.heightAnchor.constraint(equalToConstant: height).isActive = true
        adView.mediaView = media
        return media
    }

    func createLabel(_ text: String?, font: UIFont, color: UIColor, lines: Int = 1) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = color
        label.numberOfLines = lines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    func createButton(_ title: String?, bgColor: UIColor) -> UIButton {
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

// MARK: - Ad Designs

class NativeAdDesign1 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = .white
        let mainStack = factory.createMainStack(container)
        let header = factory.createHeaderStack(nativeAd, adView: adView)
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 16), color: .red)
        adView.headlineView = headline
        let media = factory.createMediaView(220, adView: adView)
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 13), color: .black, lines: 2)
        adView.bodyView = body
        let cta = factory.createButton(nativeAd.callToAction, bgColor: .systemBlue)
        adView.callToActionView = cta
        mainStack.addArrangedSubview(header)
        mainStack.addArrangedSubview(headline)
        mainStack.addArrangedSubview(media)
        mainStack.addArrangedSubview(body)
        mainStack.addArrangedSubview(cta)
    }
}

class NativeAdDesign2 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = UIColor(white: 0.1, alpha: 1)
        let mainStack = factory.createMainStack(container)
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 18), color: .white)
        adView.headlineView = headline
        let media = factory.createMediaView(150, adView: adView)
        let cta = factory.createButton(nativeAd.callToAction, bgColor: .systemOrange)
        adView.callToActionView = cta
        mainStack.addArrangedSubview(headline)
        mainStack.addArrangedSubview(media)
        mainStack.addArrangedSubview(cta)
    }
}

class NativeAdDesign3 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        let mainStack = factory.createMainStack(container, spacing: 10)
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 22), color: .black)
        adView.headlineView = headline
        let media = factory.createMediaView(220, adView: adView)
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 14), color: .darkGray, lines: 3)
        adView.bodyView = body
        let cta = factory.createButton(nativeAd.callToAction, bgColor: .black)
        adView.callToActionView = cta
        mainStack.addArrangedSubview(headline)
        mainStack.addArrangedSubview(media)
        mainStack.addArrangedSubview(body)
        mainStack.addArrangedSubview(cta)
    }
}

class NativeAdDesign4 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        let mainStack = factory.createMainStack(container, padding: 0, spacing: 0)
        let media = factory.createMediaView(140, adView: adView)
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 16), color: .black)
        headline.textAlignment = .center
        adView.headlineView = headline
        mainStack.addArrangedSubview(media)
        mainStack.addArrangedSubview(headline)
    }
}

class NativeAdDesign5 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = .white
        let mainStack = factory.createMainStack(container, spacing: 8)
        let header = factory.createHeaderStack(nativeAd, adView: adView)
        let media = factory.createMediaView(120, adView: adView)
        let cta = factory.createButton(nativeAd.callToAction, bgColor: .lightGray)
        adView.callToActionView = cta
        mainStack.addArrangedSubview(header)
        mainStack.addArrangedSubview(media)
        mainStack.addArrangedSubview(cta)
    }
}

class NativeAdDesign6 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = .black
        let mainStack = factory.createMainStack(container, spacing: 10)
        let headline = factory.createLabel(nativeAd.headline, font: .italicSystemFont(ofSize: 20), color: .gold)
        adView.headlineView = headline
        let media = factory.createMediaView(250, adView: adView)
        let cta = factory.createButton(nativeAd.callToAction, bgColor: .gold)
        adView.callToActionView = cta
        mainStack.addArrangedSubview(headline)
        mainStack.addArrangedSubview(media)
        mainStack.addArrangedSubview(cta)
    }
}

class NativeAdDesign7 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = UIColor.systemPink
        let mainStack = factory.createMainStack(container)
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 16), color: .white)
        adView.headlineView = headline
        let cta = factory.createButton(nativeAd.callToAction, bgColor: .white)
        cta.setTitleColor(UIColor.systemPink, for: UIControl.State.normal)
        adView.callToActionView = cta
        mainStack.addArrangedSubview(headline)
        mainStack.addArrangedSubview(cta)
    }
}

class NativeAdDesign8 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = .systemYellow
        let mainStack = factory.createMainStack(container)
        let media = factory.createMediaView(150, adView: adView)
        let cta = factory.createButton(nativeAd.callToAction, bgColor: .brown)
        adView.callToActionView = cta
        mainStack.addArrangedSubview(media)
        mainStack.addArrangedSubview(cta)
    }
}

class NativeAdDesign9 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = UIColor.systemTeal
        let mainStack = factory.createMainStack(container, spacing: 20)
        let headline = factory.createLabel(nativeAd.headline, font: .systemFont(ofSize: 24), color: .white)
        adView.headlineView = headline
        let media = factory.createMediaView(280, adView: adView)
        let cta = factory.createButton(nativeAd.callToAction, bgColor: .white)
        cta.setTitleColor(UIColor.systemTeal, for: UIControl.State.normal)
        adView.callToActionView = cta
        mainStack.addArrangedSubview(headline)
        mainStack.addArrangedSubview(media)
        mainStack.addArrangedSubview(cta)
    }
}

class NativeAdDesign10 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        let media = factory.createMediaView(180, adView: adView)
        container.addSubview(media)
        NSLayoutConstraint.activate([
            media.topAnchor.constraint(equalTo: container.topAnchor),
            media.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            media.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            media.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
}
