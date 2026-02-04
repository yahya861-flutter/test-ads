import UIKit
import google_mobile_ads

class NativeAdDesign4 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        // Outer context background #F3F3F3
        adView.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)

        let mainStack = factory.createMainStack(container, padding: 12)
        mainStack.axis = .vertical
        mainStack.spacing = 0
        mainStack.backgroundColor = .white
        
        // 1. Media View (200dp)
        let media = factory.createMediaView(200, adView: adView)
        media.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let mediaWrapper = UIView()
        mediaWrapper.addSubview(media)
        media.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            media.topAnchor.constraint(equalTo: mediaWrapper.topAnchor),
            media.leadingAnchor.constraint(equalTo: mediaWrapper.leadingAnchor),
            media.trailingAnchor.constraint(equalTo: mediaWrapper.trailingAnchor),
            media.bottomAnchor.constraint(equalTo: mediaWrapper.bottomAnchor, constant: -12)
        ])
        mainStack.addArrangedSubview(mediaWrapper)

        // 2. App Info Row
        let infoRow = UIStackView()
        infoRow.axis = .horizontal
        infoRow.alignment = .center
        infoRow.spacing = 12
        infoRow.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        infoRow.isLayoutMarginsRelativeArrangement = true

        let icon = factory.createIconView(nativeAd, adView: adView)
        icon.widthAnchor.constraint(equalToConstant: 60).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 60).isActive = true
        icon.layer.cornerRadius = 4
        icon.clipsToBounds = true
        infoRow.addArrangedSubview(icon)

        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 4

        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 18), color: .black)
        adView.headlineView = headline
        textStack.addArrangedSubview(headline)

        let badgeBodyRow = UIStackView()
        badgeBodyRow.axis = .horizontal
        badgeBodyRow.alignment = .center
        badgeBodyRow.spacing = 8

        let badgeLabel = UILabel()
        badgeLabel.text = "AD"
        badgeLabel.font = .boldSystemFont(ofSize: 10)
        badgeLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1) // #333333
        badgeLabel.backgroundColor = UIColor(red: 1, green: 177/255, blue: 0, alpha: 1) // #FFB100
        badgeLabel.layer.cornerRadius = 4
        badgeLabel.clipsToBounds = true
        badgeLabel.textAlignment = .center
        badgeLabel.widthAnchor.constraint(equalToConstant: 24).isActive = true
        badgeLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        badgeBodyRow.addArrangedSubview(badgeLabel)

        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 14), color: .black, lines: 2)
        adView.bodyView = body
        badgeBodyRow.addArrangedSubview(body)

        textStack.addArrangedSubview(badgeBodyRow)
        infoRow.addArrangedSubview(textStack)
        mainStack.addArrangedSubview(infoRow)

        // 3. CTA Button (Yellow Pill)
        let cta = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 1, green: 177/255, blue: 0, alpha: 1))
        cta.titleLabel?.font = .boldSystemFont(ofSize: 20)
        cta.setTitleColor(.white, for: .normal)
        cta.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cta.layer.cornerRadius = 25
        adView.callToActionView = cta
        mainStack.addArrangedSubview(cta)
    }
}

class NativeAdDesign4Dark {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = .black

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

        // Top Divider
        let topDivider = UIView()
        topDivider.backgroundColor = .white
        topDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        mainStack.addArrangedSubview(topDivider)

        let contentStack = UIStackView()
        contentStack.axis = .vertical
        contentStack.spacing = 0
        contentStack.backgroundColor = UIColor(white: 0.2, alpha: 1) // #333333
        contentStack.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        contentStack.isLayoutMarginsRelativeArrangement = true
        
        // 1. Media View
        let media = factory.createMediaView(200, adView: adView)
        media.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let mediaWrapper = UIView()
        mediaWrapper.addSubview(media)
        media.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            media.topAnchor.constraint(equalTo: mediaWrapper.topAnchor),
            media.leadingAnchor.constraint(equalTo: mediaWrapper.leadingAnchor),
            media.trailingAnchor.constraint(equalTo: mediaWrapper.trailingAnchor),
            media.bottomAnchor.constraint(equalTo: mediaWrapper.bottomAnchor, constant: -12)
        ])
        contentStack.addArrangedSubview(mediaWrapper)

        // 2. App Info Row
        let infoRow = UIStackView()
        infoRow.axis = .horizontal
        infoRow.alignment = .center
        infoRow.spacing = 12
        infoRow.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        infoRow.isLayoutMarginsRelativeArrangement = true

        let icon = factory.createIconView(nativeAd, adView: adView)
        icon.widthAnchor.constraint(equalToConstant: 60).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 60).isActive = true
        icon.layer.cornerRadius = 4
        icon.clipsToBounds = true
        infoRow.addArrangedSubview(icon)

        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 4

        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 18), color: .white)
        adView.headlineView = headline
        textStack.addArrangedSubview(headline)

        let badgeBodyRow = UIStackView()
        badgeBodyRow.axis = .horizontal
        badgeBodyRow.alignment = .center
        badgeBodyRow.spacing = 8

        let badgeLabel = UILabel()
        badgeLabel.text = "AD"
        badgeLabel.font = .boldSystemFont(ofSize: 10)
        badgeLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        badgeLabel.backgroundColor = UIColor(red: 1, green: 177/255, blue: 0, alpha: 1)
        badgeLabel.layer.cornerRadius = 4
        badgeLabel.clipsToBounds = true
        badgeLabel.textAlignment = .center
        badgeLabel.widthAnchor.constraint(equalToConstant: 24).isActive = true
        badgeLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        badgeBodyRow.addArrangedSubview(badgeLabel)

        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 14), color: .white, lines: 2)
        adView.bodyView = body
        badgeBodyRow.addArrangedSubview(body)

        textStack.addArrangedSubview(badgeBodyRow)
        infoRow.addArrangedSubview(textStack)
        contentStack.addArrangedSubview(infoRow)

        // 3. CTA Button
        let cta = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 1, green: 177/255, blue: 0, alpha: 1))
        cta.titleLabel?.font = .boldSystemFont(ofSize: 20)
        cta.setTitleColor(.white, for: .normal)
        cta.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cta.layer.cornerRadius = 25
        adView.callToActionView = cta
        contentStack.addArrangedSubview(cta)

        mainStack.addArrangedSubview(contentStack)

        // Bottom Divider
        let bottomDivider = UIView()
        bottomDivider.backgroundColor = .white
        bottomDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        mainStack.addArrangedSubview(bottomDivider)
    }
}
