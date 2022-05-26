//
//
//  PagoButtonView.swift
//  Pago
//
//  Created by Gabi Chiosa on 29/05/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit

open class PagoButton: BaseView {
    
    var viewPresenter: PagoButtonPresenter! { return (presenter as! PagoButtonPresenter) }

    private var title: UILabel!
    private var button: UIButton!
    private var imageView: PagoImageView!
    private var contentView: UIView!
    private var badgeView: PagoBadge?
    private var borderView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    public init(presenter: PagoButtonPresenter) {
        
        super.init(frame: .zero)
        setup(presenter: presenter)
    }

    required public init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    public override func reloadView() {
        
        super.reloadView()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.layer.removeAllAnimations()
            UIView.animate(withDuration: 0.25) { [weak self] in
                guard let self = self else { return }
                self.borderView.backgroundColor = self.viewPresenter.backgroundColorType.color
                if self.viewPresenter.hasShadow {
                    self.borderView.layer.shadowOpacity = 0.2
                } else {
                    self.borderView.layer.shadowOpacity = 0
                }
            }
        }
    }
    
    public func setup(presenter: PagoButtonPresenter) {
        
        self.presenter = presenter
        setup()
    }
    
    private func setup() {
        
        if button != nil {
            button.removeFromSuperview()
        }
        if title != nil {
            title.removeFromSuperview()
        }
        if imageView != nil {
            imageView.removeFromSuperview()
        }
        if contentView != nil {
            contentView.removeAllSubviews()
        }
        
        if badgeView != nil {
            badgeView?.removeFromSuperview()
        }
        
        if borderView != nil {
            borderView.removeFromSuperview()
        }
        
        self.backgroundColor = .clear
        
        borderView = UIView()
        contentView = UIView()
        button = UIButton()
        title = UILabel()
        
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = .clear
        self.addSubview(borderView)
        borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        borderView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentView)
        viewPresenter.setView(mView: self)
        viewPresenter.loadData()
        
        if viewPresenter.isSelfSized {
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        } else {
            contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        }
                
        imageView = PagoImageView(presenter: viewPresenter.imagePresenter)
        contentView.addSubview(imageView)
        
        if viewPresenter.hasTitle {
            title.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(title)
            if viewPresenter.hasImage {
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
                imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
                title.leadingAnchor.constraint(greaterThanOrEqualTo: imageView.trailingAnchor, constant: viewPresenter.buttonLeadingSpace).isActive = true
            } else {
                title.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: viewPresenter.buttonLeadingSpace).isActive = true
            }
            title.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor).isActive = true
            title.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor).isActive = true
            if !viewPresenter.hasImage {
                title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
                title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
                title.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor).isActive = true
            } else {
                title.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor).isActive = true
            }
            title.preferredMaxLayoutWidth = self.bounds.size.height
            title.lineBreakMode = .byWordWrapping
            title.textAlignment = .center
            title.numberOfLines = viewPresenter.style.numberOfLines
            if !viewPresenter.isSelfSized {
                contentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
                contentView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
                
                if let width = viewPresenter.customWidth {
                    self.widthAnchor.constraint(equalToConstant: width).isActive = true
                }
                
                if let height = viewPresenter.customHeight {
                    self.heightAnchor.constraint(equalToConstant: height).isActive = true
                }
            }
        } else {
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        }

        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        self.addSubview(button)
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        title.isUserInteractionEnabled = false
        button.isUserInteractionEnabled = false
        imageView.isUserInteractionEnabled = false
        contentView.isUserInteractionEnabled = false
        self.isUserInteractionEnabled = true
        
        if let badgePresenter = viewPresenter.badgePresenter {
            let badgeView = PagoBadge(presenter: badgePresenter)
            badgeView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(badgeView)
            var badgeParent: UIView! = contentView
            var offset: CGFloat = 4
            if viewPresenter.hasTitle {
                badgeParent = title
                offset = 0
            }
            badgeView.widthAnchor.constraint(greaterThanOrEqualToConstant: 22).isActive = true
            switch badgePresenter.position {
            //NOTE(QSA): checked bottomLeft position for the badge when it has borders and no title. Should check each case if necessary to be sure it's ok
            case .bottomLeft:
                badgeView.trailingAnchor.constraint(equalTo: badgeParent.leadingAnchor, constant: -1*offset).isActive = true
                badgeView.topAnchor.constraint(equalTo: badgeParent.bottomAnchor, constant: -1*offset).isActive = true
            case .bottomRight:
                badgeView.leadingAnchor.constraint(equalTo: badgeParent.trailingAnchor, constant: -1*offset).isActive = true
                badgeView.topAnchor.constraint(equalTo: badgeParent.bottomAnchor, constant: -1*offset).isActive = true
            case .topLeft:
                badgeView.trailingAnchor.constraint(equalTo: badgeParent.leadingAnchor, constant: -1*offset).isActive = true
                badgeView.bottomAnchor.constraint(equalTo: badgeParent.topAnchor, constant: -1*offset).isActive = true
            case .topRight:
                badgeView.leadingAnchor.constraint(equalTo: badgeParent.trailingAnchor, constant: -1*offset).isActive = true
                badgeView.bottomAnchor.constraint(equalTo: badgeParent.topAnchor, constant: -1*offset).isActive = true
            }
            self.badgeView = badgeView
        }
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var hasTouch = false
        if let touch = touches.first {
            let location = touch.location(in: self)
            if self.bounds.contains(location) {
                hasTouch = true
            }
        }
        viewPresenter.touchDown()
        if !hasTouch {
            super.touchesBegan(touches, with: event)
        }
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var hasTouch = false
        if let touch = touches.first {
            let location = touch.location(in: self)
            if self.bounds.contains(location) {
                viewPresenter.didTap()
                hasTouch = true
            }
        }
        viewPresenter.touchUp()
        if !hasTouch {
            super.touchesEnded(touches, with: event)
        }
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var hasTouch = false
        if let touch = touches.first {
            let location = touch.location(in: self)
            if self.bounds.contains(location) {
                viewPresenter.didTap()
                hasTouch = true
            }
        }
        viewPresenter.touchUp()
        if !hasTouch {
            super.touchesCancelled(touches, with: event)
        }
    }
    
    
    
    private func setTitle(_ text: String) {
        
        let attributes = NSAttributedString.toAttributes(font: viewPresenter.fontType, color: viewPresenter.titleColorType, underlined: viewPresenter.style.isUnderlined)
        let attr = NSMutableAttributedString(string: text, attributes: attributes)
        
        if let placeholder = viewPresenter.highlightedText, let style = viewPresenter.placeholderStyle {
            let placeholderAttributes = NSAttributedString.toAttributes(font: style.fontType, color: style.colorType, underlined: style.isUnderlined)
            attr.update(style: [placeholder: placeholderAttributes])
        }
        title.attributedText = attr
        
        title.isAccessibilityElement = false
        button.isAccessibilityElement = false
        
        isAccessibilityElement = viewPresenter.accessibility.isAccessibilityElement
        accessibilityTraits = viewPresenter.accessibility.accessibilityTraits
        let title = "\(viewPresenter.accessibility.accessibilityLabel ??  attr.string) \(viewPresenter.isEnabled ? "" : "7e91cdaa-2bec-4587-8172-0c0ccb04e2d2".localized)"
        accessibilityLabel = title
    }

    private func setDynamicHighlitedTitle(_ text: String) {
        
        var attributes = NSAttributedString.toAttributes(font: viewPresenter.fontType, color: viewPresenter.titleColorType, underlined: viewPresenter.style.isUnderlined)
        attributes[.foregroundColor] = viewPresenter.titleColorType.color(withAlpha: 0.8)
        
        let attr = NSMutableAttributedString(string: text, attributes: attributes)
        
        if let placeholder = viewPresenter.highlightedText, let style = viewPresenter.placeholderStyle {
            var placeholderAttributes = NSAttributedString.toAttributes(font: style.fontType, color: style.colorType, underlined: style.isUnderlined)
            placeholderAttributes[.foregroundColor] = style.colorType.color(withAlpha: 0.8)
            attr.update(style: [placeholder: placeholderAttributes])
        }
        title.attributedText = attr
    }
    
    private func reloadUI() {
        if self.viewPresenter.hasShadow {
            if let shadowStyle = self.viewPresenter.style.shadowStyle {
                self.borderView.layer.shadowOffset = shadowStyle.offset
                self.borderView.layer.shadowRadius = shadowStyle.radius
                self.borderView.layer.shadowOpacity = shadowStyle.opacity
                self.borderView.layer.shadowColor = shadowStyle.colorType.cgColor
            }
        } else {
            self.borderView.layer.shadowOpacity = 0
        }
        
        if let borderStyle = self.viewPresenter.borderStyle {
            self.borderView.layer.borderColor = borderStyle.colorType.cgColor
            self.borderView.layer.borderWidth = borderStyle.width
        }

        self.borderView.clipsToBounds = true
        self.borderView.layer.masksToBounds = false
        self.borderView.backgroundColor = self.viewPresenter.backgroundColorType.color
        self.borderView.layer.cornerRadius = CGFloat(self.viewPresenter.cornerRadius)
        
        if let badge = self.badgeView {
            self.bringSubview(toFront: badge)
        }
    }
    
    private func showTouchingStyle() {
        
        let hasCustomHighlightStyle = self.viewPresenter.hasCustomHighlightStyle
        
        if self.viewPresenter.hasShadow {
            if let shadowStyle = self.viewPresenter.style.shadowStyle {
                self.borderView.layer.shadowOffset = shadowStyle.offset
                self.borderView.layer.shadowRadius = shadowStyle.radius
                self.borderView.layer.shadowOpacity = shadowStyle.opacity
                if hasCustomHighlightStyle {
                    self.borderView.layer.shadowColor = shadowStyle.colorType.cgColor
                } else {
                    self.borderView.layer.shadowColor = shadowStyle.colorType.cgColor(withAlpha: 0.8)
                }
            }
        } else {
            self.borderView.layer.shadowOpacity = 0
        }
        
        if let borderStyle = self.viewPresenter.borderStyle {
            if hasCustomHighlightStyle {
                self.borderView.layer.borderColor = borderStyle.colorType.cgColor
            } else {
                self.borderView.layer.borderColor = borderStyle.colorType.cgColor(withAlpha: 0.8)
            }
            self.borderView.layer.borderWidth = borderStyle.width
        }
        
        self.borderView.clipsToBounds = true
        self.borderView.layer.masksToBounds = false
        if hasCustomHighlightStyle {
            self.borderView.backgroundColor = self.viewPresenter.backgroundColorType.color
            self.setTitle(self.viewPresenter.title)
        } else {
            if self.viewPresenter.backgroundColorType != .clear {
                self.borderView.backgroundColor = self.viewPresenter.backgroundColorType.color(withAlpha: 0.8)
            }
            self.setDynamicHighlitedTitle(self.viewPresenter.title)
        }

        self.borderView.layer.cornerRadius = CGFloat(self.viewPresenter.cornerRadius)
    }
}

extension PagoButton: PagoButtonPresenterView {

    public func update(accessibility: PagoAccessibility) {
        
        isAccessibilityElement = accessibility.isAccessibilityElement
        accessibilityTraits = accessibility.accessibilityTraits
        accessibilityLabel = accessibility.accessibilityLabel
    }
    
    public func hide(_ hidden: Bool) {
        
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.15) {
                self?.alpha = hidden ? 0 : 1
            }
        }
    }
    
    public func updateTitle(text: String) {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.setTitle(text)
            self?.viewPresenter.title = text
        }
    }

    public func updateUI() {

        reloadUI()
    }
    
    public func reloadStyle(isTouching: Bool) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.layer.removeAllAnimations()
            self.title.layer.removeAllAnimations()
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear, animations: { [weak self] in
                guard let self = self else { return }
                if isTouching {
                    self.updateToIsTouchingStyle()
                } else {
                    self.reloadUI()
                    self.setTitle(self.viewPresenter.title)

                }
            }, completion: nil)
        }
    }
    
    public func updateToIsTouchingStyle() {
        
        showTouchingStyle()
    }

}
