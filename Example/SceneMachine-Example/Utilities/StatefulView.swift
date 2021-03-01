//
//  StatefulView.swift
//  SceneMachine
//
//  Created by Duy Tran on 10/3/20.
//

import UIKit

final class StatefulView: UIView {
    
    // MARK: - UIs
    
    private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = Asset.accentColor.color
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    private(set) lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private(set) lazy var actionButton: UIButton = {
        let view = UIButton()
        view.addTarget(
            self,
            action: #selector(actionButtonDidTap(sender:)),
            for: .touchUpInside)
        view.setTitleColor(Asset.accentColor.color, for: .normal)
        view.layer.borderColor = Asset.accentColor.color.cgColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        return view
    }()
    
    private(set) lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, imageView, actionButton])
        view.axis = .vertical
        view.spacing = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Dependencies
    
    let padding: CGFloat
    
    var action: (() -> Void)?
    
    // MARK: - Init
    
    init(
        padding: CGFloat = 16,
        action: (() -> Void)? = nil) {
        self.padding = padding
        self.action = action
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        self.padding = 0
        self.action = nil
        super.init(coder: coder)
        setUp()
    }
    
    // MARK: - Public
    
    func configure(
        withTitle title: String,
        image: UIImage,
        actionTitle: String,
        action: (() -> Void)? = nil) {
        titleLabel.text = title
        titleLabel.isHidden = title.isEmpty
        imageView.image = image
        actionButton.setTitle(actionTitle, for: .normal)
        actionButton.isHidden = actionTitle.isEmpty
        self.action = action
    }
    
    // MARK: - Private
    
    private func setUp() {
        backgroundColor = .white
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: padding),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -padding),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -padding),
        ])
    }
    
    @objc private func actionButtonDidTap(sender: UIButton) {
        action?()
    }
}
