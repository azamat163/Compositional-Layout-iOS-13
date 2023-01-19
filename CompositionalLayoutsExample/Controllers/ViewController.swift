//
//  ViewController.swift
//  CompositionalLayoutsExample
//
//  Created by a.agataev on 21.12.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private let data: [SectionItem] = MockData.build()
    var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!

    private lazy var collectionView: UICollectionView = {
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCollectionViewLayout()
        )
        collectionView.backgroundColor = .clear
        collectionView.register(BadgeReusableView.self, forSupplementaryViewOfKind: BadgeReusableView.identifier, withReuseIdentifier: BadgeReusableView.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Test"
        setupLayout()
        makeDataSource()
    }


    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            let spacing: CGFloat = 10
            guard let section = Section(rawValue: sectionIndex) else { return nil }
            switch section {

            case .company:
                /// Объект itemSize определяет высоту и ширину элемента, в параметрах нужно указать размер для каждого измерения, за определение измерения отвечает класс NSCollectionLayoutDimension
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(0.5))

                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .estimated(200))

                let trailignSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(0.3))
                let trailingItem = NSCollectionLayoutItem(layoutSize: trailignSize)
                let trailingGroupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.3),
                    heightDimension: .fractionalHeight(1.0))
                let trailingGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: trailingGroupSize,
                    repeatingSubitem: trailingItem, count: 2)
                /// Оступы между элементами группы
                trailingGroup.interItemSpacing = .fixed(spacing)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, trailingGroup])
                /// Оступы между элементами группы
                group.interItemSpacing = .fixed(spacing)
                let section = NSCollectionLayoutSection(group: group)
                /// Со всех сторон ячейка имеет одинаковый оступ
                section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
                /// Оступы между группами в секции
                section.interGroupSpacing = spacing
                section.orthogonalScrollingBehavior = .continuous
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30))
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: HeaderReusableView.identifier,
                    alignment: .top
                )
//                header.pinToVisibleBounds = true
                section.boundarySupplementaryItems = [header]
                return section
            case .people:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .estimated(50),
                    heightDimension: .estimated(50))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(150))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30))
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: HeaderReusableView.identifier,
                    alignment: .top
                )
                header.pinToVisibleBounds = true
                section.boundarySupplementaryItems = [header]
                section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
                section.interGroupSpacing = spacing
                return section
            case .stories:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .estimated(50),
                    heightDimension: .fractionalHeight(0.5))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .estimated(200),
                    heightDimension: .estimated(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let background = NSCollectionLayoutDecorationItem.background(elementKind: RoundedBackgroundView.identifier)
                background.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                let section = NSCollectionLayoutSection(group: group)
                section.decorationItems = [background, background]
                section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
                section.interGroupSpacing = spacing
                section.orthogonalScrollingBehavior = .continuous
//                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30))
//                let header = NSCollectionLayoutBoundarySupplementaryItem(
//                    layoutSize: headerSize,
//                    elementKind: HeaderReusableView.identifier,
//                    alignment: .top
//                )
//                header.pinToVisibleBounds = true
//                section.boundarySupplementaryItems = [header]
                return section
            }
        }
        layout.register(RoundedBackgroundView.self, forDecorationViewOfKind: RoundedBackgroundView.identifier)
        return layout
    }

    private func setupLayout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func makeDataSource() {
        let cellCompany = UICollectionView.CellRegistration<CompanyCell, Company> { (cell, indexPath, item) in
            cell.configure(company: item)
        }
        let cellPeople = UICollectionView.CellRegistration<PeopleCell, People> { (cell, indexPath, item) in
            cell.configure(people: item)
        }
        let cellStories = UICollectionView.CellRegistration<StoryCell, Stories> { (cell, indexPath, item) in
            cell.configure(story: item)
        }

        let header = UICollectionView.SupplementaryRegistration<HeaderReusableView>(elementKind: HeaderReusableView.identifier) { supplementaryView, elementKind, indexPath in
            if indexPath.section == 0 {
                supplementaryView.configure(text: "Company")
            } else if indexPath.section == 1 {
                supplementaryView.configure(text: "People")
            } else {
                supplementaryView.configure(text: "Stories")
            }
        }

        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: collectionView) { collectionView, indexPath, item in
            if let company = item as? Company {
                return collectionView.dequeueConfiguredReusableCell(using: cellCompany, for: indexPath, item: company)
            } else if let people = item as? People {
                return collectionView.dequeueConfiguredReusableCell(using: cellPeople, for: indexPath, item: people)
            } else if let stories = item as? Stories {
                return collectionView.dequeueConfiguredReusableCell(using: cellStories, for: indexPath, item: stories)
            } else {
                fatalError()
            }
        }

        dataSource.supplementaryViewProvider = { supplementaryView, elementKind, indexPath in
            switch elementKind {
            case BadgeReusableView.identifier:
                let badge = self.collectionView.dequeueReusableSupplementaryView(ofKind: BadgeReusableView.identifier, withReuseIdentifier: BadgeReusableView.identifier, for: indexPath) as! BadgeReusableView
                badge.isHidden = Bool.random()
                return badge
            case HeaderReusableView.identifier:
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: header, for: indexPath)
            default:
                assertionFailure("Handle new kind")
                return nil
            }
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        for item in data {
            switch item {
            case .company(let items):
                snapshot.appendSections([.company])
                snapshot.appendItems(items)
            case .people(let items):
                snapshot.appendSections([.people])
                snapshot.appendItems(items)
            case .stories(let items):
                snapshot.appendSections([.stories])
                snapshot.appendItems(items)
            }
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func createBadgeItem() -> NSCollectionLayoutSupplementaryItem {
        let topRightAnchor = NSCollectionLayoutAnchor(edges: [.top, .trailing], fractionalOffset: CGPoint(x: 0.2, y: -0.2))
        let item = NSCollectionLayoutSupplementaryItem(layoutSize: .init(widthDimension: .absolute(18), heightDimension: .absolute(18)), elementKind: BadgeReusableView.identifier, containerAnchor: topRightAnchor)

        return item
    }
}

