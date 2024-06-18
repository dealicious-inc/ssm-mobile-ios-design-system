//
//  File.swift
//  
//
//  Created by 조서현 on 6/18/24.
//

import UIKit

/**
 설명: cell register 코드 간소화를 위한 extension
 
 **register 사용 예시**
    - $0.register(cellClass: CellClass.self) // 일반 cell
    - $0.register(viewClass: HeaderViewClass.self, supplement: .header) // collectionView header 혹은 footer
 
 **dequeueReusableCell 사용 예시**
    - let cell = collectionView.dequeueReusableCell(cellClass: CellClass.self, indexPath: indexPath)
 */
protocol CellRegistrable {
    func register(cellClass: AnyClass)
}

enum ESectionSupplement {
    case header
    case footer
    
    init?(rawValue: String) {
        switch rawValue {
        case UICollectionView.elementKindSectionHeader: self = .header
        case UICollectionView.elementKindSectionFooter: self = .footer
        default: return nil
        }
    }
    
    var rawValue: String {
        switch self {
        case .header: return UICollectionView.elementKindSectionHeader
        case .footer: return UICollectionView.elementKindSectionFooter
        }
    }
}

protocol SupplementaryViewRegistrable {
    func register(viewClass: AnyClass, supplement: ESectionSupplement)
}

typealias Registrable = CellRegistrable & SupplementaryViewRegistrable

extension UICollectionView: Registrable {
    /// CollectionView cell register
    /// - Parameter cellClass: register 할 cell class를 ClassName.self 형식으로 전달합니다.
    func register(cellClass: AnyClass) {
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
    }
    
    /// CollectionView Supplement type register
    /// - Parameter viewClass: register 할 view class를 ClassName.self 형식으로 전달합니다.
    /// - Parameter supplement: .header, .footer 타입 결정
    func register(viewClass: AnyClass, supplement: ESectionSupplement) {
        let className = String(describing: viewClass)
        register(viewClass, forSupplementaryViewOfKind: supplement.rawValue, withReuseIdentifier: className)
    }
    
    /// CollectionView DataSource dequeueReusableCell
    /// - Parameter cellClass: dequeueReusable 할 cell class를 ClassName.self 형식으로 전달합니다.
    /// - Returns: UICollectionViewCell
    func dequeueReusableCell<T: UICollectionViewCell>(cellClass: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(viewClass: T.Type, supplement: ESectionSupplement, indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: supplement.rawValue,
            withReuseIdentifier: String(describing: viewClass),
            for: indexPath
        ) as? T else {
            fatalError()
        }
        return view
    }
}

extension UITableView: CellRegistrable {
    /// TableView cell register
    /// - Parameter cellClass: register 할 cell을 CellClass.self 형식으로 전달합니다.
    func register(cellClass: AnyClass) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
    
    /// TableView Supplement type register
    /// - Parameter viewClass: register 할 view class를 ClassName.self 형식으로 전달합니다.
    func register(viewClass: AnyClass) {
        register(viewClass, forHeaderFooterViewReuseIdentifier: String(describing: viewClass))
    }
    
    /// TableView DataSource dequeueReusableCell
    /// - Parameter cellClass: dequeueReusable 할 cell class를 ClassName.self 형식으로 전달합니다.
    /// - Returns: UITableViewCell
    func dequeueReusableCell<T: UITableViewCell>(cellClass: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: cellClass), for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(viewClass: T.Type) -> T {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: String(describing: viewClass)) as? T else {
            fatalError()
        }
        return cell
    }
}
