//
//  HomeView.swift
//  AlbertsonsCodeVeeru
//
//  Created by Suthari, Veerabrahmam on 1/20/23.
//

import Foundation
import UIKit

class HomeView: UIStackView {

    private lazy var factLabelHeightAnchor = factLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.44)
    private lazy var homeImageViewHeightAnchor = homeImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.55)
    private lazy var factLabelWidthAnchor = factLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.44)
    private lazy var homeImageViewWidthAnchor = homeImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.55)
    
    private lazy var homeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 2
        return imageView
    }()

    private lazy var factLabel: UITextView = {
       let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.isEditable = false
        label.backgroundColor = .clear
        label.layer.borderWidth = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        isLayoutMarginsRelativeArrangement = true
        translatesAutoresizingMaskIntoConstraints = false
        distribution = .fillProportionally
        spacing = 5
        axis = .vertical
        addArrangedSubview(homeImageView)
        addArrangedSubview(factLabel)
        setCustomSpacing(5, after: homeImageView)
    }
    
    public func updateLabel(title: String) {
        factLabel.text = title
    }
    
    public func updateImage(urlValue: URL) {
        homeImageView.image = UIImage(systemName: "rays")
        homeImageView.load(url: urlValue)
    }

    public func changeAxis(isPortrait: Bool) {
        axis = isPortrait ? .vertical : .horizontal
        
        factLabelHeightAnchor.isActive = isPortrait
        homeImageViewHeightAnchor.isActive = isPortrait
        factLabelWidthAnchor.isActive = !isPortrait
        homeImageViewWidthAnchor.isActive = !isPortrait
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension HomeView {
    var testHook: TestHook {
        .init(with: self)
    }
    
    struct TestHook {
        private let target: HomeView
        fileprivate init(with target: HomeView) {
            self.target = target
        }
        
        var factLabel: UITextView {
            target.factLabel
        }
    }
}

