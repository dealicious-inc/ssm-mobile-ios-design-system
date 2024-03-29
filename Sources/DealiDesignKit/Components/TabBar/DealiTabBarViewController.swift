//
//  DealiTabBarViewController.swift
//  
//
//  Created by Hoji on 3/29/24.
//

import UIKit

struct DealiTabBarViewControllerPreset {
    var tabbarPreset: DealiTabBarPreset
}

open class DealiTabBarViewController: UIViewController {
    
    private let preset: DealiTabBarViewControllerPreset
    
    private var tabbarView: DealiTabBarView!
    private let contentScrollView = UIScrollView()
    private let contentStackView = UIStackView()
    
    var barItemArray: [DealiTabBarItem] = []
    
    init(preset: DealiTabBarViewControllerPreset) {
        self.preset = preset
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    open override func loadView() {
        super.loadView()
        
        self.tabbarView = DealiTabBarView(preset: self.preset.tabbarPreset)
        self.view.addSubview(self.tabbarView)
        self.tabbarView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        self.view.addSubview(self.contentScrollView)
        self.contentScrollView.then {
            $0.bounces = false
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.isPagingEnabled = true
//            $0.delegate = self
//            $0.isScrollEnabled = self.isScrollEnabled
        }.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(tabbarView.snp.bottom).offset(0)
        }
        
        let contentView = UIView()
        self.contentScrollView.addSubview(contentView)
        contentView.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        contentView.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .horizontal
            $0.spacing = 0.0
            $0.distribution = .fill
            $0.alignment = .fill
        }.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private func clear() {
        self.contentStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        self.children.forEach { viewController in
            viewController.willMove(toParent: nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParent()
        }
        
        
    }
    
    public func setTabbarItems(tabbarItemArray: [DealiTabBarItem]) {
        self.clear()
        
        self.barItemArray = tabbarItemArray
        
        self.tabbarView.setTabbarItems(tabbarItemArray: self.barItemArray)
        
        for index in 0..<self.barItemArray.count {
            guard let childViewController = self.barItemArray[index].viewController, let view = childViewController.view else { continue }
            self.addChild(childViewController)
            self.barItemArray[index].page = index
            
            self.contentStackView.addArrangedSubview(view)
            view.snp.makeConstraints {
                $0.size.equalTo(contentScrollView)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
