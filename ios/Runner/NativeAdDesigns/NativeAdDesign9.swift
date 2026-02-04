import UIKit
import google_mobile_ads

class NativeAdDesign9 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = .white

        let mainStack = factory.createMainStack(container, padding: 0)
        mainStack.axis = .vertical
        mainStack.spacing = 0
        
        // 1. Badge Row
        let badge = UILabel()
        badge.text = "Ad"
        badge.font = .boldSystemFont(ofSize: 11)
        badge.textColor = .white
        badge.backgroundColor = .black
        badge.textAlignment = .center
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.widthAnchor.constraint(equalToConstant: 30).isActive = true
        badge.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let badgeRow = UIStackView()
        badgeRow.axis = .horizontal
        badgeRow.addArrangedSubview(badge)
        badgeRow.addArrangedSubview(UIView()) // Spacer
        mainStack.addArrangedSubview(badgeRow)

        // 2. Header Row
        let headerRow = UIStackView()
        headerRow.axis = .horizontal
        headerRow.alignment = .center
        headerRow.spacing = 12
        headerRow.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        headerRow.isLayoutMarginsRelativeArrangement = true
        
        let icon = factory.createIconView(nativeAd, adView: adView)
        icon.widthAnchor.constraint(equalToConstant: 60).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 60).isActive = true
        icon.backgroundColor = UIColor(red: 243/255, green: 244/255, blue: 246/255, alpha: 1) // #F3F4F6
        headerRow.addArrangedSubview(icon)
        
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 2
        
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 18), color: UIColor(red: 17/255, green: 24/255, blue: 39/255, alpha: 1))
        adView.headlineView = headline
        textStack.addArrangedSubview(headline)
        
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 14), color: UIColor(red: 75/255, green: 85/255, blue: 99/255, alpha: 1), lines: 1)
        adView.bodyView = body
        textStack.addArrangedSubview(body)
        
        headerRow.addArrangedSubview(textStack)
        mainStack.addArrangedSubview(headerRow)

        // 3. Media View
        let media = factory.createMediaView(180, adView: adView)
        media.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        let mediaWrapper = UIStackView()
        mediaWrapper.axis = .horizontal
        mediaWrapper.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        mediaWrapper.isLayoutMarginsRelativeArrangement = true
        mediaWrapper.addArrangedSubview(media)
        mainStack.addArrangedSubview(mediaWrapper)

        // 4. CTA Button
        let cta = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 29/255, green: 185/255, blue: 84/255, alpha: 1)) // #1DB954
        cta.titleLabel?.font = .boldSystemFont(ofSize: 18)
        cta.setTitleColor(.white, for: .normal)
        cta.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cta.layer.cornerRadius = 8
        adView.callToActionView = cta
        
        let ctaWrapper = UIStackView()
        ctaWrapper.axis = .horizontal
        ctaWrapper.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        ctaWrapper.isLayoutMarginsRelativeArrangement = true
        ctaWrapper.addArrangedSubview(cta)
        mainStack.addArrangedSubview(ctaWrapper)
    }
}

class NativeAdDesign9Dark {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = UIColor(red: 15/255, green: 23/255, blue: 30/255, alpha: 1) // #0F171E

        let mainStack = factory.createMainStack(container, padding: 0)
        mainStack.axis = .vertical
        mainStack.spacing = 0
        
        // 1. Badge Row
        let badge = UILabel()
        badge.text = "Ad"
        badge.font = .boldSystemFont(ofSize: 11)
        badge.textColor = .white
        badge.backgroundColor = .black
        badge.textAlignment = .center
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.widthAnchor.constraint(equalToConstant: 30).isActive = true
        badge.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let badgeRow = UIStackView()
        badgeRow.axis = .horizontal
        badgeRow.addArrangedSubview(badge)
        badgeRow.addArrangedSubview(UIView())
        mainStack.addArrangedSubview(badgeRow)

        // 2. Header Row
        let headerRow = UIStackView()
        headerRow.axis = .horizontal
        headerRow.alignment = .center
        headerRow.spacing = 12
        headerRow.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        headerRow.isLayoutMarginsRelativeArrangement = true
        
        let icon = factory.createIconView(nativeAd, adView: adView)
        icon.widthAnchor.constraint(equalToConstant: 60).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 60).isActive = true
        icon.backgroundColor = UIColor(white: 0.1, alpha: 1)
        headerRow.addArrangedSubview(icon)
        
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 2
        
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 18), color: .white)
        adView.headlineView = headline
        textStack.addArrangedSubview(headline)
        
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 14), color: UIColor(white: 0.7, alpha: 1), lines: 1)
        adView.bodyView = body
        textStack.addArrangedSubview(body)
        
        headerRow.addArrangedSubview(textStack)
        mainStack.addArrangedSubview(headerRow)

        // 3. Media View
        let media = factory.createMediaView(180, adView: adView)
        media.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        let mediaWrapper = UIStackView()
        mediaWrapper.axis = .horizontal
        mediaWrapper.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        mediaWrapper.isLayoutMarginsRelativeArrangement = true
        mediaWrapper.addArrangedSubview(media)
        mainStack.addArrangedSubview(mediaWrapper)

        // 4. CTA Button
        let cta = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 29/255, green: 185/255, blue: 84/255, alpha: 1))
        cta.titleLabel?.font = .boldSystemFont(ofSize: 18)
        cta.setTitleColor(.white, for: .normal)
        cta.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cta.layer.cornerRadius = 8
        adView.callToActionView = cta
        
        let ctaWrapper = UIStackView()
        ctaWrapper.axis = .horizontal
        ctaWrapper.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        ctaWrapper.isLayoutMarginsRelativeArrangement = true
        ctaWrapper.addArrangedSubview(cta)
        mainStack.addArrangedSubview(ctaWrapper)
    }
}
