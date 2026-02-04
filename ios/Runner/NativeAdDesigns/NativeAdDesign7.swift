import UIKit
import google_mobile_ads

class NativeAdDesign7 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = UIColor(red: 248/255, green: 250/255, blue: 252/255, alpha: 1) // #F8FAFC

        let mainStack = factory.createMainStack(container, padding: 16)
        mainStack.axis = .vertical
        mainStack.spacing = 10
        
        // 1. Top Header Row
        let topRow = UIStackView()
        topRow.axis = .horizontal
        topRow.alignment = .center
        topRow.spacing = 12
        
        // Icon
        let icon = factory.createIconView(nativeAd, adView: adView)
        icon.widthAnchor.constraint(equalToConstant: 45).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 45).isActive = true
        icon.layer.cornerRadius = 8
        icon.clipsToBounds = true
        topRow.addArrangedSubview(icon)
        
        // Text Pillar
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 2
        
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 18), color: UIColor(red: 17/255, green: 24/255, blue: 39/255, alpha: 1))
        adView.headlineView = headline
        textStack.addArrangedSubview(headline)
        
        let badgeBodyRow = UIStackView()
        badgeBodyRow.axis = .horizontal
        badgeBodyRow.alignment = .center
        badgeBodyRow.spacing = 10
        
        let badge = UILabel()
        badge.text = "Ad"
        badge.font = .boldSystemFont(ofSize: 12)
        badge.textColor = .white
        badge.backgroundColor = UIColor(red: 255/255, green: 92/255, blue: 77/255, alpha: 1) // #FF5C4D
        badge.layer.cornerRadius = 4
        badge.clipsToBounds = true
        badge.textAlignment = .center
        badge.widthAnchor.constraint(equalToConstant: 30).isActive = true
        badge.heightAnchor.constraint(equalToConstant: 22).isActive = true
        badgeBodyRow.addArrangedSubview(badge)
        
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 14), color: UIColor(red: 75/255, green: 85/255, blue: 99/255, alpha: 1), lines: 2)
        adView.bodyView = body
        badgeBodyRow.addArrangedSubview(body)
        
        textStack.addArrangedSubview(badgeBodyRow)
        topRow.addArrangedSubview(textStack)
        mainStack.addArrangedSubview(topRow)
        
        // 2. Central Media View
        let media = factory.createMediaView(180, adView: adView)
        media.heightAnchor.constraint(equalToConstant: 180).isActive = true
        media.layer.cornerRadius = 16
        media.clipsToBounds = true
        
        let mediaWrapper = UIView()
        mediaWrapper.addSubview(media)
        media.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            media.topAnchor.constraint(equalTo: mediaWrapper.topAnchor, constant: 12),
            media.leadingAnchor.constraint(equalTo: mediaWrapper.leadingAnchor),
            media.trailingAnchor.constraint(equalTo: mediaWrapper.trailingAnchor),
            media.bottomAnchor.constraint(equalTo: mediaWrapper.bottomAnchor)
        ])
        mainStack.addArrangedSubview(mediaWrapper)

        // 3. Bottom CTA Button
        let cta = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 255/255, green: 92/255, blue: 77/255, alpha: 1))
        cta.titleLabel?.font = .boldSystemFont(ofSize: 20)
        cta.setTitleColor(.white, for: .normal)
        cta.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cta.layer.cornerRadius = 10
        adView.callToActionView = cta
        mainStack.addArrangedSubview(cta)
    }
}

class NativeAdDesign7Dark {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = UIColor(red: 15/255, green: 23/255, blue: 30/255, alpha: 1) // #0F171E

        let mainStack = factory.createMainStack(container, padding: 16)
        mainStack.axis = .vertical
        mainStack.spacing = 10
        
        // 1. Top Header Row
        let topRow = UIStackView()
        topRow.axis = .horizontal
        topRow.alignment = .center
        topRow.spacing = 12
        
        let icon = factory.createIconView(nativeAd, adView: adView)
        icon.widthAnchor.constraint(equalToConstant: 45).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 45).isActive = true
        icon.layer.cornerRadius = 8
        icon.clipsToBounds = true
        topRow.addArrangedSubview(icon)
        
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 2
        
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 18), color: .white)
        adView.headlineView = headline
        textStack.addArrangedSubview(headline)
        
        let badgeBodyRow = UIStackView()
        badgeBodyRow.axis = .horizontal
        badgeBodyRow.alignment = .center
        badgeBodyRow.spacing = 10
        
        let badge = UILabel()
        badge.text = "Ad"
        badge.font = .boldSystemFont(ofSize: 12)
        badge.textColor = .white
        badge.backgroundColor = UIColor(red: 255/255, green: 92/255, blue: 77/255, alpha: 1)
        badge.layer.cornerRadius = 4
        badge.clipsToBounds = true
        badge.textAlignment = .center
        badge.widthAnchor.constraint(equalToConstant: 30).isActive = true
        badge.heightAnchor.constraint(equalToConstant: 22).isActive = true
        badgeBodyRow.addArrangedSubview(badge)
        
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 14), color: UIColor(white: 0.7, alpha: 1), lines: 2)
        adView.bodyView = body
        badgeBodyRow.addArrangedSubview(body)
        
        textStack.addArrangedSubview(badgeBodyRow)
        topRow.addArrangedSubview(textStack)
        mainStack.addArrangedSubview(topRow)
        
        // 2. Central Media View
        let media = factory.createMediaView(180, adView: adView)
        media.heightAnchor.constraint(equalToConstant: 180).isActive = true
        media.layer.cornerRadius = 16
        media.clipsToBounds = true
        
        let mediaWrapper = UIView()
        mediaWrapper.addSubview(media)
        media.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            media.topAnchor.constraint(equalTo: mediaWrapper.topAnchor, constant: 12),
            media.leadingAnchor.constraint(equalTo: mediaWrapper.leadingAnchor),
            media.trailingAnchor.constraint(equalTo: mediaWrapper.trailingAnchor),
            media.bottomAnchor.constraint(equalTo: mediaWrapper.bottomAnchor)
        ])
        mainStack.addArrangedSubview(mediaWrapper)

        // 3. Bottom CTA Button
        let cta = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 255/255, green: 92/255, blue: 77/255, alpha: 1))
        cta.titleLabel?.font = .boldSystemFont(ofSize: 20)
        cta.setTitleColor(.white, for: .normal)
        cta.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cta.layer.cornerRadius = 10
        adView.callToActionView = cta
        mainStack.addArrangedSubview(cta)
    }
}
