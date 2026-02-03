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

// MARK: - Native Ad Factory

class MyNativeAdFactory: NSObject, FLTNativeAdFactory {
    let styleIndex: Int

    init(styleIndex: Int) {
        self.styleIndex = styleIndex
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

// MARK: - Ad Designs

class NativeAdDesign1 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = UIColor(red: 0.929, green: 0.937, blue: 0.949, alpha: 1)

        let mainStack = factory.createMainStack(container, padding: 12, spacing: 12)

        // Header
        let headerStack = UIStackView()
        headerStack.axis = .horizontal
        headerStack.distribution = .equalSpacing
        headerStack.alignment = .center

        // Left: Icon + Headline
        let leftStack = UIStackView()
        leftStack.axis = .horizontal
        leftStack.alignment = .center
        leftStack.spacing = 10

        let iconContainer = UIView()
        iconContainer.layer.cornerRadius = 20
        iconContainer.clipsToBounds = true
        iconContainer.backgroundColor = .white
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        iconContainer.widthAnchor.constraint(equalToConstant: 40).isActive = true
        iconContainer.heightAnchor.constraint(equalToConstant: 40).isActive = true

        let iconView = factory.createIconView(nativeAd, adView: adView)
        iconContainer.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: iconContainer.topAnchor, constant: 2),
            iconView.bottomAnchor.constraint(equalTo: iconContainer.bottomAnchor, constant: -2),
            iconView.leadingAnchor.constraint(equalTo: iconContainer.leadingAnchor, constant: 2),
            iconView.trailingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: -2)
        ])

        let headlineLabel = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 14), color: .black)
        adView.headlineView = headlineLabel

        leftStack.addArrangedSubview(iconContainer)
        leftStack.addArrangedSubview(headlineLabel)

        // Right: Badge + Advertiser
        let rightStack = UIStackView()
        rightStack.axis = .horizontal
        rightStack.spacing = 6
        rightStack.alignment = .center

        let badgeLabel = UILabel()
        badgeLabel.text = "Ad"
        badgeLabel.font = .boldSystemFont(ofSize: 10)
        badgeLabel.textColor = UIColor(red: 0.22, green: 0.56, blue: 0.76, alpha: 1)
        badgeLabel.layer.borderWidth = 1
        badgeLabel.layer.borderColor = badgeLabel.textColor.cgColor
        badgeLabel.layer.cornerRadius = 4
        badgeLabel.clipsToBounds = true
        badgeLabel.textAlignment = .center
        rightStack.addArrangedSubview(badgeLabel)

        let advertiserLabel = factory.createLabel(nativeAd.advertiser, font: .systemFont(ofSize: 12), color: .gray)
        adView.advertiserView = advertiserLabel
        rightStack.addArrangedSubview(advertiserLabel)

        headerStack.addArrangedSubview(leftStack)
        headerStack.addArrangedSubview(rightStack)

        mainStack.addArrangedSubview(headerStack)

        // Media
        let mediaView = factory.createMediaView(120, adView: adView)
        mainStack.addArrangedSubview(mediaView)

        // Body
        if let body = nativeAd.body {
            let bodyLabel = factory.createLabel(body, font: .systemFont(ofSize: 13), color: .black, lines: 2)
            adView.bodyView = bodyLabel
            mainStack.addArrangedSubview(bodyLabel)
        }

        // CTA
        let ctaButton = factory.createButton(nativeAd.callToAction, bgColor: .systemBlue)
        adView.callToActionView = ctaButton
        mainStack.addArrangedSubview(ctaButton)
    }
}


class NativeAdDesign2 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = .white  // Match XML background

        // Main vertical stack
        let mainStack = factory.createMainStack(container)
        mainStack.axis = .vertical
        mainStack.spacing = 4
        mainStack.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        mainStack.isLayoutMarginsRelativeArrangement = true

        // Media view
        let media = factory.createMediaView(180, adView: adView) // height 180dp to match XML
        adView.mediaView = media
        media.translatesAutoresizingMaskIntoConstraints = false
        media.heightAnchor.constraint(equalToConstant: 180).isActive = true

        // Headline
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 18), color: .white)
        adView.headlineView = headline
        headline.numberOfLines = 1
        headline.lineBreakMode = .byTruncatingTail

        // Body text
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 14), color: .black)
        adView.bodyView = body
        body.numberOfLines = 2
        body.lineBreakMode = .byTruncatingTail
        body.translatesAutoresizingMaskIntoConstraints = false
        body.setContentHuggingPriority(.defaultLow, for: .vertical)

        // Call to action button
        let cta = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 1, green: 0.84, blue: 0, alpha: 1)) // #FFD700
        adView.callToActionView = cta
        cta.heightAnchor.constraint(equalToConstant: 50).isActive = true

        // Add all to main stack
        mainStack.addArrangedSubview(media)
        mainStack.addArrangedSubview(headline)
        mainStack.addArrangedSubview(body)
        mainStack.addArrangedSubview(cta)
    }
}


class NativeAdDesign3 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        // Outer background
        adView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1) // #F2F2F2

        // Main vertical stack
        let mainStack = factory.createMainStack(container, spacing: 8)
        mainStack.backgroundColor = .white
        mainStack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        mainStack.isLayoutMarginsRelativeArrangement = true
        mainStack.axis = .vertical

        // Top horizontal row
        let topRow = UIStackView()
        topRow.axis = .horizontal
        topRow.alignment = .center
        topRow.spacing = 8

// App icon
let appIcon = UIImageView()
appIcon.translatesAutoresizingMaskIntoConstraints = false
appIcon.contentMode = .scaleAspectFit
appIcon.clipsToBounds = true
appIcon.widthAnchor.constraint(equalToConstant: 42).isActive = true
appIcon.heightAnchor.constraint(equalToConstant: 42).isActive = true
adView.iconView = appIcon
topRow.addArrangedSubview(appIcon)

// Assign image if available
if let icon = nativeAd.icon {
    appIcon.image = icon.image
} else {
    appIcon.image = UIImage(systemName: "app.fill") // optional placeholder
}


        // Headline + Advertiser vertical stack
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 2

        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 15), color: .black)
        headline.numberOfLines = 1
        headline.lineBreakMode = .byTruncatingTail
        adView.headlineView = headline

        let advertiser = factory.createLabel(nativeAd.advertiser, font: .systemFont(ofSize: 11), color: .darkGray)
        advertiser.numberOfLines = 1
        advertiser.lineBreakMode = .byTruncatingTail
        adView.advertiserView = advertiser

        textStack.addArrangedSubview(headline)
        textStack.addArrangedSubview(advertiser)
        topRow.addArrangedSubview(textStack)

        // "Ad" Label
        let adLabel = UILabel()
        adLabel.text = "Ad"
        adLabel.font = .systemFont(ofSize: 10)
        adLabel.textColor = .white
        adLabel.backgroundColor = UIColor(red: 30/255, green: 155/255, blue: 233/255, alpha: 1) // #1E9BE9
        adLabel.textAlignment = .center
        adLabel.layer.cornerRadius = 4
        adLabel.clipsToBounds = true
        adLabel.setContentHuggingPriority(.required, for: .horizontal)
        adLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        adLabel.translatesAutoresizingMaskIntoConstraints = false
        adLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        topRow.addArrangedSubview(adLabel)

        // Media view
        let media = factory.createMediaView(190, adView: adView)
        adView.mediaView = media
        media.translatesAutoresizingMaskIntoConstraints = false
        media.heightAnchor.constraint(equalToConstant: 190).isActive = true

        // CTA button
        let cta = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 30/255, green: 155/255, blue: 233/255, alpha: 1)) // #1E9BE9
        cta.setTitleColor(.white, for: .normal)
        cta.titleLabel?.font = .boldSystemFont(ofSize: 14)
        adView.callToActionView = cta
        cta.heightAnchor.constraint(equalToConstant: 46).isActive = true

        // Add all to main stack
        mainStack.addArrangedSubview(topRow)
        mainStack.addArrangedSubview(media)
        mainStack.addArrangedSubview(cta)
    }
}

class NativeAdDesign4 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        // Outer background
        adView.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1) // #F3F3F3

        // Main vertical stack
        let mainStack = factory.createMainStack(container, spacing: 8)
        mainStack.backgroundColor = .white
        mainStack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        mainStack.isLayoutMarginsRelativeArrangement = true
        mainStack.axis = .vertical

        // Top: MediaView
        let media = factory.createMediaView(140, adView: adView)
        adView.mediaView = media
        media.translatesAutoresizingMaskIntoConstraints = false
        media.heightAnchor.constraint(equalToConstant: 140).isActive = true
        mainStack.addArrangedSubview(media)

        // Bottom horizontal row
        let bottomRow = UIStackView()
        bottomRow.axis = .horizontal
        bottomRow.alignment = .center
        bottomRow.spacing = 8

        // App icon
        let appIcon = UIImageView()
        appIcon.translatesAutoresizingMaskIntoConstraints = false
        appIcon.contentMode = .scaleAspectFit
        appIcon.clipsToBounds = true
        appIcon.widthAnchor.constraint(equalToConstant: 36).isActive = true
        appIcon.heightAnchor.constraint(equalToConstant: 36).isActive = true
        adView.iconView = appIcon
        bottomRow.addArrangedSubview(appIcon)

        // Assign icon image
        if let icon = nativeAd.icon {
            appIcon.image = icon.image
        } else {
            appIcon.image = UIImage(systemName: "app.fill") // optional placeholder
        }

        // Headline + Sponsored vertical stack
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 2

        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 14), color: .black)
        headline.numberOfLines = 1
        headline.lineBreakMode = .byTruncatingTail
        adView.headlineView = headline

        let sponsored = UILabel()
        sponsored.text = "Sponsored"
        sponsored.font = .systemFont(ofSize: 10)
        sponsored.textColor = UIColor.gray // #888888
        sponsored.numberOfLines = 1

        textStack.addArrangedSubview(headline)
        textStack.addArrangedSubview(sponsored)
        bottomRow.addArrangedSubview(textStack)

        // CTA button
        let cta = UIButton(type: .system)
        cta.setTitle(nativeAd.callToAction ?? "Install", for: .normal)
        cta.setTitleColor(.white, for: .normal)
        cta.titleLabel?.font = .systemFont(ofSize: 12)
        cta.backgroundColor = UIColor(red: 30/255, green: 155/255, blue: 233/255, alpha: 1) // #1E9BE9
        cta.layer.cornerRadius = 4
        cta.clipsToBounds = true
        cta.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        cta.heightAnchor.constraint(equalToConstant: 34).isActive = true
        // Wrap content width like Android's wrap_content
        cta.setContentHuggingPriority(.required, for: .horizontal)
        cta.setContentCompressionResistancePriority(.required, for: .horizontal)
        adView.callToActionView = cta
        bottomRow.addArrangedSubview(cta)

        // Add bottom row to main stack
        mainStack.addArrangedSubview(bottomRow)
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
