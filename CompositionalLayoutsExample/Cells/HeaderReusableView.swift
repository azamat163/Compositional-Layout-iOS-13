//
//  HeaderReusableView.swift
//  CompositionalLayoutsExample
//
//  Created by a.agataev on 18.01.2023.
//

import UIKit
import SnapKit

class HeaderReusableView: UICollectionReusableView {
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(text: String) {
        titleLabel.text = text
    }
}
