import UIKit
import google_mobile_ads

class NativeAdDesign3 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = .white

        let verticalStack = factory.createMainStack(container, padding: 0, spacing: 0)

        // Top Divider
        let topDivider = UIView()
        topDivider.backgroundColor = .black
        topDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        verticalStack.addArrangedSubview(topDivider)

        // Overlapping Relative Context using a Container
        let contentContainer = UIView()
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.addArrangedSubview(contentContainer)

        // 1. AD Badge (Top-Left Overlap)
        let badgeLabel = UILabel()
        badgeLabel.text = "Ad"
        badgeLabel.font = .boldSystemFont(ofSize: 10)
        badgeLabel.textColor = .white
        badgeLabel.backgroundColor = UIColor(red: 30/255, green: 155/255, blue: 233/255, alpha: 1) // #1E9BE9
        badgeLabel.layer.cornerRadius = 2
        badgeLabel.clipsToBounds = true
        badgeLabel.textAlignment = .center
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(badgeLabel)
        
        // 2. Main Horizontal Content
        let rowStack = UIStackView()
        rowStack.axis = .horizontal
        rowStack.alignment = .center
        rowStack.spacing = 0
        rowStack.translatesAutoresizingMaskIntoConstraints = false
        rowStack.layoutMargins = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 8)
        rowStack.isLayoutMarginsRelativeArrangement = true
        contentContainer.addSubview(rowStack)
        
        NSLayoutConstraint.activate([
            rowStack.topAnchor.constraint(equalTo: contentContainer.topAnchor),
            rowStack.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            rowStack.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            rowStack.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor),
            
            badgeLabel.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: 8),
            badgeLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 15),
            badgeLabel.widthAnchor.constraint(equalToConstant: 24),
            badgeLabel.heightAnchor.constraint(equalToConstant: 18)
        ])

        // App Icon (50x50 with 20pt radius)
        let iconView = factory.createIconView(nativeAd, adView: adView)
        iconView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iconView.layer.cornerRadius = 20
        
        let iconWrapper = UIView()
        iconWrapper.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: iconWrapper.topAnchor, constant: 3),
            iconView.leadingAnchor.constraint(equalTo: iconWrapper.leadingAnchor),
            iconView.trailingAnchor.constraint(equalTo: iconWrapper.trailingAnchor, constant: -10),
            iconView.bottomAnchor.constraint(equalTo: iconWrapper.bottomAnchor)
        ])
        rowStack.addArrangedSubview(iconWrapper)

        // Text Stack
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 2

        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 16), color: .black)
        adView.headlineView = headline
        
        let headlineWrapper = UIView()
        headlineWrapper.addSubview(headline)
        headline.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headline.topAnchor.constraint(equalTo: headlineWrapper.topAnchor, constant: 12),
            headline.leadingAnchor.constraint(equalTo: headlineWrapper.leadingAnchor),
            headline.trailingAnchor.constraint(equalTo: headlineWrapper.trailingAnchor),
            headline.bottomAnchor.constraint(equalTo: headlineWrapper.bottomAnchor)
        ])
        textStack.addArrangedSubview(headlineWrapper)
        
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 12), color: .black)
        adView.bodyView = body
        textStack.addArrangedSubview(body)
        
        rowStack.addArrangedSubview(textStack)

        // CTA Blue Pill
        let cta = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 30/255, green: 155/255, blue: 233/255, alpha: 1))
        cta.titleLabel?.font = .systemFont(ofSize: 14)
        cta.layer.cornerRadius = 24
        cta.contentEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        cta.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        let ctaWrapper = UIView()
        ctaWrapper.addSubview(cta)
        cta.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cta.topAnchor.constraint(equalTo: ctaWrapper.topAnchor),
            cta.leadingAnchor.constraint(equalTo: ctaWrapper.leadingAnchor, constant: 10),
            cta.trailingAnchor.constraint(equalTo: ctaWrapper.trailingAnchor),
            cta.bottomAnchor.constraint(equalTo: ctaWrapper.bottomAnchor)
        ])
        rowStack.addArrangedSubview(ctaWrapper)

        // Bottom Divider
        let bottomDivider = UIView()
        bottomDivider.backgroundColor = .black
        bottomDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        verticalStack.addArrangedSubview(bottomDivider)
    }
}

class NativeAdDesign3Dark {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1) // #121212

        let verticalStack = factory.createMainStack(container, padding: 0, spacing: 0)

        // Top Divider
        let topDivider = UIView()
        topDivider.backgroundColor = .black
        topDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        verticalStack.addArrangedSubview(topDivider)

        // Overlapping Relative Context using a Container
        let contentContainer = UIView()
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.addArrangedSubview(contentContainer)

        // 1. AD Badge (Top-Left Overlap)
        let badgeLabel = UILabel()
        badgeLabel.text = "Ad"
        badgeLabel.font = .boldSystemFont(ofSize: 10)
        badgeLabel.textColor = .white
        badgeLabel.backgroundColor = UIColor(red: 30/255, green: 155/255, blue: 233/255, alpha: 1) // #1E9BE9
        badgeLabel.layer.cornerRadius = 2
        badgeLabel.clipsToBounds = true
        badgeLabel.textAlignment = .center
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(badgeLabel)
        
        // 2. Main Horizontal Content
        let rowStack = UIStackView()
        rowStack.axis = .horizontal
        rowStack.alignment = .center
        rowStack.spacing = 0
        rowStack.translatesAutoresizingMaskIntoConstraints = false
        rowStack.layoutMargins = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 8)
        rowStack.isLayoutMarginsRelativeArrangement = true
        contentContainer.addSubview(rowStack)
        
        NSLayoutConstraint.activate([
            rowStack.topAnchor.constraint(equalTo: contentContainer.topAnchor),
            rowStack.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            rowStack.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            rowStack.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor),
            
            badgeLabel.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: 8),
            badgeLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 15),
            badgeLabel.widthAnchor.constraint(equalToConstant: 24),
            badgeLabel.heightAnchor.constraint(equalToConstant: 18)
        ])

        // App Icon
        let iconView = factory.createIconView(nativeAd, adView: adView)
        iconView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iconView.layer.cornerRadius = 20
        
        let iconWrapper = UIView()
        iconWrapper.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: iconWrapper.topAnchor, constant: 3),
            iconView.leadingAnchor.constraint(equalTo: iconWrapper.leadingAnchor),
            iconView.trailingAnchor.constraint(equalTo: iconWrapper.trailingAnchor, constant: -10),
            iconView.bottomAnchor.constraint(equalTo: iconWrapper.bottomAnchor)
        ])
        rowStack.addArrangedSubview(iconWrapper)

        // Text Stack
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 2

        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 16), color: .white)
        adView.headlineView = headline
        
        let headlineWrapper = UIView()
        headlineWrapper.addSubview(headline)
        headline.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headline.topAnchor.constraint(equalTo: headlineWrapper.topAnchor, constant: 12),
            headline.leadingAnchor.constraint(equalTo: headlineWrapper.leadingAnchor),
            headline.trailingAnchor.constraint(equalTo: headlineWrapper.trailingAnchor),
            headline.bottomAnchor.constraint(equalTo: headlineWrapper.bottomAnchor)
        ])
        textStack.addArrangedSubview(headlineWrapper)
        
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 12), color: UIColor(white: 0.67, alpha: 1)) // #AAAAAA
        adView.bodyView = body
        textStack.addArrangedSubview(body)
        
        rowStack.addArrangedSubview(textStack)

        // CTA Blue Pill
        let cta = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 30/255, green: 155/255, blue: 233/255, alpha: 1))
        cta.titleLabel?.font = .systemFont(ofSize: 14)
        cta.layer.cornerRadius = 24
        cta.contentEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        cta.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        let ctaWrapper = UIView()
        ctaWrapper.addSubview(cta)
        cta.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cta.topAnchor.constraint(equalTo: ctaWrapper.topAnchor),
            cta.leadingAnchor.constraint(equalTo: ctaWrapper.leadingAnchor, constant: 10),
            cta.trailingAnchor.constraint(equalTo: ctaWrapper.trailingAnchor),
            cta.bottomAnchor.constraint(equalTo: ctaWrapper.bottomAnchor)
        ])
        rowStack.addArrangedSubview(ctaWrapper)

        // Bottom Divider
        let bottomDivider = UIView()
        bottomDivider.backgroundColor = .black
        bottomDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        verticalStack.addArrangedSubview(bottomDivider)
    }
}
