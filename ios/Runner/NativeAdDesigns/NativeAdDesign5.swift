import UIKit
import google_mobile_ads

class NativeAdDesign5 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = .white

        let mainRow = UIStackView()
        mainRow.axis = .horizontal
        mainRow.alignment = .fill
        mainRow.spacing = 0
        mainRow.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(mainRow)
        
        NSLayoutConstraint.activate([
            mainRow.topAnchor.constraint(equalTo: container.topAnchor),
            mainRow.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            mainRow.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            mainRow.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            mainRow.heightAnchor.constraint(equalToConstant: 85)
        ])

        // 1. Icon (60x60)
        let icon = factory.createIconView(nativeAd, adView: adView)
        icon.widthAnchor.constraint(equalToConstant: 60).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 60).isActive = true
        icon.layer.cornerRadius = 12
        icon.clipsToBounds = true
        
        let iconWrapper = UIView()
        iconWrapper.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: iconWrapper.topAnchor, constant: 12.5), // Center vertically in 85dp
            icon.leadingAnchor.constraint(equalTo: iconWrapper.leadingAnchor, constant: 12),
            icon.trailingAnchor.constraint(equalTo: iconWrapper.trailingAnchor, constant: -12),
            icon.bottomAnchor.constraint(equalTo: iconWrapper.bottomAnchor, constant: -12.5)
        ])
        mainRow.addArrangedSubview(iconWrapper)

        // 2. Text Pillar
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.alignment = .fill
        textStack.spacing = 2
        
        let headlineRow = UIStackView()
        headlineRow.axis = .horizontal
        headlineRow.alignment = .center
        headlineRow.spacing = 10
        
        let badge = UILabel()
        badge.text = "AD"
        badge.font = .boldSystemFont(ofSize: 10)
        badge.textColor = .white
        badge.backgroundColor = .gray
        badge.layer.cornerRadius = 2
        badge.clipsToBounds = true
        badge.textAlignment = .center
        badge.widthAnchor.constraint(equalToConstant: 28).isActive = true
        badge.heightAnchor.constraint(equalToConstant: 18).isActive = true
        headlineRow.addArrangedSubview(badge)
        
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 18), color: .black)
        adView.headlineView = headline
        headlineRow.addArrangedSubview(headline)
        
        textStack.addArrangedSubview(headlineRow)
        
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 14), color: UIColor(white: 0.53, alpha: 1), lines: 2) // #888888
        adView.bodyView = body
        textStack.addArrangedSubview(body)
        
        let textWrapper = UIView()
        textWrapper.addSubview(textStack)
        textStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textStack.centerYAnchor.constraint(equalTo: textWrapper.centerYAnchor),
            textStack.leadingAnchor.constraint(equalTo: textWrapper.leadingAnchor),
            textStack.trailingAnchor.constraint(equalTo: textWrapper.trailingAnchor, constant: -12)
        ])
        mainRow.addArrangedSubview(textWrapper)

        // 3. Vertical CTA
        let cta = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 29/255, green: 185/255, blue: 84/255, alpha: 1)) // #1DB954
        cta.titleLabel?.font = .boldSystemFont(ofSize: 16)
        cta.setTitleColor(.white, for: .normal)
        cta.widthAnchor.constraint(equalToConstant: 100).isActive = true
        adView.callToActionView = cta
        mainRow.addArrangedSubview(cta)
    }
}

class NativeAdDesign5Dark {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = UIColor(red: 15/255, green: 23/255, blue: 30/255, alpha: 1) // #0F171E

        let mainRow = UIStackView()
        mainRow.axis = .horizontal
        mainRow.alignment = .fill
        mainRow.spacing = 0
        mainRow.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(mainRow)
        
        NSLayoutConstraint.activate([
            mainRow.topAnchor.constraint(equalTo: container.topAnchor),
            mainRow.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            mainRow.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            mainRow.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            mainRow.heightAnchor.constraint(equalToConstant: 85)
        ])

        // 1. Icon
        let icon = factory.createIconView(nativeAd, adView: adView)
        icon.widthAnchor.constraint(equalToConstant: 60).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 60).isActive = true
        icon.layer.cornerRadius = 12
        icon.clipsToBounds = true
        
        let iconWrapper = UIView()
        iconWrapper.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: iconWrapper.topAnchor, constant: 12.5),
            icon.leadingAnchor.constraint(equalTo: iconWrapper.leadingAnchor, constant: 12),
            icon.trailingAnchor.constraint(equalTo: iconWrapper.trailingAnchor, constant: -12),
            icon.bottomAnchor.constraint(equalTo: iconWrapper.bottomAnchor, constant: -12.5)
        ])
        mainRow.addArrangedSubview(iconWrapper)

        // 2. Text Pillar
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 2
        
        let headlineRow = UIStackView()
        headlineRow.axis = .horizontal
        headlineRow.alignment = .center
        headlineRow.spacing = 10
        
        let badge = UILabel()
        badge.text = "AD"
        badge.font = .boldSystemFont(ofSize: 10)
        badge.textColor = .white
        badge.backgroundColor = .gray
        badge.layer.cornerRadius = 2
        badge.clipsToBounds = true
        badge.textAlignment = .center
        badge.widthAnchor.constraint(equalToConstant: 28).isActive = true
        badge.heightAnchor.constraint(equalToConstant: 18).isActive = true
        headlineRow.addArrangedSubview(badge)
        
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 18), color: .white)
        adView.headlineView = headline
        headlineRow.addArrangedSubview(headline)
        
        textStack.addArrangedSubview(headlineRow)
        
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 14), color: UIColor(white: 0.53, alpha: 1), lines: 2)
        adView.bodyView = body
        textStack.addArrangedSubview(body)
        
        let textWrapper = UIView()
        textWrapper.addSubview(textStack)
        textStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textStack.centerYAnchor.constraint(equalTo: textWrapper.centerYAnchor),
            textStack.leadingAnchor.constraint(equalTo: textWrapper.leadingAnchor),
            textStack.trailingAnchor.constraint(equalTo: textWrapper.trailingAnchor, constant: -12)
        ])
        mainRow.addArrangedSubview(textWrapper)

        // 3. Vertical CTA
        let cta = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 29/255, green: 185/255, blue: 84/255, alpha: 1))
        cta.titleLabel?.font = .boldSystemFont(ofSize: 16)
        cta.setTitleColor(.white, for: .normal)
        cta.widthAnchor.constraint(equalToConstant: 100).isActive = true
        adView.callToActionView = cta
        mainRow.addArrangedSubview(cta)
    }
}
