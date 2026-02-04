import UIKit
import google_mobile_ads

class NativeAdDesign8 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = .white

        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 0
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: container.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])

        // 1. Top-Left Badge
        let badge = UILabel()
        badge.text = "Ad"
        badge.font = .boldSystemFont(ofSize: 12)
        badge.textColor = .white
        badge.backgroundColor = UIColor(red: 30/255, green: 155/255, blue: 233/255, alpha: 1) // #1E9BE9
        badge.layer.cornerRadius = 8
        badge.layer.maskedCorners = [.layerMinXMinYCorner] // Top-left only
        badge.clipsToBounds = true
        badge.textAlignment = .center
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.widthAnchor.constraint(equalToConstant: 36).isActive = true
        badge.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        let badgeWrapper = UIView()
        badgeWrapper.addSubview(badge)
        NSLayoutConstraint.activate([
            badge.topAnchor.constraint(equalTo: badgeWrapper.topAnchor),
            badge.leadingAnchor.constraint(equalTo: badgeWrapper.leadingAnchor),
            badge.bottomAnchor.constraint(equalTo: badgeWrapper.bottomAnchor),
            badge.trailingAnchor.constraint(lessThanOrEqualTo: badgeWrapper.trailingAnchor)
        ])
        mainStack.addArrangedSubview(badgeWrapper)

        // 2. Icon + Text Row
        let midRow = UIStackView()
        midRow.axis = .horizontal
        midRow.alignment = .center
        midRow.spacing = 12
        midRow.layoutMargins = UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15)
        midRow.isLayoutMarginsRelativeArrangement = true
        
        let icon = factory.createIconView(nativeAd, adView: adView)
        icon.widthAnchor.constraint(equalToConstant: 60).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 60).isActive = true
        midRow.addArrangedSubview(icon)
        
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 2
        
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 18), color: UIColor(red: 17/255, green: 24/255, blue: 39/255, alpha: 1))
        adView.headlineView = headline
        textStack.addArrangedSubview(headline)
        
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 14), color: UIColor(red: 75/255, green: 85/255, blue: 99/255, alpha: 1), lines: 1)
        adView.bodyView = body
        textStack.addArrangedSubview(body)
        
        midRow.addArrangedSubview(textStack)
        mainStack.addArrangedSubview(midRow)

        // 3. Media View
        let media = factory.createMediaView(180, adView: adView)
        media.heightAnchor.constraint(equalToConstant: 180).isActive = true
        media.widthAnchor.constraint(equalToConstant: 320).isActive = true
        media.layer.cornerRadius = 16
        media.clipsToBounds = true
        
        let mediaWrapper = UIView()
        mediaWrapper.addSubview(media)
        media.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            media.topAnchor.constraint(equalTo: mediaWrapper.topAnchor, constant: 12),
            media.centerXAnchor.constraint(equalTo: mediaWrapper.centerXAnchor),
            media.bottomAnchor.constraint(equalTo: mediaWrapper.bottomAnchor)
        ])
        mainStack.addArrangedSubview(mediaWrapper)

        // 4. CTA Button
        let cta = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 30/255, green: 155/255, blue: 233/255, alpha: 1))
        cta.titleLabel?.font = .boldSystemFont(ofSize: 20)
        cta.setTitleColor(.white, for: .normal)
        cta.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cta.layer.cornerRadius = 25
        adView.callToActionView = cta
        
        let ctaWrapper = UIView()
        ctaWrapper.addSubview(cta)
        cta.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cta.topAnchor.constraint(equalTo: ctaWrapper.topAnchor, constant: 12),
            cta.leadingAnchor.constraint(equalTo: ctaWrapper.leadingAnchor, constant: 40),
            cta.trailingAnchor.constraint(equalTo: ctaWrapper.trailingAnchor, constant: -40),
            cta.bottomAnchor.constraint(equalTo: ctaWrapper.bottomAnchor)
        ])
        mainStack.addArrangedSubview(ctaWrapper)
    }
}

class NativeAdDesign8Dark {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = UIColor(red: 15/255, green: 23/255, blue: 30/255, alpha: 1) // #0F171E

        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 0
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: container.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])

        // 1. Top-Left Badge
        let badge = UILabel()
        badge.text = "Ad"
        badge.font = .boldSystemFont(ofSize: 12)
        badge.textColor = .white
        badge.backgroundColor = UIColor(red: 30/255, green: 155/255, blue: 233/255, alpha: 1)
        badge.layer.cornerRadius = 8
        badge.layer.maskedCorners = [.layerMinXMinYCorner]
        badge.clipsToBounds = true
        badge.textAlignment = .center
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.widthAnchor.constraint(equalToConstant: 36).isActive = true
        badge.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        let badgeWrapper = UIView()
        badgeWrapper.addSubview(badge)
        NSLayoutConstraint.activate([
            badge.topAnchor.constraint(equalTo: badgeWrapper.topAnchor),
            badge.leadingAnchor.constraint(equalTo: badgeWrapper.leadingAnchor),
            badge.bottomAnchor.constraint(equalTo: badgeWrapper.bottomAnchor),
            badge.trailingAnchor.constraint(lessThanOrEqualTo: badgeWrapper.trailingAnchor)
        ])
        mainStack.addArrangedSubview(badgeWrapper)

        // 2. Icon + Text Row
        let midRow = UIStackView()
        midRow.axis = .horizontal
        midRow.alignment = .center
        midRow.spacing = 12
        midRow.layoutMargins = UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15)
        midRow.isLayoutMarginsRelativeArrangement = true
        
        let icon = factory.createIconView(nativeAd, adView: adView)
        icon.widthAnchor.constraint(equalToConstant: 60).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 60).isActive = true
        midRow.addArrangedSubview(icon)
        
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 2
        
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 18), color: .white)
        adView.headlineView = headline
        textStack.addArrangedSubview(headline)
        
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 14), color: UIColor(white: 0.7, alpha: 1), lines: 1)
        adView.bodyView = body
        textStack.addArrangedSubview(body)
        
        midRow.addArrangedSubview(textStack)
        mainStack.addArrangedSubview(midRow)

        // 3. Media View
        let media = factory.createMediaView(180, adView: adView)
        media.heightAnchor.constraint(equalToConstant: 180).isActive = true
        media.widthAnchor.constraint(equalToConstant: 320).isActive = true
        media.layer.cornerRadius = 16
        media.clipsToBounds = true
        
        let mediaWrapper = UIView()
        mediaWrapper.addSubview(media)
        media.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            media.topAnchor.constraint(equalTo: mediaWrapper.topAnchor, constant: 12),
            media.centerXAnchor.constraint(equalTo: mediaWrapper.centerXAnchor),
            media.bottomAnchor.constraint(equalTo: mediaWrapper.bottomAnchor)
        ])
        mainStack.addArrangedSubview(mediaWrapper)

        // 4. CTA Button
        let cta = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 30/255, green: 155/255, blue: 233/255, alpha: 1))
        cta.titleLabel?.font = .boldSystemFont(ofSize: 20)
        cta.setTitleColor(.white, for: .normal)
        cta.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cta.layer.cornerRadius = 25
        adView.callToActionView = cta
        
        let ctaWrapper = UIView()
        ctaWrapper.addSubview(cta)
        cta.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cta.topAnchor.constraint(equalTo: ctaWrapper.topAnchor, constant: 12),
            cta.leadingAnchor.constraint(equalTo: ctaWrapper.leadingAnchor, constant: 40),
            cta.trailingAnchor.constraint(equalTo: ctaWrapper.trailingAnchor, constant: -40),
            cta.bottomAnchor.constraint(equalTo: ctaWrapper.bottomAnchor)
        ])
        mainStack.addArrangedSubview(ctaWrapper)
    }
}
