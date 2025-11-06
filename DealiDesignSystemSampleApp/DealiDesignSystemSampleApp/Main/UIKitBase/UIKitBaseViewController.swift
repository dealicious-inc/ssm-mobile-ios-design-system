//
//  UIKitBaseViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 4/10/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import UIKit
import SwiftUI
import DealiDesignKit

final class UIKitBaseViewController: UIViewController {
    
    private enum Section: Int, CaseIterable {
        case searchBar
        case token
        case atom
        case molcule
        case etc
    }
    
    lazy var componentSectionData: [Int: ComponentSectionData] = [
        Section.token.rawValue : tokenSectionData,
        Section.atom.rawValue: atomSectionData,
        Section.molcule.rawValue: molculeSectionData,
        Section.etc.rawValue: etcSectionData
    ]
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.compositionalLayout)
    
    private lazy var compositionalLayout: UICollectionViewLayout = {
        UICollectionViewCompositionalLayout { sectionIndex, env in
            switch Section(rawValue: sectionIndex) {
            case .token, .atom, .molcule, .etc:
                return self.componentLayout()
            default:
                return self.singleItemLayout()
            }
        }
    }()
        
    private var dataSource: UICollectionViewDiffableDataSource<Section, ItemData>! = nil
    
    private var isSwiftUI: Bool
    
    init(isSwiftUI: Bool = false) {
        self.isSwiftUI = isSwiftUI
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = .init()
        
        self.view.backgroundColor = .systemBackground
      
        self.view.addSubview(self.collectionView)
        self.collectionView.then {
            $0.delegate = self
            $0.register(SearchBarCell.self, forCellWithReuseIdentifier: SearchBarCell.identifier)
            $0.register(ComponentCollectionViewCell.self, forCellWithReuseIdentifier: ComponentCollectionViewCell.identifier)
            $0.register(ComponentHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ComponentHeaderView.identifier)
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.configureDataSource()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.isSwiftUI ? "UIKit Compoments" :"SwiftUI Compoments"
    }
    
    lazy var tokenSectionData =
    ComponentSectionData(
        title: "Token",
        items:
            ActionType.allCases
            .filter { self.isSwiftUI ? $0.hasSwiftUISample : true }
            .filter { $0.group == .token }
            .map({ ItemData(title: $0.title, type: $0.self, isSwiftUI: self.isSwiftUI)})
    )
    
    lazy var atomSectionData =
    ComponentSectionData(
        title: "Atom",
        items: ActionType.allCases
            .filter({ self.isSwiftUI ? $0.hasSwiftUISample : true })
            .filter { $0.group == .atom }
            .map({ ItemData(title: $0.title, type: $0.self, isSwiftUI: self.isSwiftUI)})
    )
    
    lazy var molculeSectionData =
    ComponentSectionData(
        title: "Molecule",
        items: ActionType.allCases
            .filter({ self.isSwiftUI ? $0.hasSwiftUISample : true })
            .filter { $0.group == .molecule }
            .map({ ItemData(title: $0.title, type: $0.self, isSwiftUI: self.isSwiftUI)})
    )
    
    lazy var etcSectionData =
    ComponentSectionData(
        title: "Etc",
        items: ActionType.allCases
            .filter({ self.isSwiftUI ? $0.hasSwiftUISample : true })
            .filter { $0.group == .etc }
            .map({ ItemData(title: $0.title, type: $0.self, isSwiftUI: self.isSwiftUI)})
    )
}

private extension UIKitBaseViewController {
    
    func singleItemLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupWidth: NSCollectionLayoutDimension = .fractionalWidth(1.0)
        let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension:  .estimated(50.0))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        return section
    }
    
    func componentLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .absolute(60.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10)
        
        let groupWidth: NSCollectionLayoutDimension = .fractionalWidth(1.0)
        let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: .estimated(100.0))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40.0)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        return section
    }
    
}

// ActionHandler
extension UIKitBaseViewController {
    func handleAction(with item: ItemData) {
        ActionManager.shared.performAction(for: item) {
            self.pushViewController(item.nextVC)
        }
    }
}

extension UIKitBaseViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionIdentifier = dataSource.sectionIdentifier(for: indexPath.section)
        switch sectionIdentifier {
        case .token, .atom, .molcule, .etc:
            guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
            self.handleAction(with: item)
        default:
            break
        }
    }
}

// MARK: - Diffable Datasource
extension UIKitBaseViewController {
    func configureDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, ItemData>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch Section(rawValue: indexPath.section) {
            case .searchBar:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchBarCell.identifier, for: indexPath) as! SearchBarCell
                cell.searchInput.delegate = self
                return cell
            case .token, .atom, .molcule, .etc:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComponentCollectionViewCell.identifier, for: indexPath) as! ComponentCollectionViewCell
                cell.configure(itemIdentifier)
                
                
                return cell
                
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComponentCollectionViewCell.identifier, for: indexPath) as! ComponentCollectionViewCell
                return cell
            }
        }
        
        self.dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }

            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]

            switch section {
            case .token, .atom, .molcule, .etc:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ComponentHeaderView.identifier, for: indexPath) as! ComponentHeaderView

                if let sectionData = self.componentSectionData[section.rawValue] {
                    header.title = sectionData.title
                }
                return header

            default:
                return nil
            }
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, ItemData>()
        Section.allCases.forEach {
            snapshot.appendSections([$0])
            
            if $0 == .searchBar {
                snapshot.appendItems([ItemData()])
            } else {
                snapshot.appendItems(componentSectionData[$0.rawValue]?.items ?? [])
            }
        }
        
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func performQuery(with filter: String?) {
        guard let filter, filter.isEmpty == false else {
            self.resetResult()
            return
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, ItemData>()
        Section.allCases.forEach {
            snapshot.appendSections([$0])
            
            if $0 == .searchBar {
                snapshot.appendItems([ItemData()])
            } else {
                snapshot.appendItems(componentSectionData[$0.rawValue]?.items.filter { $0.title?.localizedCaseInsensitiveContains(filter) ?? false } ?? [])
            }
        }
        
        self.dataSource.apply(snapshot, animatingDifferences: true)
        
    }
    
    func resetResult() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ItemData>()
        Section.allCases.forEach {
            snapshot.appendSections([$0])
            
            if $0 == .searchBar {
                snapshot.appendItems([ItemData()])
            } else {
                snapshot.appendItems(componentSectionData[$0.rawValue]?.items ?? [])
            }
        }
        self.dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension UIKitBaseViewController: DealiSearchInputDelegate {
    func search(keyword: String?) {
        
    }
    
    func clear() {
        self.resetResult()
    }
    
    func beginEditing() {
        
    }
    
    func endEditing() {

    }
    
    func editingChanged(keyword: String?) {
        self.performQuery(with: keyword)
    }
}
