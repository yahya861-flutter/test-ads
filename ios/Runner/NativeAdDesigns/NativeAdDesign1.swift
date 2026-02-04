import UIKit
import google_mobile_ads

class NativeAdDesign1 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = UIColor(red: 0.929, green: 0.937, blue: 0.949, alpha: 1) // #EDEFF2

        let mainStack = factory.createMainStack(container, padding: 12, spacing: 12)

        // Header
        let headerStack = UIStackView()
        headerStack.axis = .horizontal
        headerStack.distribution = .equalSpacing
        headerStack.alignment = .top // Top aligned as per Android RelativeLayout

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
        badgeLabel.textColor = UIColor(red: 0.22, green: 0.56, blue: 0.35, alpha: 1) // #388E3C
        badgeLabel.layer.borderWidth = 1
        badgeLabel.layer.borderColor = badgeLabel.textColor.cgColor
        badgeLabel.layer.cornerRadius = 4
        badgeLabel.clipsToBounds = true
        badgeLabel.textAlignment = .center
        badgeLabel.widthAnchor.constraint(equalToConstant: 24).isActive = true
        badgeLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
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

        // CTA
        let ctaButton = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 233/255, green: 30/255, blue: 99/255, alpha: 1)) // #E91E63 Pink
        ctaButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        adView.callToActionView = ctaButton
        mainStack.addArrangedSubview(ctaButton)
    }
}

class NativeAdDesign1Dark {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1) // #1A1A1A or similar
        let mainStack = factory.createMainStack(container, padding: 12, spacing: 12)
        
        // Header
        let headerStack = UIStackView()
        headerStack.axis = .horizontal
        headerStack.distribution = .equalSpacing
        headerStack.alignment = .top // Top aligned
        
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
        badgeLabel.textColor = UIColor(red: 0.22, green: 0.56, blue: 0.35, alpha: 1) // #388E3C
        badgeLabel.layer.borderWidth = 1
        badgeLabel.layer.borderColor = badgeLabel.textColor.cgColor
        badgeLabel.layer.cornerRadius = 4
        badgeLabel.clipsToBounds = true
        badgeLabel.textAlignment = .center
        badgeLabel.widthAnchor.constraint(equalToConstant: 24).isActive = true
        badgeLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        rightStack.addArrangedSubview(badgeLabel)
        
        let advertiserLabel = factory.createLabel(nativeAd.advertiser, font: .systemFont(ofSize: 12), color: .lightGray)
        adView.advertiserView = advertiserLabel
        rightStack.addArrangedSubview(advertiserLabel)
        
        headerStack.addArrangedSubview(leftStack)
        headerStack.addArrangedSubview(rightStack)
        mainStack.addArrangedSubview(headerStack)
        
        let mediaView = factory.createMediaView(120, adView: adView)
        mainStack.addArrangedSubview(mediaView)
        
        // CTA
        let ctaButton = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 233/255, green: 30/255, blue: 99/255, alpha: 1)) // #E91E63 Pink
        ctaButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        adView.callToActionView = ctaButton
        mainStack.addArrangedSubview(ctaButton)
    }
}
