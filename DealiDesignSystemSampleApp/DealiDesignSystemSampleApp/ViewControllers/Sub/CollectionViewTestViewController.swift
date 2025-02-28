//
//  CollectionViewTestViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 조서현 on 2/28/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class CollectionViewTestViewController: UIViewController {
    
    private let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.collectionView)
        self.collectionView.then {
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = .white
            _ = ($0.collectionViewLayout as! UICollectionViewFlowLayout).then {
                $0.scrollDirection = .vertical
                $0.minimumLineSpacing = 10.0
                $0.minimumInteritemSpacing = 10.0
                $0.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            }
            $0.register(GoodsThumnailCollectionViewCell.self, forCellWithReuseIdentifier: "GoodsThumnailCollectionViewCell")
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension CollectionViewTestViewController: UICollectionViewDelegate, UICollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 600
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodsThumnailCollectionViewCell", for: indexPath) as! GoodsThumnailCollectionViewCell
        cell.configure(index: indexPath.row)
        return cell
    }
}

extension CollectionViewTestViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = CGFloat((collectionView.frame.width - 20 - 20) / 3)
        return CGSize(width: width, height: 200)
    }
}

// MARK: - ProductThumnailCollectionViewCell
final class GoodsThumnailCollectionViewCell: UICollectionViewCell {
    
    let thumnailView = GoodsThumnailTestView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .yellow
        
        let view = thumnailView.UIKit()
        self.addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(index: Int) {
        thumnailView.setGoodsInfo("index: \(index) 상품명", zzimCount: index)
    }
}
