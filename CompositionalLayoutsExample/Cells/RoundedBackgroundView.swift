//
//  RoundedBackgroundView.swift
//  CompositionalLayoutsExample
//
//  Created by a.agataev on 18.01.2023.
//

import UIKit
import SnapKit

class RoundedBackgroundView: UICollectionReusableView {
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    private var insetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemFill
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(insetView)

        insetView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.bottom.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
