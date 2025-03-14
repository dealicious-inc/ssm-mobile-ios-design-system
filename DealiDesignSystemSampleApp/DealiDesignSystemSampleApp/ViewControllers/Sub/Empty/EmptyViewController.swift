//
//  EmptyViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by JohyeonYoon on 3/12/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import UIKit
import SwiftUI
import DealiDesignKit

final class EmptyViewController: UIViewController {

    let isSwiftUI: Bool
    
    init(isSwiftUI: Bool = false) {
        self.isSwiftUI = isSwiftUI
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = .init()
        
        let contentScrollView = UIScrollView()
        self.view.addSubview(contentScrollView)
        contentScrollView.then {
            $0.bounces = false
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        let contentView = UIView()
        contentScrollView.addSubview(contentView)
        contentView.then {
            $0.backgroundColor = .white
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        if self.isSwiftUI {
            let swiftUIView = self.swiftUIView()
            contentView.addSubview(swiftUIView)
            
            swiftUIView.snp.makeConstraints {
                $0.top.equalToSuperview().offset(30)
                $0.horizontalEdges.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Empty View"
        self.view.backgroundColor = .white

    }
}

private extension EmptyViewController {
    func swiftUIView() -> UIStackView {
        let viewModel = DLEmptyViewModel(
            iconImage: Image.dealiIcon(named: "ic_refresh_2_filled"),
            title: "타이틀이 들어가는 영역이예요.",
            subtitle: "서브타이틀이 들어가는 영역이예요.",
            buttonTitle: "재시도"
        )
        
        let testViewModels: [DLEmptyViewModel] = [
            viewModel,
            DLEmptyViewModel(
                iconImage: nil,
                subtitle: "등록된 상품이 없어요."
            ),
            DLEmptyViewModel(
                subtitle: "데이터를 불러오지 못했어요.\n네트워크 확인 후 새로고침 버튼을 눌러주세요."
            ),
            DLEmptyViewModel(
                subtitle: "데이터를 불러오지 못했어요.\n네트워크 확인 후 새로고침 버튼을 눌러주세요.",
                buttonTitle: "재시도"
            ),
            DLEmptyViewModel(
                subtitle: "데이터를 불러오지 못했어요.\n네트워크 확인 후 새로고침 버튼을 눌러주세요.",
                buttonTitle: "일이삼사오육칠팔구십일이삼사"
            )
        ]
        
        let contentStackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 30.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }
                
        testViewModels.forEach { viewModel in
            contentStackView.addArrangedSubview(
                DLEmptyView(viewModel: viewModel)
                    .UIKit()
            )
        }
        
        viewModel.setTitle("타이틀 바꿨습니다")

        return contentStackView
    }
}
