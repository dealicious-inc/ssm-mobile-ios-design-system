//
//  MainViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 4/10/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    private enum Section: Int, CaseIterable {
        case searchBar
        case playground
        case token
        case atom
        case molcule
    }

    lazy var componentSectionData: [Int: ComponentSectionData] = [
        Section.token.rawValue : tokenSectionData,
        Section.atom.rawValue: atomSectionData,
        Section.molcule.rawValue: molculeSectionData
    ]
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.compositionalLayout)
    
    private lazy var compositionalLayout: UICollectionViewLayout = {
        UICollectionViewCompositionalLayout { sectionIndex, env in
            switch Section(rawValue: sectionIndex) {
            case .token, .atom, .molcule:
                return self.componentLayout()
            default:
                return self.singleItemLayout()
            }
        }
    }()

    override func loadView() {
        self.view = .init()
        
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(self.collectionView)
        self.collectionView.then {
            $0.delegate = self
            $0.dataSource = self
            $0.register(ComponentCollectionViewCell.self, forCellWithReuseIdentifier: ComponentCollectionViewCell.identifier)
            $0.register(ComponentHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ComponentHeaderView.identifier)
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}

private extension MainViewController {
    
    func singleItemLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupWidth: NSCollectionLayoutDimension = .fractionalWidth(1.0)
        let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: .fractionalHeight(1.0))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20)
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
        switch Section(rawValue: indexPath.section) {
        case .token, .atom, .molcule:
            guard let section = componentSectionData[indexPath.section] else { return }
            let item = section.items[indexPath.item]
            self.handleAction(with: item)
            
        default:
            return
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .token, .atom, .molcule:
            let section = componentSectionData[section]
            return section?.items.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Section(rawValue: indexPath.section) {
        case .token, .atom, .molcule:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComponentCollectionViewCell.identifier, for: indexPath) as! ComponentCollectionViewCell
            guard let section = componentSectionData[indexPath.section] else { return cell }
            let item = section.items[indexPath.item]
            cell.configure(item)
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComponentCollectionViewCell.identifier, for: indexPath) as! ComponentCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch Section(rawValue: indexPath.section) {
        case .token, .atom, .molcule:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ComponentHeaderView.identifier, for: indexPath) as! ComponentHeaderView
            let section = componentSectionData[indexPath.section]
            header.title = section?.title
            return header
        default:
            return UICollectionReusableView()
        }
      
    }
}

extension UIViewController {
    func pushViewController(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
