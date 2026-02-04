import UIKit
import google_mobile_ads

class NativeAdDesign10 {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = .white
        adView.layer.cornerRadius = 8
        adView.layer.shadowColor = UIColor.black.cgColor
        adView.layer.shadowOpacity = 0.1
        adView.layer.shadowOffset = CGSize(width: 0, height: 2)
        adView.layer.shadowRadius = 4

        let mainRow = UIStackView()
        mainRow.axis = .horizontal
        mainRow.alignment = .center
        mainRow.spacing = 10
        mainRow.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        mainRow.isLayoutMarginsRelativeArrangement = true
        mainRow.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(mainRow)
        
        NSLayoutConstraint.activate([
            mainRow.topAnchor.constraint(equalTo: container.topAnchor),
            mainRow.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            mainRow.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            mainRow.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])

        // Left Side: Texts + Button
        let leftStack = UIStackView()
        leftStack.axis = .vertical
        leftStack.spacing = 4
        
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 16), color: UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1))
        adView.headlineView = headline
        leftStack.addArrangedSubview(headline)
        
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 12), color: UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 1), lines: 2)
        adView.bodyView = body
        leftStack.addArrangedSubview(body)
        
        let ctaSpacer = UIView()
        ctaSpacer.heightAnchor.constraint(equalToConstant: 10).isActive = true
        leftStack.addArrangedSubview(ctaSpacer)
        
        let cta = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 211/255, green: 47/255, blue: 47/255, alpha: 1)) // #D32F2F Red
        cta.titleLabel?.font = .boldSystemFont(ofSize: 12)
        cta.setTitleColor(.white, for: .normal)
        cta.heightAnchor.constraint(equalToConstant: 36).isActive = true
        cta.layer.cornerRadius = 4
        adView.callToActionView = cta
        leftStack.addArrangedSubview(cta)
        
        mainRow.addArrangedSubview(leftStack)

        // Right Side: Media
        let media = factory.createMediaView(120, adView: adView)
        media.widthAnchor.constraint(equalToConstant: 140).isActive = true
        media.heightAnchor.constraint(equalToConstant: 120).isActive = true
        media.backgroundColor = .white
        mainRow.addArrangedSubview(media)
    }
}

class NativeAdDesign10Dark {
    static func setup(_ container: UIView, _ adView: NativeAdView, nativeAd: NativeAd, factory: MyNativeAdFactory) {
        adView.backgroundColor = UIColor(red: 15/255, green: 23/255, blue: 30/255, alpha: 1)
        adView.layer.cornerRadius = 8

        let mainRow = UIStackView()
        mainRow.axis = .horizontal
        mainRow.alignment = .center
        mainRow.spacing = 10
        mainRow.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        mainRow.isLayoutMarginsRelativeArrangement = true
        mainRow.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(mainRow)
        
        NSLayoutConstraint.activate([
            mainRow.topAnchor.constraint(equalTo: container.topAnchor),
            mainRow.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            mainRow.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            mainRow.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])

        // Left Side: Texts + Button
        let leftStack = UIStackView()
        leftStack.axis = .vertical
        leftStack.spacing = 4
        
        let headline = factory.createLabel(nativeAd.headline, font: .boldSystemFont(ofSize: 16), color: .white)
        adView.headlineView = headline
        leftStack.addArrangedSubview(headline)
        
        let body = factory.createLabel(nativeAd.body, font: .systemFont(ofSize: 12), color: UIColor(white: 0.7, alpha: 1), lines: 2)
        adView.bodyView = body
        leftStack.addArrangedSubview(body)
        
        let ctaSpacer = UIView()
        ctaSpacer.heightAnchor.constraint(equalToConstant: 10).isActive = true
        leftStack.addArrangedSubview(ctaSpacer)
        
        let cta = factory.createButton(nativeAd.callToAction, bgColor: UIColor(red: 211/255, green: 47/255, blue: 47/255, alpha: 1))
        cta.titleLabel?.font = .boldSystemFont(ofSize: 12)
        cta.setTitleColor(.white, for: .normal)
        cta.heightAnchor.constraint(equalToConstant: 36).isActive = true
        cta.layer.cornerRadius = 4
        adView.callToActionView = cta
        leftStack.addArrangedSubview(cta)
        
        mainRow.addArrangedSubview(leftStack)

        // Right Side: Media
        let media = factory.createMediaView(120, adView: adView)
        media.widthAnchor.constraint(equalToConstant: 140).isActive = true
        media.heightAnchor.constraint(equalToConstant: 120).isActive = true
        media.backgroundColor = .white
        mainRow.addArrangedSubview(media)
    }
}
