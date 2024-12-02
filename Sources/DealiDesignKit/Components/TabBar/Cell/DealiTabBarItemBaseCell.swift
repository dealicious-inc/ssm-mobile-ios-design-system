//
//  DealiTabBarItemBaseCell.swift
//  
//
//  Created by 이창호 on 11/4/24.
//

import UIKit
import Kingfisher
import RxSwift

public enum EDealiTabBarItemCellSelectionStyle {
    case none
    case alpha
}

public class DealiTabBarItemBaseCell: UICollectionViewCell {
    /// Kingfisher DownloadTask
    var kfTask: DownloadTask?
    var disposedBag = DisposeBag()
    
    var selectionStyle: EDealiTabBarItemCellSelectionStyle = .alpha
    
    public override var isHighlighted: Bool {
        didSet {
            if self.selectionStyle == .alpha {
                self.contentView.alpha = (self.isHighlighted ? 0.3 : 1)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isExclusiveTouch = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        if let task = self.kfTask {
            task.cancel()
        }
        
        self.disposedBag = DisposeBag()
    }
}
