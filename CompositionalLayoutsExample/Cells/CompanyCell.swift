//
//  CompanyCell.swift
//  CompositionalLayoutsExample
//
//  Created by a.agataev on 18.01.2023.
//

import UIKit

class CompanyCell: UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }

    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(2)
            $0.bottom.equalToSuperview().offset(-3)
        }
    }

    func configure(company: Company) {
        titleLabel.text = company.title
        imageView.image = company.image
    }
}
