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
    
    // Register 10 native ad factories (Light & Dark)
    for i in 1...10 {
        let lightId = "native_ad_factory_\(i)"
        let darkId = "native_ad_factory_\(i)_dark"
        
        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
            self, factoryId: lightId, nativeAdFactory: MyNativeAdFactory(styleIndex: i, isDark: false)
        )
        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
            self, factoryId: darkId, nativeAdFactory: MyNativeAdFactory(styleIndex: i, isDark: true)
        )
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

// MARK: - Native Ad Factory

class MyNativeAdFactory: NSObject, FLTNativeAdFactory {
    let styleIndex: Int
    let isDark: Bool

    init(styleIndex: Int, isDark: Bool = false) {
        self.styleIndex = styleIndex
        self.isDark = isDark
        super.init()
    }

    func createNativeAd(_ nativeAd: NativeAd, customOptions: [AnyHashable : Any]?) -> NativeAdView? {
        let adView = NativeAdView()
        // Removed: adView.translatesAutoresizingMaskIntoConstraints = false
        
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        adView.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: adView.topAnchor),
            container.leadingAnchor.constraint(equalTo: adView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: adView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: adView.bottomAnchor)
        ])

        if isDark {
            switch styleIndex {
            case 1: NativeAdDesign1Dark.setup(container, adView, nativeAd: nativeAd, factory: self)
            case 2: NativeAdDesign2Dark.setup(container, adView, nativeAd: nativeAd, factory: self)
            case 3: NativeAdDesign3Dark.setup(container, adView, nativeAd: nativeAd, factory: self)
            case 4: NativeAdDesign4Dark.setup(container, adView, nativeAd: nativeAd, factory: self)
            case 5: NativeAdDesign5Dark.setup(container, adView, nativeAd: nativeAd, factory: self)
            case 6: NativeAdDesign6Dark.setup(container, adView, nativeAd: nativeAd, factory: self)
            case 7: NativeAdDesign7Dark.setup(container, adView, nativeAd: nativeAd, factory: self)
            case 8: NativeAdDesign8Dark.setup(container, adView, nativeAd: nativeAd, factory: self)
            case 9: NativeAdDesign9Dark.setup(container, adView, nativeAd: nativeAd, factory: self)
            case 10: NativeAdDesign10Dark.setup(container, adView, nativeAd: nativeAd, factory: self)
            default: NativeAdDesign1Dark.setup(container, adView, nativeAd: nativeAd, factory: self)
            }
        } else {
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
        
        let icon = createIconView(nativeAd, adView: adView)
        icon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let titleStack = UIStackView()
        titleStack.axis = .vertical
        titleStack.addArrangedSubview(createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 14), color: .black))
        titleStack.addArrangedSubview(createLabel(nativeAd.advertiser, font: .systemFont(ofSize: 12), color: .gray))
        
        stack.addArrangedSubview(icon)
        stack.addArrangedSubview(titleStack)
        return stack
    }

    func createIconView(_ nativeAd: NativeAd, adView: NativeAdView) -> UIImageView {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = nativeAd.icon?.image
        icon.contentMode = .scaleAspectFill
        icon.layer.cornerRadius = 8
        icon.clipsToBounds = true
        adView.iconView = icon
        return icon
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

// MARK: - Ad Designs moved to NativeAdDesigns/

