//
//  MainViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 4/10/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class MainViewController: UIViewController {
    
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
        self.title = "DesignSystem Sample App"
    }
    
    var tokenSectionData =
    ComponentSectionData(
        title: "Token",
        items: [
            ItemData(title: "Color", type: .color),
            ItemData(title: "Typography", type: .typography),
            ItemData(title: "Font", type: .font),
        ]
    )
    
    var atomSectionData =
    ComponentSectionData(
        title: "Atom",
        items: [
            ItemData(title: "Accordion", type: .accordion),
            ItemData(title: "Badge", type: .badge),
            ItemData(title: "Button", type: .button),
            ItemData(title: "Checkbox", type: .checkbox),
            ItemData(title: "Chip", type: .chip),
            ItemData(title: "Dropdown", type: .dropdown),
            ItemData(title: "ImageChip", type: .imageChip),
            ItemData(title: "Indicator", type: .indicator),
            ItemData(title: "LabeledText", type: .labeledText),
            ItemData(title: "Placeholder", type: .placeholder),
            ItemData(title: "RadioButton", type: .radioButton),
            ItemData(title: "SearchInput", type: .searchInput),
            ItemData(title: "SliderBar", type: .sliderBar),
            ItemData(title: "DealiSwitch", type: .dealiSwitch),
            ItemData(title: "Tag", type: .tag),
            ItemData(title: "TextArea", type: .textArea),
            ItemData(title: "TextInput", type: .textInput),
            ItemData(title: "TextLink", type: .textLink),
            ItemData(title: "ToolTip", type: .toolTip),
        ]
    )
    
    var molculeSectionData =
    ComponentSectionData(
        title: "Molecule",
        items: [
            ItemData(title: "Alert", type: .alert),
            ItemData(title: "BottomSheet", type: .bottomSheet),
            ItemData(title: "Empty", type: .empty),
            ItemData(title: "Notice", type: .notice),
            ItemData(title: "TabBar", type: .tabBar),
            
        ]
    )
    
    var etcSectionData =
    ComponentSectionData(
        title: "Etc",
        items: [
            ItemData(title: "LinkLabel", type: .linkLabel),
        ]
    )
}

private extension MainViewController {
    
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
extension MainViewController {
    func handleAction(with item: ItemData) {
        ActionManager.shared.performAction(for: item) {
            self.pushViewController(item.nextVC)
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
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
extension MainViewController {
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

extension UIViewController {
    func pushViewController(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MainViewController: DealiSearchInputDelegate {
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
