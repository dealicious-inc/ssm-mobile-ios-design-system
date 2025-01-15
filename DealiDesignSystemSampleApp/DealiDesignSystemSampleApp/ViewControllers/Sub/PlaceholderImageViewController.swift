//
//  PlaceholderImageViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 12/23/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class PlaceholderImageViewController: UIViewController {

    private let rectanglePlaceholderImageView01 = DealiPlaceholderImageView()
    private let rectanglePlaceholderImageView02 = DealiPlaceholderImageView()
    private let rectanglePlaceholderImageView03 = DealiPlaceholderImageView()
    
    private let circlePlaceholderImageView01 = DealiPlaceholderImageView()
    private let circlePlaceholderImageView02 = DealiPlaceholderImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "DealiPlaceholderImageView Component"
        self.view.backgroundColor = .white
    }

    override func loadView() {
        super.loadView()
        
        
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
        
        let contentStackView = UIStackView()
        contentView.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.spacing =  16.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.left.right.equalToSuperview()
        }
         
        contentStackView.addArrangedSubview(self.rectanglePlaceholderImageView01)
        self.rectanglePlaceholderImageView01.then {
            $0.imageStyle = .goods
            $0.backgroundStyle = .dark
            $0.viewShape = .rectangle([])
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 50.0, height: 50.0))
        }
        
        let rectanglePlaceholderImageView02ContainerView = UIView()
        contentStackView.addArrangedSubview(rectanglePlaceholderImageView02ContainerView)
        rectanglePlaceholderImageView02ContainerView.then {
            $0.backgroundColor = .g30
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24.0)
            $0.height.equalTo(200.0)
        }
        
        rectanglePlaceholderImageView02ContainerView.addSubview(self.rectanglePlaceholderImageView02)
        self.rectanglePlaceholderImageView02.then {
            $0.imageStyle = .store
            $0.backgroundStyle = .light
        }.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10.0)
        }
        
        contentStackView.addArrangedSubview(self.circlePlaceholderImageView01)
        self.circlePlaceholderImageView01.then {
            $0.imageStyle = .goods
            $0.backgroundStyle = .dark
            $0.viewShape = .circle
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 100.0, height: 100.0))
        }
        
        let circlePlaceholderImageView02ContainerView = UIView()
        contentStackView.addArrangedSubview(circlePlaceholderImageView02ContainerView)
        circlePlaceholderImageView02ContainerView.then {
            $0.backgroundColor = .g30
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24.0)
            $0.height.equalTo(150.0)
        }
        
        circlePlaceholderImageView02ContainerView.addSubview(self.circlePlaceholderImageView02)
        self.circlePlaceholderImageView02.then {
            $0.imageStyle = .store
            $0.backgroundStyle = .light
            $0.viewShape = .circle
        }.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(25.0)
            $0.width.equalTo(100.0)
        }
        
        let imageViewWidth = (UIScreen.main.bounds.size.width - (48.0 + 24.0)) / 4.0
        
        let hRatioImageStackView = UIStackView()
        contentStackView.addArrangedSubview(hRatioImageStackView)
        hRatioImageStackView.then {
            $0.axis = .horizontal
            $0.spacing = 16.0
            $0.alignment = .leading
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(12.0)
            $0.height.equalTo(168.0)
        }
        
        // 3:4 비율 상품뷰
        hRatioImageStackView.addArrangedSubview(self.rectanglePlaceholderImageView03)
        self.rectanglePlaceholderImageView03.then {
            $0.backgroundStyle = .dark
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 126.0, height: 168.0))
        }
        
        // custom placeholder image
        let customPlaceholderImageView01 = DealiPlaceholderImageView()
        hRatioImageStackView.addArrangedSubview(customPlaceholderImageView01)
        customPlaceholderImageView01.then {
            $0.imageStyle = .custom(UIImage.dealiIcon(named: "ic_ssmk")!)
        }.snp.makeConstraints {
            $0.size.equalTo(imageViewWidth)
        }
        
        let customPlaceholderImageView02 = DealiPlaceholderImageView()
        hRatioImageStackView.addArrangedSubview(customPlaceholderImageView02)
        customPlaceholderImageView02.then {
            $0.viewShape = .circle
//            $0.imageStyle = .custom(UIImage.dealiIcon(named: "ic_pluscircle_filled")!)
            $0.imageStyle = .custom()
        }.snp.makeConstraints {
            $0.size.equalTo(imageViewWidth)
        }
        
        let hOneCornerStackView = UIStackView()
        contentStackView.addArrangedSubview(hOneCornerStackView)
        hOneCornerStackView.then {
            $0.axis = .horizontal
            $0.spacing = 16.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(12.0)
        }
        
        for i in 0..<4 {
            let phImageView = DealiPlaceholderImageView()
            hOneCornerStackView.addArrangedSubview(phImageView)
            phImageView.then {
                $0.imageStyle = ((i % 2) == 0 ? .store : .goods)
                $0.backgroundStyle = .dark
                switch i {
                case 0:
                    $0.viewShape = .rectangle(.topLeft)
                case 1:
                    $0.viewShape = .rectangle(.topRight)
                case 2:
                    $0.viewShape = .rectangle(.bottomRight)
                case 3:
                    $0.viewShape = .rectangle(.bottomLeft)
                default:
                    break
                }
                
            }.snp.makeConstraints {
                $0.size.equalTo(imageViewWidth)
            }
        }
        
        let hTwoCornerStackView = UIStackView()
        contentStackView.addArrangedSubview(hTwoCornerStackView)
        hTwoCornerStackView.then {
            $0.axis = .horizontal
            $0.spacing = 16.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(12.0)
        }
        
        for i in 0..<4 {
            let phImageView = DealiPlaceholderImageView()
            hTwoCornerStackView.addArrangedSubview(phImageView)
            phImageView.then {
                $0.imageStyle = ((i % 2) == 0 ? .store : .goods)
                $0.backgroundStyle = .dark
                switch i {
                case 0:
                    $0.viewShape = .rectangle([.topLeft, .topRight])
                case 1:
                    $0.viewShape = .rectangle([.topRight, .bottomRight])
                case 2:
                    $0.viewShape = .rectangle([.bottomRight, .bottomLeft])
                case 3:
                    $0.viewShape = .rectangle([.bottomLeft, .topLeft])
                default:
                    break
                }
                
            }.snp.makeConstraints {
                $0.size.equalTo(imageViewWidth)
            }
        }
        
        let hThreeCornerStackView = UIStackView()
        contentStackView.addArrangedSubview(hThreeCornerStackView)
        hThreeCornerStackView.then {
            $0.axis = .horizontal
            $0.spacing = 16.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(12.0)
        }
        
        for i in 0..<4 {
            let phImageView = DealiPlaceholderImageView()
            hThreeCornerStackView.addArrangedSubview(phImageView)
            phImageView.then {
                $0.imageStyle = ((i % 2) == 0 ? .store : .goods)
                $0.backgroundStyle = .dark
                switch i {
                case 0:
                    $0.viewShape = .rectangle([.topLeft, .topRight, .bottomRight])
                case 1:
                    $0.viewShape = .rectangle([.topRight, .bottomRight, .bottomLeft])
                case 2:
                    $0.viewShape = .rectangle([.bottomRight, .bottomLeft, .topLeft])
                case 3:
                    $0.viewShape = .rectangle([.bottomLeft, .topLeft, .topRight])
                default:
                    break
                }
                
            }.snp.makeConstraints {
                $0.size.equalTo(imageViewWidth)
            }
        }
    }
}
