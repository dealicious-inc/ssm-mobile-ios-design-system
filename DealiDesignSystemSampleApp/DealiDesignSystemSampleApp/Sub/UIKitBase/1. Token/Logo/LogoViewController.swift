//
//  LogoViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 8/24/26.
//  Copyright © 2026 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

/**
 설명: 디자인시스템에 등록된 로고 이미지를 확인하는 VC
 */
final class LogoViewController: UIViewController {

    /// 노출할 로고 이미지. 이름이 `_w`로 끝나는 화이트 로고는 어두운 배경 위에 노출된다
    private let logoImageList: [DesignSystemImage] = [
        DealiIcon.img_logo_mk_kr_p,
        DealiIcon.img_logo_mk_kr_w,
        DealiIcon.img_logo_mk_cn_p,
        DealiIcon.img_logo_mk_cn_w,
        DealiIcon.img_logo_mks_kr_p,
        DealiIcon.img_logo_mks_kr_w,
        DealiIcon.img_logo_mks_en_p,
        DealiIcon.img_logo_mks_en_w,
        DealiIcon.img_logo_ad_kr_p,
        DealiIcon.img_logo_ad_kr_w,
        DealiIcon.img_logo_st_kr_p,
        DealiIcon.img_logo_st_kr_w,
        DealiIcon.img_logo_symbol_p,
        DealiIcon.img_logo_symbol_w
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Logo"
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
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        let contentStackView = UIStackView()
        contentView.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.spacing = 20.0
            $0.alignment = .fill
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(20.0)
        }

        for logoImage in self.logoImageList {
            let logoItemView = LogoItemView(logoImage: logoImage)
            contentStackView.addArrangedSubview(logoItemView)
            logoItemView.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
        }
    }
}

private final class LogoItemView: UIView {

    init(logoImage: DesignSystemImage) {
        super.init(frame: .zero)

        let isWhiteLogo = logoImage.name.hasSuffix("_w")

        let nameLabel = UILabel()
        self.addSubview(nameLabel)
        nameLabel.then {
            $0.text = logoImage.name
            $0.font = .b3r13
            $0.textColor = .g80
        }.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }

        let logoBackgroundView = UIView()
        self.addSubview(logoBackgroundView)
        logoBackgroundView.then {
            $0.backgroundColor = (isWhiteLogo ? .g100 : .g10)
            $0.layer.cornerRadius = 6.0
            $0.clipsToBounds = true
        }.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8.0)
            $0.left.right.bottom.equalToSuperview()
        }

        let logoImageView = UIImageView()
        logoBackgroundView.addSubview(logoImageView)
        logoImageView.then {
            $0.image = logoImage.image
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20.0)
            $0.left.right.equalToSuperview().inset(20.0)
            $0.height.equalTo(60.0)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
