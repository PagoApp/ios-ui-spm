//
//  
//  PagoCheckbox.swift
//  Pago
//
//  Created by Gabi Chiosa on 29/05/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import Foundation

class PagoCheckbox: BaseView {
    
    var titleLabel: UILabel!
    var checkboxImage: UIImageView!
    var contentView: UIView!
    var focusView: UIView!
    
    private var heightConstraint: NSLayoutConstraint?
    private var imageHeightConstraint: NSLayoutConstraint?
    
    var viewPresenter: PagoCheckboxPresenter! {
        return (presenter as! PagoCheckboxPresenter)
    }
    
    init(presenter: PagoCheckboxPresenter) {
        
        super.init(frame: .zero)
        initSubviews()
        setup(presenter: presenter)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        initSubviews()
    }
    
    private func initSubviews() {
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentView)
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        checkboxImage = UIImageView()
        checkboxImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(checkboxImage)
        checkboxImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        checkboxImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        checkboxImage.widthAnchor.constraint(equalTo: checkboxImage.heightAnchor).isActive = true
        imageHeightConstraint = checkboxImage.heightAnchor.constraint(equalToConstant: CGFloat(20))
        imageHeightConstraint?.isActive = true
        
        titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: checkboxImage.trailingAnchor, constant: 8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func setup(presenter: PagoCheckboxPresenter) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.presenter = presenter
        presenter.setView(mView: self)
        loadData()
        titleLabel.isAccessibilityElement = false
        focusView.isAccessibilityElement = false
        contentView.isAccessibilityElement = false
        checkboxImage.isAccessibilityElement = false
        updateAccessibilityLabel(value: presenter.accessibility.accessibilityLabel)
    }
    
    override func reloadView() {
        
        loadData()
    }


    @objc func focus() {
        
        viewPresenter?.toggleSelection()
    }
    
    @objc func showInfo() {
        
        viewPresenter?.showInfo()
    }

    private func loadData() {

        checkboxImage.image = nil
        imageHeightConstraint?.constant = CGFloat(viewPresenter.style.imageSize.rawValue)
        
        var focusArea = UIView()
        
        let focusHeight = CGFloat(40)
        let focusWidth = CGFloat(40)
        
        if viewPresenter?.hasInfo == true {
            
            focusArea.backgroundColor = .clear
            contentView.addSubview(focusArea)
            focusArea.translatesAutoresizingMaskIntoConstraints = false
            focusArea.widthAnchor.constraint(equalToConstant: focusWidth).isActive = true
            focusArea.heightAnchor.constraint(equalToConstant: focusHeight).isActive = true
            focusArea.centerYAnchor.constraint(equalTo: checkboxImage.centerYAnchor).isActive = true
            focusArea.centerXAnchor.constraint(equalTo: checkboxImage.centerXAnchor).isActive = true
            
            let infoArea = UIView()
            infoArea.backgroundColor = .clear
            infoArea.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(infoArea)
            infoArea.leadingAnchor.constraint(equalTo: focusArea.trailingAnchor).isActive = true
            infoArea.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            infoArea.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            infoArea.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            
            let infoTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.showInfo))
            infoArea.isUserInteractionEnabled = true
            infoArea.addGestureRecognizer(infoTapGestureRecognizer)
            
        } else if viewPresenter.title.isEmpty {
           
            checkboxImage.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor).isActive = true
            checkboxImage.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor).isActive = true
            contentView.addSubview(focusArea)
            focusArea.translatesAutoresizingMaskIntoConstraints = false
            focusArea.widthAnchor.constraint(equalToConstant: focusWidth).isActive = true
            focusArea.heightAnchor.constraint(equalToConstant: focusHeight).isActive = true
            focusArea.centerYAnchor.constraint(equalTo: checkboxImage.centerYAnchor).isActive = true
            focusArea.centerXAnchor.constraint(equalTo: checkboxImage.centerXAnchor).isActive = true
        } else {

            focusArea = contentView
        }
        let focusTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.focus))
        focusArea.isUserInteractionEnabled = true
        focusArea.addGestureRecognizer(focusTapGestureRecognizer)
        viewPresenter.loadState()
        focusView = focusArea
        layoutIfNeeded()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let pointForTarget = focusView.convert(point, from: self)
        
        if focusView.bounds.contains(pointForTarget) {
            return focusView.hitTest(pointForTarget, with: event)
        }
        return super.hitTest(point, with: event)
    }

}

extension PagoCheckbox: PagoCheckboxPresenterView {
    
    func hideView(isHidden: Bool) {
        
        self.isHidden = isHidden
    }
    
    func update(style: PagoCheckboxStyle) {
        
        DispatchQueue.main.async {
            UIView.transition(with: self, duration: self.viewPresenter.transitionTime, options: .transitionCrossDissolve, animations: {
                let defaultAttributes = NSAttributedString.toAttributes(font: self.viewPresenter.style.fontType, color: self.viewPresenter.style.fontColorType)
                if let highlighted = self.viewPresenter.highlightedText {
                    let title = String.init(format: self.viewPresenter.title, highlighted)
                    let highlightAttributes = NSAttributedString.toAttributes(font: self.viewPresenter.highlightedStyle?.fontType, color: self.viewPresenter.highlightedStyle?.colorType, underlined: self.viewPresenter.highlightedStyle?.isUnderlined)
                    let attributedMutable = NSMutableAttributedString(string: title, attributes: defaultAttributes)
                    attributedMutable.updateStyle(for: highlighted, attributes: highlightAttributes)
                    self.titleLabel.attributedText = attributedMutable
                } else {
                    let title = self.viewPresenter.title
                    self.titleLabel.attributedText = NSAttributedString(string: title, attributes: defaultAttributes)
                }
                self.checkboxImage.image = self.viewPresenter.style.imageType.image
            }, completion: nil)
        }
    }
    
    func update(title: String) {
        
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.text = title
            self?.updateAccessibilityLabel(value: title)
        }
    }
    
    func update(accessibility: PagoAccessibility) {
        
        isAccessibilityElement = accessibility.isAccessibilityElement
        accessibilityTraits = accessibility.accessibilityTraits
        updateAccessibilityLabel(value: accessibility.accessibilityLabel)
    }
    
    func updateAccessibilityLabel(value: String?) {
        
        accessibilityLabel = String.init(format: viewPresenter.isSelected ? "0f313080-6863-4259-81bb-cc96e1ad9a5c".localized : "28b0a124-ee9e-4bcb-95fe-20ecbd7dc2b1".localized, value ?? "")
    }
}
