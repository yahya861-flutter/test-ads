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
        // Outer background #F3F3F3
        adView.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)

        // Main vertical stack (Inner Layout)
        // XML has padding 8dp and background #FFFFFF
        let mainStack = factory.createMainStack(container, padding: 0) // We use padding 0 here because container fills adView
        mainStack.axis = .vertical
        mainStack.spacing = 8
        mainStack.backgroundColor = .white
        mainStack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        mainStack.isLayoutMarginsRelativeArrangement = true

        // Top: MediaView (height 140dp)
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

        // App icon (36dp x 36dp)
        let appIcon = factory.createIconView(nativeAd, adView: adView)
        appIcon.translatesAutoresizingMaskIntoConstraints = false
        appIcon.widthAnchor.constraint(equalToConstant: 36).isActive = true
        appIcon.heightAnchor.constraint(equalToConstant: 36).isActive = true
        bottomRow.addArrangedSubview(appIcon)

        // Headline + Sponsored vertical stack
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 2

        // Headline (14sp, bold, black, 1 max line)
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 14), color: .black)
        headline.numberOfLines = 1
        headline.lineBreakMode = .byTruncatingTail
        adView.headlineView = headline

        // Sponsored (10sp, color #888888)
        let sponsored = UILabel()
        sponsored.text = "Sponsored"
        sponsored.font = .systemFont(ofSize: 10)
        sponsored.textColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1)
        sponsored.numberOfLines = 1

        textStack.addArrangedSubview(headline)
        textStack.addArrangedSubview(sponsored)
        bottomRow.addArrangedSubview(textStack)

        // CTA button (height 34dp, background #1E9BE9, 12sp white text)
        let cta = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 30/255, green: 155/255, blue: 233/255, alpha: 1))
        cta.titleLabel?.font = .systemFont(ofSize: 12)
        cta.layer.cornerRadius = 4 // XML doesn't specify but standard Android buttons have a radius
        cta.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        cta.heightAnchor.constraint(equalToConstant: 34).isActive = true
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
        // Root background #FAFAFA, padding 8dp
        adView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        
        let mainStack = UIStackView()
        mainStack.axis = .horizontal
        mainStack.alignment = .center
        mainStack.spacing = 0
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            mainStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            mainStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            mainStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8)
        ])

        // App Icon Container (48dp, Circle BG)
        let iconContainer = UIView()
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        iconContainer.backgroundColor = .white // circle_bg equivalent
        iconContainer.layer.cornerRadius = 24
        iconContainer.clipsToBounds = true
        iconContainer.widthAnchor.constraint(equalToConstant: 48).isActive = true
        iconContainer.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        let iconView = factory.createIconView(nativeAd, adView: adView)
        iconContainer.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: iconContainer.topAnchor, constant: 2),
            iconView.bottomAnchor.constraint(equalTo: iconContainer.bottomAnchor, constant: -2),
            iconView.leadingAnchor.constraint(equalTo: iconContainer.leadingAnchor, constant: 2),
            iconView.trailingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: -2)
        ])
        
        // Wrap iconContainer in a view to handle marginEnd
        let iconWrapper = UIView()
        iconWrapper.addSubview(iconContainer)
        NSLayoutConstraint.activate([
            iconContainer.topAnchor.constraint(equalTo: iconWrapper.topAnchor),
            iconContainer.leadingAnchor.constraint(equalTo: iconWrapper.leadingAnchor),
            iconContainer.bottomAnchor.constraint(equalTo: iconWrapper.bottomAnchor),
            iconContainer.trailingAnchor.constraint(equalTo: iconWrapper.trailingAnchor, constant: -10)
        ])
        mainStack.addArrangedSubview(iconWrapper)

        // Text Section (Headline + Body)
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 2
        
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 14), color: UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1))
        headline.numberOfLines = 1
        adView.headlineView = headline
        
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 12), color: UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1))
        body.numberOfLines = 2
        adView.bodyView = body
        
        textStack.addArrangedSubview(headline)
        textStack.addArrangedSubview(body)
        mainStack.addArrangedSubview(textStack)

        // CTA Section (Ad Label + Button)
        let ctaStack = UIStackView()
        ctaStack.axis = .vertical
        ctaStack.alignment = .trailing
        ctaStack.spacing = 6
        
        let adBadge = UILabel()
        adBadge.text = "Ad"
        adBadge.font = .boldSystemFont(ofSize: 10)
        adBadge.textColor = UIColor(red: 56/255, green: 142/255, blue: 60/255, alpha: 1) // #388E3C
        adBadge.layer.borderWidth = 1
        adBadge.layer.borderColor = adBadge.textColor.cgColor
        adBadge.layer.cornerRadius = 4
        adBadge.clipsToBounds = true
        adBadge.textAlignment = .center
        adBadge.translatesAutoresizingMaskIntoConstraints = false
        adBadge.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        let ctaButton = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 30/255, green: 155/255, blue: 233/255, alpha: 1))
        ctaButton.titleLabel?.font = .boldSystemFont(ofSize: 11)
        ctaButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        ctaButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        adView.callToActionView = ctaButton
        
        ctaStack.addArrangedSubview(adBadge)
        ctaStack.addArrangedSubview(ctaButton)
        mainStack.addArrangedSubview(ctaStack)
    }
}

class NativeAdDesign6 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        // Root background #FFFFFF
        adView.backgroundColor = .white
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            containerView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            containerView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            containerView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12)
        ])

        // App Icon (60dp, alignParentEnd)
        let iconView = factory.createIconView(nativeAd, adView: adView)
        iconView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        containerView.addSubview(iconView)
        
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: containerView.topAnchor),
            iconView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])

        // Text Container (Headline + Body, toStartOf icon)
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 4
        textStack.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(textStack)
        
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 17), color: UIColor(red: 38/255, green: 50/255, blue: 56/255, alpha: 1))
        headline.numberOfLines = 1
        adView.headlineView = headline
        
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 13), color: UIColor(red: 84/255, green: 110/255, blue: 122/255, alpha: 1))
        body.numberOfLines = 2
        adView.bodyView = body
        
        textStack.addArrangedSubview(headline)
        textStack.addArrangedSubview(body)
        
        NSLayoutConstraint.activate([
            textStack.topAnchor.constraint(equalTo: containerView.topAnchor),
            textStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            textStack.trailingAnchor.constraint(equalTo: iconView.leadingAnchor, constant: -12)
        ])

        // CTA Button (Full width, below text_container)
        let ctaButton = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 30/255, green: 155/255, blue: 233/255, alpha: 1))
        ctaButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        adView.callToActionView = ctaButton
        containerView.addSubview(ctaButton)
        
        NSLayoutConstraint.activate([
            ctaButton.topAnchor.constraint(equalTo: textStack.bottomAnchor, constant: 20),
            ctaButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            ctaButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            ctaButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}

class NativeAdDesign7 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        // Root background #F5F5F5
        adView.backgroundColor = UIColor(white: 0.96, alpha: 1)
        
        // Inner layout background #FFFFFF, padding 12dp
        let mainStack = factory.createMainStack(container, padding: 0)
        mainStack.axis = .vertical
        mainStack.spacing = 0 // Manual spacing for precise control
        mainStack.backgroundColor = .white
        mainStack.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        mainStack.isLayoutMarginsRelativeArrangement = true

        // Headline + Ad Label row
        let topRow = UIStackView()
        topRow.axis = .horizontal
        topRow.alignment = .center
        topRow.spacing = 8
        
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 16), color: UIColor(white: 0.13, alpha: 1))
        headline.numberOfLines = 1
        adView.headlineView = headline
        
        let adBadge = UILabel()
        adBadge.text = "Ad"
        adBadge.font = .systemFont(ofSize: 10)
        adBadge.textColor = .white
        adBadge.backgroundColor = UIColor(white: 0.62, alpha: 1) // #9E9E9E
        adBadge.textAlignment = .center
        adBadge.translatesAutoresizingMaskIntoConstraints = false
        adBadge.widthAnchor.constraint(equalToConstant: 24).isActive = true
        adBadge.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        topRow.addArrangedSubview(headline)
        topRow.addArrangedSubview(adBadge)
        mainStack.addArrangedSubview(topRow)

        // Media (140dp)
        let media = factory.createMediaView(140, adView: adView)
        media.translatesAutoresizingMaskIntoConstraints = false
        media.heightAnchor.constraint(equalToConstant: 140).isActive = true
        adView.mediaView = media
        
        let mediaWrapper = UIView()
        mediaWrapper.addSubview(media)
        NSLayoutConstraint.activate([
            media.topAnchor.constraint(equalTo: mediaWrapper.topAnchor, constant: 8),
            media.leadingAnchor.constraint(equalTo: mediaWrapper.leadingAnchor),
            media.trailingAnchor.constraint(equalTo: mediaWrapper.trailingAnchor),
            media.bottomAnchor.constraint(equalTo: mediaWrapper.bottomAnchor)
        ])
        mainStack.addArrangedSubview(mediaWrapper)

        // Body
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 13), color: UIColor(white: 0.38, alpha: 1))
        body.numberOfLines = 2
        adView.bodyView = body
        
        let bodyWrapper = UIView()
        bodyWrapper.addSubview(body)
        NSLayoutConstraint.activate([
            body.topAnchor.constraint(equalTo: bodyWrapper.topAnchor, constant: 6),
            body.leadingAnchor.constraint(equalTo: bodyWrapper.leadingAnchor),
            body.trailingAnchor.constraint(equalTo: bodyWrapper.trailingAnchor),
            body.bottomAnchor.constraint(equalTo: bodyWrapper.bottomAnchor)
        ])
        mainStack.addArrangedSubview(bodyWrapper)

        // CTA
        let ctaButton = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 103/255, green: 58/255, blue: 183/255, alpha: 1)) // #673AB7
        ctaButton.titleLabel?.font = .systemFont(ofSize: 14)
        ctaButton.heightAnchor.constraint(equalToConstant: 42).isActive = true
        adView.callToActionView = ctaButton
        
        let ctaWrapper = UIView()
        ctaWrapper.addSubview(ctaButton)
        NSLayoutConstraint.activate([
            ctaButton.topAnchor.constraint(equalTo: ctaWrapper.topAnchor, constant: 10),
            ctaButton.leadingAnchor.constraint(equalTo: ctaWrapper.leadingAnchor),
            ctaButton.trailingAnchor.constraint(equalTo: ctaWrapper.trailingAnchor),
            ctaButton.bottomAnchor.constraint(equalTo: ctaWrapper.bottomAnchor)
        ])
        mainStack.addArrangedSubview(ctaWrapper)
    }
}

class NativeAdDesign8 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        // Root bg #F2F2F2, padding 16dp
        adView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        let mainStack = factory.createMainStack(container, padding: 0)
        mainStack.axis = .vertical
        mainStack.spacing = 12
        mainStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        mainStack.isLayoutMarginsRelativeArrangement = true

        // Top row: Icon (60x60) + TextStack
        let topRow = UIStackView()
        topRow.axis = .horizontal
        topRow.alignment = .center
        topRow.spacing = 12
        
        let iconView = factory.createIconView(nativeAd, adView: adView)
        iconView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 4
        
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 18), color: UIColor(red: 62/255, green: 39/255, blue: 35/255, alpha: 1))
        headline.numberOfLines = 1
        adView.headlineView = headline
        
        // Stars equivalent (Label for now as iOS native ad doesn't have rating view in basic logic)
        let ratingLabel = UILabel()
        ratingLabel.text = "★★★★★"
        ratingLabel.textColor = .orange
        ratingLabel.font = .systemFont(ofSize: 12)
        
        textStack.addArrangedSubview(headline)
        textStack.addArrangedSubview(ratingLabel)
        
        topRow.addArrangedSubview(iconView)
        topRow.addArrangedSubview(textStack)
        mainStack.addArrangedSubview(topRow)

        // Media View (200dp)
        let media = factory.createMediaView(200, adView: adView)
        adView.mediaView = media
        mainStack.addArrangedSubview(media)

        // CTA Button (#FFB300)
        let ctaButton = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 255/255, green: 179/255, blue: 0/255, alpha: 1))
        ctaButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        ctaButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        adView.callToActionView = ctaButton
        mainStack.addArrangedSubview(ctaButton)
    }
}

class NativeAdDesign9 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = .white
        
        let mainStack = factory.createMainStack(container, padding: 12)
        mainStack.axis = .horizontal
        mainStack.alignment = .center
        mainStack.spacing = 10
        
        // App Icon (60dp, circle)
        let iconView = factory.createIconView(nativeAd, adView: adView)
        iconView.layer.cornerRadius = 30
        iconView.clipsToBounds = true
        iconView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        // Text Column
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 2
        
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 16), color: UIColor(red: 1/255, green: 87/255, blue: 155/255, alpha: 1))
        headline.numberOfLines = 1
        adView.headlineView = headline
        
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 12), color: UIColor(red: 2/255, green: 136/255, blue: 209/255, alpha: 1))
        body.numberOfLines = 2
        adView.bodyView = body
        
        let ratingLabel = UILabel()
        ratingLabel.text = "★★★★★"
        ratingLabel.textColor = .systemBlue
        ratingLabel.font = .systemFont(ofSize: 10)
        
        textStack.addArrangedSubview(headline)
        textStack.addArrangedSubview(body)
        textStack.addArrangedSubview(ratingLabel)
        
        // Ensure textStack stretches and button hugs
        textStack.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textStack.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        // CTA Button (#03A9F4)
        let ctaButton = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 3/255, green: 169/255, blue: 244/255, alpha: 1))
        ctaButton.titleLabel?.font = .boldSystemFont(ofSize: 11)
        ctaButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        ctaButton.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        ctaButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
        ctaButton.widthAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
        adView.callToActionView = ctaButton
        
        mainStack.addArrangedSubview(iconView)
        mainStack.addArrangedSubview(textStack)
        mainStack.addArrangedSubview(ctaButton)
    }
}

final class NativeAdDesign10 {

    static func setup(
        _ container: UIView,
        _ adView: NativeAdView,
        nativeAd: NativeAd,
        factory: MyNativeAdFactory
    ) {

        // Root background (card)
        adView.backgroundColor = UIColor(white: 0.95, alpha: 1)

        // Main horizontal stack
        let mainStack = factory.createMainStack(container, padding: 0)
        mainStack.axis = .horizontal
        mainStack.spacing = 0
        mainStack.alignment = .center
        mainStack.backgroundColor = .white
        mainStack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        mainStack.isLayoutMarginsRelativeArrangement = true

        // Media (Left)
        let mediaView = factory.createMediaView(140, adView: adView)
        mediaView.translatesAutoresizingMaskIntoConstraints = false
        mediaView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        adView.mediaView = mediaView

        // Info stack (Right)
        let infoStack = UIStackView()
        infoStack.axis = .vertical
        infoStack.spacing = 4
        infoStack.alignment = .center
        infoStack.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        infoStack.isLayoutMarginsRelativeArrangement = true

        // App Icon
        let iconView = factory.createIconView(nativeAd, adView: adView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 60).isActive = true

        // Headline
        let headline = factory.createLabel(
            nativeAd.headline,
            font: .boldSystemFont(ofSize: 14),
            color: UIColor(white: 0.13, alpha: 1)
        )
        headline.numberOfLines = 1
        headline.textAlignment = .center
        adView.headlineView = headline

        // Body
        let body = factory.createLabel(
            nativeAd.body,
            font: .systemFont(ofSize: 11),
            color: UIColor(white: 0.46, alpha: 1)
        )
        body.numberOfLines = 2
        body.textAlignment = .center
        adView.bodyView = body

        // Bottom row (AD badge + CTA)
        let bottomRow = UIStackView()
        bottomRow.axis = .horizontal
        bottomRow.alignment = .center
        bottomRow.spacing = 8

        let adBadge = UILabel()
        adBadge.text = "AD"
        adBadge.font = .boldSystemFont(ofSize: 10)
        adBadge.textColor = .white
        adBadge.backgroundColor = UIColor(red: 211/255, green: 47/255, blue: 47/255, alpha: 1)
        adBadge.textAlignment = .center
        adBadge.layer.cornerRadius = 2
        adBadge.clipsToBounds = true
        adBadge.translatesAutoresizingMaskIntoConstraints = false
        adBadge.widthAnchor.constraint(equalToConstant: 24).isActive = true
        adBadge.heightAnchor.constraint(equalToConstant: 16).isActive = true

        let ctaButton = factory.createButton(
            nativeAd.callToAction,
            bgColor: UIColor(red: 211/255, green: 47/255, blue: 47/255, alpha: 1)
        )
        ctaButton.titleLabel?.font = .boldSystemFont(ofSize: 12)
        ctaButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        adView.callToActionView = ctaButton

        // Assemble
        bottomRow.addArrangedSubview(adBadge)
        bottomRow.addArrangedSubview(ctaButton)

        infoStack.addArrangedSubview(iconView)
        infoStack.addArrangedSubview(headline)
        infoStack.addArrangedSubview(body)
        infoStack.addArrangedSubview(bottomRow)

        mainStack.addArrangedSubview(mediaView)
        mainStack.addArrangedSubview(infoStack)

        // Width ratio (Media 1.3x Info)
        mediaView.widthAnchor.constraint(equalTo: infoStack.widthAnchor, multiplier: 1.3).isActive = true
    }
}


// MARK: - Dark Mode Ad Designs

class NativeAdDesign1Dark {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        let mainStack = factory.createMainStack(container, padding: 12, spacing: 12)
        
        // Header
        let headerStack = UIStackView()
        headerStack.axis = .horizontal
        headerStack.distribution = .equalSpacing
        headerStack.alignment = .center
        
        let leftStack = UIStackView()
        leftStack.axis = .horizontal
        leftStack.alignment = .center
        leftStack.spacing = 10
        
        let iconContainer = UIView()
        iconContainer.layer.cornerRadius = 20
        iconContainer.clipsToBounds = true
        iconContainer.backgroundColor = UIColor(white: 0.2, alpha: 1)
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
        
        let headlineLabel = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 14), color: .white)
        adView.headlineView = headlineLabel
        
        leftStack.addArrangedSubview(iconContainer)
        leftStack.addArrangedSubview(headlineLabel)
        
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
        
        let advertiserLabel = factory.createLabel(nativeAd.advertiser, font: .systemFont(ofSize: 12), color: .lightGray)
        adView.advertiserView = advertiserLabel
        rightStack.addArrangedSubview(advertiserLabel)
        
        headerStack.addArrangedSubview(leftStack)
        headerStack.addArrangedSubview(rightStack)
        mainStack.addArrangedSubview(headerStack)
        
        let mediaView = factory.createMediaView(120, adView: adView)
        mainStack.addArrangedSubview(mediaView)
        
        if let body = nativeAd.body {
            let bodyLabel = factory.createLabel(body, font: .systemFont(ofSize: 13), color: .white, lines: 2)
            adView.bodyView = bodyLabel
            mainStack.addArrangedSubview(bodyLabel)
        }
        
        let ctaButton = factory.createButton(nativeAd.callToAction, bgColor: .systemBlue)
        adView.callToActionView = ctaButton
        mainStack.addArrangedSubview(ctaButton)
    }
}

class NativeAdDesign2Dark {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = UIColor(white: 0.1, alpha: 1)
        let mainStack = factory.createMainStack(container)
        mainStack.axis = .vertical
        mainStack.spacing = 4
        mainStack.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        mainStack.isLayoutMarginsRelativeArrangement = true

        let media = factory.createMediaView(180, adView: adView)
        adView.mediaView = media
        media.translatesAutoresizingMaskIntoConstraints = false
        media.heightAnchor.constraint(equalToConstant: 180).isActive = true

        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 18), color: .white)
        adView.headlineView = headline
        headline.numberOfLines = 1

        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 14), color: .lightGray)
        adView.bodyView = body
        body.numberOfLines = 2

        let cta = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 1, green: 0.84, blue: 0, alpha: 1))
        adView.callToActionView = cta
        cta.heightAnchor.constraint(equalToConstant: 50).isActive = true

        mainStack.addArrangedSubview(media)
        mainStack.addArrangedSubview(headline)
        mainStack.addArrangedSubview(body)
        mainStack.addArrangedSubview(cta)
    }
}

class NativeAdDesign3Dark {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = UIColor(white: 0.05, alpha: 1)
        let mainStack = factory.createMainStack(container, spacing: 8)
        mainStack.backgroundColor = UIColor(white: 0.15, alpha: 1)
        mainStack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        mainStack.isLayoutMarginsRelativeArrangement = true
        mainStack.axis = .vertical

        let topRow = UIStackView()
        topRow.axis = .horizontal
        topRow.alignment = .center
        topRow.spacing = 8

        let appIcon = factory.createIconView(nativeAd, adView: adView)
        appIcon.widthAnchor.constraint(equalToConstant: 42).isActive = true
        appIcon.heightAnchor.constraint(equalToConstant: 42).isActive = true
        topRow.addArrangedSubview(appIcon)

        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 2

        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 15), color: .white)
        headline.numberOfLines = 1
        adView.headlineView = headline

        let advertiser = factory.createLabel(nativeAd.advertiser, font: .systemFont(ofSize: 11), color: .lightGray)
        advertiser.numberOfLines = 1
        adView.advertiserView = advertiser

        textStack.addArrangedSubview(headline)
        textStack.addArrangedSubview(advertiser)
        topRow.addArrangedSubview(textStack)

        let adLabel = UILabel()
        adLabel.text = "Ad"
        adLabel.font = .systemFont(ofSize: 10)
        adLabel.textColor = .white
        adLabel.backgroundColor = UIColor(red: 30/255, green: 155/255, blue: 233/255, alpha: 1)
        adLabel.textAlignment = .center
        adLabel.layer.cornerRadius = 4
        adLabel.clipsToBounds = true
        adLabel.translatesAutoresizingMaskIntoConstraints = false
        adLabel.widthAnchor.constraint(equalToConstant: 24).isActive = true
        adLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        topRow.addArrangedSubview(adLabel)

        let media = factory.createMediaView(190, adView: adView)
        adView.mediaView = media
        media.translatesAutoresizingMaskIntoConstraints = false
        media.heightAnchor.constraint(equalToConstant: 190).isActive = true

        let cta = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 30/255, green: 155/255, blue: 233/255, alpha: 1))
        adView.callToActionView = cta
        cta.heightAnchor.constraint(equalToConstant: 46).isActive = true

        mainStack.addArrangedSubview(topRow)
        mainStack.addArrangedSubview(media)
        mainStack.addArrangedSubview(cta)
    }
}

class NativeAdDesign4Dark {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = UIColor(white: 0.1, alpha: 1)
        let mainStack = factory.createMainStack(container, padding: 0)
        mainStack.axis = .vertical
        mainStack.spacing = 8
        mainStack.backgroundColor = UIColor(white: 0.18, alpha: 1)
        mainStack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        mainStack.isLayoutMarginsRelativeArrangement = true

        let media = factory.createMediaView(140, adView: adView)
        adView.mediaView = media
        media.translatesAutoresizingMaskIntoConstraints = false
        media.heightAnchor.constraint(equalToConstant: 140).isActive = true
        mainStack.addArrangedSubview(media)

        let bottomRow = UIStackView()
        bottomRow.axis = .horizontal
        bottomRow.alignment = .center
        bottomRow.spacing = 8

        let appIcon = factory.createIconView(nativeAd, adView: adView)
        appIcon.widthAnchor.constraint(equalToConstant: 36).isActive = true
        appIcon.heightAnchor.constraint(equalToConstant: 36).isActive = true
        bottomRow.addArrangedSubview(appIcon)

        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 2

        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 14), color: .white)
        headline.numberOfLines = 1
        adView.headlineView = headline

        let sponsored = UILabel()
        sponsored.text = "Sponsored"
        sponsored.font = .systemFont(ofSize: 10)
        sponsored.textColor = .lightGray
        sponsored.numberOfLines = 1

        textStack.addArrangedSubview(headline)
        textStack.addArrangedSubview(sponsored)
        bottomRow.addArrangedSubview(textStack)

        let cta = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 30/255, green: 155/255, blue: 233/255, alpha: 1))
        cta.titleLabel?.font = .systemFont(ofSize: 12)
        cta.layer.cornerRadius = 4
        cta.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        cta.heightAnchor.constraint(equalToConstant: 34).isActive = true
        cta.setContentHuggingPriority(.required, for: .horizontal)
        adView.callToActionView = cta
        bottomRow.addArrangedSubview(cta)

        mainStack.addArrangedSubview(bottomRow)
    }
}

class NativeAdDesign5Dark {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        // Root background #121212
        adView.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        
        let mainStack = UIStackView()
        mainStack.axis = .horizontal
        mainStack.alignment = .center
        mainStack.spacing = 0
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        container.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            mainStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            mainStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            mainStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0)
        ])

        let iconContainer = UIView()
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        iconContainer.backgroundColor = UIColor(white: 0.25, alpha: 1)
        iconContainer.layer.cornerRadius = 24
        iconContainer.clipsToBounds = true
        iconContainer.widthAnchor.constraint(equalToConstant: 48).isActive = true
        iconContainer.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        let iconView = factory.createIconView(nativeAd, adView: adView)
        iconContainer.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: iconContainer.topAnchor, constant: 2),
            iconView.bottomAnchor.constraint(equalTo: iconContainer.bottomAnchor, constant: -2),
            iconView.leadingAnchor.constraint(equalTo: iconContainer.leadingAnchor, constant: 2),
            iconView.trailingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: -2)
        ])
        
        let iconWrapper = UIView()
        iconWrapper.addSubview(iconContainer)
        NSLayoutConstraint.activate([
            iconContainer.topAnchor.constraint(equalTo: iconWrapper.topAnchor),
            iconContainer.leadingAnchor.constraint(equalTo: iconWrapper.leadingAnchor),
            iconContainer.bottomAnchor.constraint(equalTo: iconWrapper.bottomAnchor),
            iconContainer.trailingAnchor.constraint(equalTo: iconWrapper.trailingAnchor, constant: -10)
        ])
        mainStack.addArrangedSubview(iconWrapper)

        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 2
        
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 14), color: .white)
        headline.numberOfLines = 1
        adView.headlineView = headline
        
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 12), color: .lightGray)
        body.numberOfLines = 2
        adView.bodyView = body
        
        textStack.addArrangedSubview(headline)
        textStack.addArrangedSubview(body)
        mainStack.addArrangedSubview(textStack)

        let ctaStack = UIStackView()
        ctaStack.axis = .vertical
        ctaStack.alignment = .trailing
        ctaStack.spacing = 6
        
        let adBadge = UILabel()
        adBadge.text = "Ad"
        adBadge.font = .boldSystemFont(ofSize: 10)
        adBadge.textColor = UIColor(red: 56/255, green: 142/255, blue: 60/255, alpha: 1)
        adBadge.layer.borderWidth = 1
        adBadge.layer.borderColor = adBadge.textColor.cgColor
        adBadge.layer.cornerRadius = 4
        adBadge.clipsToBounds = true
        adBadge.textAlignment = .center
        adBadge.translatesAutoresizingMaskIntoConstraints = false
        adBadge.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        let ctaButton = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 30/255, green: 155/255, blue: 233/255, alpha: 1))
        ctaButton.titleLabel?.font = .boldSystemFont(ofSize: 11)
        ctaButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        ctaButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        adView.callToActionView = ctaButton
        
        ctaStack.addArrangedSubview(adBadge)
        ctaStack.addArrangedSubview(ctaButton)
        mainStack.addArrangedSubview(ctaStack)
    }
}

class NativeAdDesign6Dark {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        // Root background #121212
        adView.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        
        // App Icon (60dp, alignParentEnd)
        let iconView = factory.createIconView(nativeAd, adView: adView)
        iconView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        container.addSubview(iconView)
        
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            iconView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12)
        ])

        // Text Container (Headline + Body, toStartOf icon)
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 4
        textStack.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(textStack)
        
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 17), color: .white)
        headline.numberOfLines = 1
        adView.headlineView = headline
        
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 13), color: UIColor(white: 0.7, alpha: 1))
        body.numberOfLines = 2
        adView.bodyView = body
        
        textStack.addArrangedSubview(headline)
        textStack.addArrangedSubview(body)
        
        NSLayoutConstraint.activate([
            textStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            textStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            textStack.trailingAnchor.constraint(equalTo: iconView.leadingAnchor, constant: -12)
        ])

        // CTA Button (Full width, below text_container)
        let ctaButton = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 30/255, green: 155/255, blue: 233/255, alpha: 1))
        ctaButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        adView.callToActionView = ctaButton
        container.addSubview(ctaButton)
        
        NSLayoutConstraint.activate([
            ctaButton.topAnchor.constraint(equalTo: textStack.bottomAnchor, constant: 20),
            ctaButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            ctaButton.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            ctaButton.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
}

class NativeAdDesign7Dark {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = UIColor(white: 0.05, alpha: 1)
        
        let mainStack = factory.createMainStack(container, padding: 0)
        mainStack.axis = .vertical
        mainStack.spacing = 0
        mainStack.backgroundColor = UIColor(white: 0.12, alpha: 1)
        mainStack.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        mainStack.isLayoutMarginsRelativeArrangement = true

        let topRow = UIStackView()
        topRow.axis = .horizontal
        topRow.alignment = .center
        topRow.spacing = 8
        
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 16), color: .white)
        headline.numberOfLines = 1
        adView.headlineView = headline
        
        let adBadge = UILabel()
        adBadge.text = "Ad"
        adBadge.font = .systemFont(ofSize: 10)
        adBadge.textColor = .white
        adBadge.backgroundColor = .gray
        adBadge.textAlignment = .center
        adBadge.translatesAutoresizingMaskIntoConstraints = false
        adBadge.widthAnchor.constraint(equalToConstant: 24).isActive = true
        adBadge.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        topRow.addArrangedSubview(headline)
        topRow.addArrangedSubview(adBadge)
        mainStack.addArrangedSubview(topRow)

        let media = factory.createMediaView(140, adView: adView)
        media.translatesAutoresizingMaskIntoConstraints = false
        media.heightAnchor.constraint(equalToConstant: 140).isActive = true
        adView.mediaView = media
        
        let mediaWrapper = UIView()
        mediaWrapper.addSubview(media)
        NSLayoutConstraint.activate([
            media.topAnchor.constraint(equalTo: mediaWrapper.topAnchor, constant: 8),
            media.leadingAnchor.constraint(equalTo: mediaWrapper.leadingAnchor),
            media.trailingAnchor.constraint(equalTo: mediaWrapper.trailingAnchor),
            media.bottomAnchor.constraint(equalTo: mediaWrapper.bottomAnchor)
        ])
        mainStack.addArrangedSubview(mediaWrapper)

        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 13), color: .lightGray)
        body.numberOfLines = 2
        adView.bodyView = body
        
        let bodyWrapper = UIView()
        bodyWrapper.addSubview(body)
        NSLayoutConstraint.activate([
            body.topAnchor.constraint(equalTo: bodyWrapper.topAnchor, constant: 6),
            body.leadingAnchor.constraint(equalTo: bodyWrapper.leadingAnchor),
            body.trailingAnchor.constraint(equalTo: bodyWrapper.trailingAnchor),
            body.bottomAnchor.constraint(equalTo: bodyWrapper.bottomAnchor)
        ])
        mainStack.addArrangedSubview(bodyWrapper)

        let ctaButton = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 103/255, green: 58/255, blue: 183/255, alpha: 1))
        ctaButton.titleLabel?.font = .systemFont(ofSize: 14)
        ctaButton.heightAnchor.constraint(equalToConstant: 42).isActive = true
        adView.callToActionView = ctaButton
        
        let ctaWrapper = UIView()
        ctaWrapper.addSubview(ctaButton)
        NSLayoutConstraint.activate([
            ctaButton.topAnchor.constraint(equalTo: ctaWrapper.topAnchor, constant: 10),
            ctaButton.leadingAnchor.constraint(equalTo: ctaWrapper.leadingAnchor),
            ctaButton.trailingAnchor.constraint(equalTo: ctaWrapper.trailingAnchor),
            ctaButton.bottomAnchor.constraint(equalTo: ctaWrapper.bottomAnchor)
        ])
        mainStack.addArrangedSubview(ctaWrapper)
    }
}

class NativeAdDesign8Dark {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = UIColor(white: 0.1, alpha: 1)
        
        let mainStack = factory.createMainStack(container, padding: 0)
        mainStack.axis = .vertical
        mainStack.spacing = 12
        mainStack.backgroundColor = UIColor(white: 0.16, alpha: 1)
        mainStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        mainStack.isLayoutMarginsRelativeArrangement = true

        let topRow = UIStackView()
        topRow.axis = .horizontal
        topRow.alignment = .center
        topRow.spacing = 12
        
        let iconView = factory.createIconView(nativeAd, adView: adView)
        iconView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 4
        
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 18), color: .white)
        headline.numberOfLines = 1
        adView.headlineView = headline
        
        let ratingLabel = UILabel()
        ratingLabel.text = "★★★★★"
        ratingLabel.textColor = .orange
        ratingLabel.font = .systemFont(ofSize: 12)
        
        textStack.addArrangedSubview(headline)
        textStack.addArrangedSubview(ratingLabel)
        
        topRow.addArrangedSubview(iconView)
        topRow.addArrangedSubview(textStack)
        mainStack.addArrangedSubview(topRow)

        let media = factory.createMediaView(200, adView: adView)
        adView.mediaView = media
        mainStack.addArrangedSubview(media)

        let ctaButton = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 255/255, green: 179/255, blue: 0/255, alpha: 1))
        ctaButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        ctaButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        adView.callToActionView = ctaButton
        mainStack.addArrangedSubview(ctaButton)
    }
}

class NativeAdDesign9Dark {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        // Root background #121212
        adView.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        
        // Inner Card View (Match XML background #1E1E1E)
        let cardView = UIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        cardView.layer.cornerRadius = 4
        cardView.clipsToBounds = true
        container.addSubview(cardView)
        
        // Root padding 12dp from XML
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            cardView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            cardView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            cardView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12)
        ])

        // Content padding 8dp from XML
        let mainStack = UIStackView()
        mainStack.axis = .horizontal
        mainStack.alignment = .center
        mainStack.spacing = 10
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8),
            mainStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            mainStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            mainStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8)
        ])
        
        // App Icon (60dp)
        let iconView = factory.createIconView(nativeAd, adView: adView)
        iconView.layer.cornerRadius = 30
        iconView.clipsToBounds = true
        iconView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        // Text Column
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 2
        
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 16), color: UIColor(red: 3/255, green: 169/255, blue: 244/255, alpha: 1))
        headline.numberOfLines = 1
        adView.headlineView = headline
        
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 12), color: UIColor(red: 176/255, green: 176/255, blue: 176/255, alpha: 1))
        body.numberOfLines = 2
        adView.bodyView = body
        
        let ratingLabel = UILabel()
        ratingLabel.text = "★★★★★"
        ratingLabel.textColor = .systemBlue
        ratingLabel.font = .systemFont(ofSize: 10)
        
        textStack.addArrangedSubview(headline)
        textStack.addArrangedSubview(body)
        textStack.addArrangedSubview(ratingLabel)
        
        // Headline #03A9F4, Body #B0B0B0 (match XML)
        
        // CTA Button (#03A9F4)
        let ctaButton = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 3/255, green: 169/255, blue: 244/255, alpha: 1))
        ctaButton.titleLabel?.font = .boldSystemFont(ofSize: 11)
        ctaButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        ctaButton.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        ctaButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
        ctaButton.widthAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
        adView.callToActionView = ctaButton
        
        mainStack.addArrangedSubview(iconView)
        mainStack.addArrangedSubview(textStack)
        mainStack.addArrangedSubview(ctaButton)
    }
}

final class NativeAdDesign10Dark {

    static func setup(
        _ container: UIView,
        _ adView: NativeAdView,
        nativeAd: NativeAd,
        factory: MyNativeAdFactory
    ) {

        adView.backgroundColor = UIColor(white: 0.10, alpha: 1)

        let mainStack = factory.createMainStack(container, padding: 0)
        mainStack.axis = .horizontal
        mainStack.spacing = 0
        mainStack.alignment = .center
        mainStack.backgroundColor = UIColor(white: 0.14, alpha: 1)
        mainStack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        mainStack.isLayoutMarginsRelativeArrangement = true

        // Media
        let mediaView = factory.createMediaView(140, adView: adView)
        mediaView.translatesAutoresizingMaskIntoConstraints = false
        mediaView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        adView.mediaView = mediaView

        // Info stack
        let infoStack = UIStackView()
        infoStack.axis = .vertical
        infoStack.spacing = 4
        infoStack.alignment = .center
        infoStack.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        infoStack.isLayoutMarginsRelativeArrangement = true

        let iconView = factory.createIconView(nativeAd, adView: adView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 60).isActive = true

        let headline = factory.createLabel(
            nativeAd.headline,
            font: .boldSystemFont(ofSize: 14),
            color: .white
        )
        headline.numberOfLines = 1
        headline.textAlignment = .center
        adView.headlineView = headline

        let body = factory.createLabel(
            nativeAd.body,
            font: .systemFont(ofSize: 11),
            color: .lightGray
        )
        body.numberOfLines = 2
        body.textAlignment = .center
        adView.bodyView = body

        let bottomRow = UIStackView()
        bottomRow.axis = .horizontal
        bottomRow.alignment = .center
        bottomRow.spacing = 8

        let adBadge = UILabel()
        adBadge.text = "AD"
        adBadge.font = .boldSystemFont(ofSize: 10)
        adBadge.textColor = .white
        adBadge.backgroundColor = UIColor(red: 211/255, green: 47/255, blue: 47/255, alpha: 1)
        adBadge.textAlignment = .center
        adBadge.layer.cornerRadius = 2
        adBadge.clipsToBounds = true
        adBadge.translatesAutoresizingMaskIntoConstraints = false
        adBadge.widthAnchor.constraint(equalToConstant: 24).isActive = true
        adBadge.heightAnchor.constraint(equalToConstant: 16).isActive = true

        let ctaButton = factory.createButton(
            nativeAd.callToAction,
            bgColor: UIColor(red: 211/255, green: 47/255, blue: 47/255, alpha: 1)
        )
        ctaButton.titleLabel?.font = .boldSystemFont(ofSize: 12)
        ctaButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        adView.callToActionView = ctaButton

        bottomRow.addArrangedSubview(adBadge)
        bottomRow.addArrangedSubview(ctaButton)

        infoStack.addArrangedSubview(iconView)
        infoStack.addArrangedSubview(headline)
        infoStack.addArrangedSubview(body)
        infoStack.addArrangedSubview(bottomRow)

        mainStack.addArrangedSubview(mediaView)
        mainStack.addArrangedSubview(infoStack)

        mediaView.widthAnchor.constraint(equalTo: infoStack.widthAnchor, multiplier: 1.3).isActive = true
    }
}
