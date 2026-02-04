import UIKit
import google_mobile_ads

class NativeAdDesign2 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = .white

        let verticalStack = factory.createMainStack(container, padding: 0, spacing: 0)

        // Top Divider
        let topDivider = UIView()
        topDivider.backgroundColor = .black
        topDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        verticalStack.addArrangedSubview(topDivider)

        // Horizontal Row
        let rowStack = UIStackView()
        rowStack.axis = .horizontal
        rowStack.alignment = .top
        rowStack.spacing = 0
        rowStack.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 12)
        rowStack.isLayoutMarginsRelativeArrangement = true

        // 1. AD Badge
        let badgeLabel = UILabel()
        badgeLabel.text = "AD"
        badgeLabel.font = .boldSystemFont(ofSize: 10)
        badgeLabel.textColor = .white
        badgeLabel.backgroundColor = .black
        badgeLabel.layer.cornerRadius = 2
        badgeLabel.clipsToBounds = true
        badgeLabel.textAlignment = .center
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
        badgeLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        rowStack.addArrangedSubview(badgeLabel)

        // 2. Media View (120x120)
        let media = factory.createMediaView(120, adView: adView)
        media.widthAnchor.constraint(equalToConstant: 120).isActive = true
        media.heightAnchor.constraint(equalToConstant: 120).isActive = true
        media.layer.cornerRadius = 0
        
        let mediaWrapper = UIView()
        mediaWrapper.addSubview(media)
        mediaWrapper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            media.topAnchor.constraint(equalTo: mediaWrapper.topAnchor, constant: 10),
            media.leadingAnchor.constraint(equalTo: mediaWrapper.leadingAnchor),
            media.trailingAnchor.constraint(equalTo: mediaWrapper.trailingAnchor, constant: -10),
            media.bottomAnchor.constraint(equalTo: mediaWrapper.bottomAnchor, constant: -5)
        ])
        rowStack.addArrangedSubview(mediaWrapper)

        // 3. Text + Button Pillar
        let pillarStack = UIStackView()
        pillarStack.axis = .vertical
        pillarStack.alignment = .center
        pillarStack.spacing = 2

        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 16), color: .black)
        adView.headlineView = headline
        headline.textAlignment = .center
        
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 14), color: .black, lines: 2)
        adView.bodyView = body
        body.textAlignment = .center

        let cta = factory.createButton(nativeAd.callToAction, bgColor: .black)
        cta.titleLabel?.font = .boldSystemFont(ofSize: 14)
        cta.setTitleColor(.white, for: .normal)
        cta.widthAnchor.constraint(equalToConstant: 120).isActive = true
        cta.heightAnchor.constraint(equalToConstant: 36).isActive = true
        cta.layer.cornerRadius = 18 // Pill
        adView.callToActionView = cta

        let spacer1 = UIView()
        spacer1.heightAnchor.constraint(equalToConstant: 10).isActive = true
        let spacer2 = UIView()
        spacer2.heightAnchor.constraint(equalToConstant: 25).isActive = true

        pillarStack.addArrangedSubview(spacer1)
        pillarStack.addArrangedSubview(headline)
        pillarStack.addArrangedSubview(body)
        pillarStack.addArrangedSubview(spacer2)
        pillarStack.addArrangedSubview(cta)

        pillarStack.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        rowStack.addArrangedSubview(pillarStack)
        verticalStack.addArrangedSubview(rowStack)

        // Bottom Divider
        let bottomDivider = UIView()
        bottomDivider.backgroundColor = .black
        bottomDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        verticalStack.addArrangedSubview(bottomDivider)
    }
}

class NativeAdDesign2Dark {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1) // #121212

        let verticalStack = factory.createMainStack(container, padding: 0, spacing: 0)

        // Top Divider
        let topDivider = UIView()
        topDivider.backgroundColor = UIColor(white: 0.27, alpha: 1) // #444444
        topDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        verticalStack.addArrangedSubview(topDivider)

        // Horizontal Row
        let rowStack = UIStackView()
        rowStack.axis = .horizontal
        rowStack.alignment = .top
        rowStack.spacing = 0
        rowStack.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 12)
        rowStack.isLayoutMarginsRelativeArrangement = true

        // 1. AD Badge
        let badgeLabel = UILabel()
        badgeLabel.text = "AD"
        badgeLabel.font = .boldSystemFont(ofSize: 10)
        badgeLabel.textColor = .white
        badgeLabel.backgroundColor = .gray
        badgeLabel.layer.cornerRadius = 2
        badgeLabel.clipsToBounds = true
        badgeLabel.textAlignment = .center
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
        badgeLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        rowStack.addArrangedSubview(badgeLabel)

        // 2. Media View (120x120)
        let media = factory.createMediaView(120, adView: adView)
        media.widthAnchor.constraint(equalToConstant: 120).isActive = true
        media.heightAnchor.constraint(equalToConstant: 120).isActive = true
        media.layer.cornerRadius = 0
        
        let mediaWrapper = UIView()
        mediaWrapper.addSubview(media)
        mediaWrapper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            media.topAnchor.constraint(equalTo: mediaWrapper.topAnchor, constant: 10),
            media.leadingAnchor.constraint(equalTo: mediaWrapper.leadingAnchor),
            media.trailingAnchor.constraint(equalTo: mediaWrapper.trailingAnchor, constant: -10),
            media.bottomAnchor.constraint(equalTo: mediaWrapper.bottomAnchor, constant: -5)
        ])
        rowStack.addArrangedSubview(mediaWrapper)

        // 3. Text + Button Pillar
        let pillarStack = UIStackView()
        pillarStack.axis = .vertical
        pillarStack.alignment = .center
        pillarStack.spacing = 2

        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 16), color: .white)
        adView.headlineView = headline
        headline.textAlignment = .center
        
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 14), color: .white, lines: 2)
        adView.bodyView = body
        body.textAlignment = .center

        let cta = factory.createButton(nativeAd.callToAction, bgColor: .white)
        cta.titleLabel?.font = .boldSystemFont(ofSize: 14)
        cta.setTitleColor(.black, for: .normal)
        cta.widthAnchor.constraint(equalToConstant: 120).isActive = true
        cta.heightAnchor.constraint(equalToConstant: 36).isActive = true
        cta.layer.cornerRadius = 18 // Pill
        adView.callToActionView = cta

        let spacer1 = UIView()
        spacer1.heightAnchor.constraint(equalToConstant: 10).isActive = true
        let spacer2 = UIView()
        spacer2.heightAnchor.constraint(equalToConstant: 25).isActive = true

        pillarStack.addArrangedSubview(spacer1)
        pillarStack.addArrangedSubview(headline)
        pillarStack.addArrangedSubview(body)
        pillarStack.addArrangedSubview(spacer2)
        pillarStack.addArrangedSubview(cta)

        pillarStack.setContentHuggingPriority(.defaultLow, for: .horizontal)

        rowStack.addArrangedSubview(pillarStack)
        verticalStack.addArrangedSubview(rowStack)

        // Bottom Divider
        let bottomDivider = UIView()
        bottomDivider.backgroundColor = UIColor(white: 0.27, alpha: 1) // #444444
        bottomDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        verticalStack.addArrangedSubview(bottomDivider)
    }
}
