//
//  ToolTipViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by Nam Jun Lee on 12/31/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit
import SwiftUI

final class ToolTipViewController: UIViewController {
    
    private var isSwiftUI: Bool
    
    init(isSwiftUI: Bool = false) {
        self.isSwiftUI = isSwiftUI
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "ToolTip Component"
        self.view.backgroundColor = .white
    }
    
    let toolTipSuperView = UIView()
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(toolTipSuperView)
        toolTipSuperView.then {
            $0.backgroundColor = .red
        }.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(150.0)
        }
        
        let topButtonStackView = UIStackView()
        self.view.addSubview(topButtonStackView)
        topButtonStackView.then {
            $0.axis = .horizontal
            $0.spacing = 30.0
            $0.distribution = .fillEqually
        }.snp.makeConstraints {
            $0.top.equalTo(toolTipSuperView.snp.bottom).offset(50.0)
            $0.left.right.equalToSuperview().inset(50.0)
            $0.height.equalTo(50.0)
        }
        
        let bottomButtonStackView = UIStackView()
        self.view.addSubview(bottomButtonStackView)
        bottomButtonStackView.then {
            $0.axis = .horizontal
            $0.spacing = 30.0
            $0.distribution = .fillEqually
        }.snp.makeConstraints {
            $0.top.equalTo(topButtonStackView.snp.bottom).offset(50.0)
            $0.left.right.equalToSuperview().inset(50.0)
            $0.height.equalTo(50.0)
        }
        
        DealiToopTipArrowPosition.allCases.forEach {
            let button = UIButton()
            button.backgroundColor = .yellow
            button.setTitleColor(.black, for: .normal)
            switch $0 {
            case .topLeft, .topCenter, .topRight:
                button.setTitle($0.rawValue, for: .normal)
                topButtonStackView.addArrangedSubview(button)
            default:
                button.setTitle($0.rawValue, for: .normal)
                bottomButtonStackView.addArrangedSubview(button)
            }
            
            switch $0 {
            case .topLeft:
                button.addTarget(self, action: #selector(topLeftButtonPressed(_:)), for: .touchUpInside)
            case .topCenter:
                button.addTarget(self, action: #selector(topCenterButtonPressed(_:)), for: .touchUpInside)
            case .topRight:
                button.addTarget(self, action: #selector(topRightButtonPressed(_:)), for: .touchUpInside)
            case .bottomLeft:
                button.addTarget(self, action: #selector(bottomLeftButtonPressed(_:)), for: .touchUpInside)
            case .bottomCenter:
                button.addTarget(self, action: #selector(bottomCenterButtonPressed(_:)), for: .touchUpInside)
            case .bottomRight:
                button.addTarget(self, action: #selector(bottomRightButtonPressed(_:)), for: .touchUpInside)
            }
        }
    }
    
    @objc func topLeftButtonPressed(_ sender: UIButton) {
        DealiToolTip.show(
            arrowPosition: .topLeft,
            text: "Top Left",
            superView: self.view,
            outsideView: self.view,
            toolTipCondition: { return true },
            toolTipLayout: {
                $0.top.equalTo(self.toolTipSuperView.snp.bottom).offset(2.0)
                $0.centerX.equalToSuperview()
            },
            toolTipAction: {
                print("Top Left ToolTip Action")
            }
        )
    }
    
    @objc func topCenterButtonPressed(_ sender: UIButton) {
        DealiToolTip.show(
            arrowPosition: .topCenter,
            text: "Top Center",
            superView: self.view,
            outsideView: self.view,
            toolTipCondition: { return true },
            toolTipLayout: {
                $0.top.equalTo(self.toolTipSuperView.snp.bottom).offset(2.0)
                $0.centerX.equalToSuperview()
            }
        )
    }
    
    @objc func topRightButtonPressed(_ sender: UIButton) {
        if isSwiftUI {
            ToolTipView()
                .setTargetFrame(self.toolTipSuperView)
                .setArrowPosition(.left)
                .setText("Top Right")
                .show(self)
        } else {
            DealiToolTip.show(
                arrowPosition: .topRight,
                text: "Top Right",
                superView: self.view,
                outsideView: self.view,
                toolTipCondition: { return true },
                toolTipLayout: {
                    $0.top.equalTo(self.toolTipSuperView.snp.bottom).offset(2.0)
                    $0.centerX.equalToSuperview()
                }
            )
        }
    }
    
    @objc func bottomLeftButtonPressed(_ sender: UIButton) {
        DealiToolTip.show(
            arrowPosition: .bottomLeft,
            text: "Bottom Left",
            superView: self.view,
            outsideView: self.view,
            toolTipCondition: { return true },
            toolTipLayout: {
                $0.bottom.equalTo(self.toolTipSuperView.snp.top).offset(-2.0)
                $0.centerX.equalToSuperview()
            }
        )
    }
    
    @objc func bottomCenterButtonPressed(_ sender: UIButton) {
        DealiToolTip.show(
            arrowPosition: .bottomCenter,
            text: "Bottom Center",
            superView: self.view,
            outsideView: self.view,
            toolTipCondition: { return true },
            toolTipLayout: {
                $0.bottom.equalTo(self.toolTipSuperView.snp.top).offset(-2.0)
                $0.centerX.equalToSuperview()
            }
        )
    }
    
    @objc func bottomRightButtonPressed(_ sender: UIButton) {
        DealiToolTip.show(
            arrowPosition: .bottomRight,
            text: "Bottom Right",
            superView: self.view,
            outsideView: self.view,
            toolTipCondition: { return true },
            toolTipLayout: {
                $0.bottom.equalTo(self.toolTipSuperView.snp.top).offset(-2.0)
                $0.centerX.equalToSuperview()
            }
        )
    }
}
