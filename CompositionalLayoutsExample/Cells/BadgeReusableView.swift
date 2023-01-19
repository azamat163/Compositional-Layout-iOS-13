//
//  BadgeReusableView.swift
//  CompositionalLayoutsExample
//
//  Created by a.agataev on 19.01.2023.
//

import UIKit
import SnapKit

class BadgeReusableView: UICollectionReusableView {
    static var identifier: String {
        return String(describing: self)
    }
    
    private var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.text = String(Int.random(in: 1...9))
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red

        addSubview(label)

        label.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height/2
    }
}
