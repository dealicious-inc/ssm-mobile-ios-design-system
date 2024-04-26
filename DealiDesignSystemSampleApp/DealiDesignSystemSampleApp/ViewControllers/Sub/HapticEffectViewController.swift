//
//  HapticEffectViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by hoji on 2024/01/03.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit
import CoreHaptics

final class HapticEffectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Haptic Effect"
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
            $0.spacing = 10.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(20.0)
        }
        
        let hapticEffectSoftButton = DealiControl.btnOutlineLargePrimary01()
        contentStackView.addArrangedSubview(hapticEffectSoftButton)
        hapticEffectSoftButton.then {
            $0.title = "Soft"
            $0.addTarget(self, action: #selector(hapticEffectSoftButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let hapticEffectRigidButton = DealiControl.btnOutlineLargePrimary01()
        contentStackView.addArrangedSubview(hapticEffectRigidButton)
        hapticEffectRigidButton.then {
            $0.title = "Rigid"
            $0.addTarget(self, action: #selector(hapticEffectRigidButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let hapticEffectMediumButton = DealiControl.btnOutlineLargePrimary01()
        contentStackView.addArrangedSubview(hapticEffectMediumButton)
        hapticEffectMediumButton.then {
            $0.title = "Medium"
            $0.addTarget(self, action: #selector(hapticEffectMediumButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let hapticEffectLightButton = DealiControl.btnOutlineLargePrimary01()
        contentStackView.addArrangedSubview(hapticEffectLightButton)
        hapticEffectLightButton.then {
            $0.title = "Light"
            $0.addTarget(self, action: #selector(hapticEffectLightButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let hapticEffectHeavyButton = DealiControl.btnOutlineLargePrimary01()
        contentStackView.addArrangedSubview(hapticEffectHeavyButton)
        hapticEffectHeavyButton.then {
            $0.title = "Heavy"
            $0.addTarget(self, action: #selector(hapticEffectHeavyButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let hapticEffectSelectionButton = DealiControl.btnOutlineLargePrimary01()
        contentStackView.addArrangedSubview(hapticEffectSelectionButton)
        hapticEffectSelectionButton.then {
            $0.title = "Selection"
            $0.addTarget(self, action: #selector(hapticEffectSelectionButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }
}

extension HapticEffectViewController {
    @objc func hapticEffectSoftButtonPressed() {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
    }
    
    @objc func hapticEffectRigidButtonPressed() {
        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
    }
    
    @objc func hapticEffectMediumButtonPressed() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    @objc func hapticEffectLightButtonPressed() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    @objc func hapticEffectHeavyButtonPressed() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
    }
    
    @objc func hapticEffectSelectionButtonPressed() {
//        UISelectionFeedbackGenerator().selectionChanged()
        
        VibrationManager.shared?.playHaptic(durations: [0.5], powers: [1.0])
        
    }
}

class VibrationManager {

    static let shared = VibrationManager()
    
    private let hapticEngine: CHHapticEngine
    private var hapticAdvancedPlayer: CHHapticAdvancedPatternPlayer? = nil /// 엔진이 패턴가지고 만드는 플레이어
    
    init?() {
        let hapticCapability = CHHapticEngine.capabilitiesForHardware()
        print("Haptic engine Creation Error: \(hapticCapability.supportsHaptics )")
        guard hapticCapability.supportsHaptics else {
            print("Haptic engine Creation Error: Not Support")
            return nil
        }
        
        do {
            hapticEngine = try CHHapticEngine()
        } catch let error {
            print("Haptic engine Creation Error: \(error)")
            return nil
        }
    }


    func stopHapric() {
        do {
            print(" 0. 진동 끄기")
            try hapticAdvancedPlayer?.stop(atTime: 0)
        } catch {
            print("Failed to stopHapric: \(error)")
        }
    }
    
    
    func playHaptic(durations: [Double], powers: [Float]) {
        do {
            print(" 0. 전에 있던 진동 끄기")
            try hapticAdvancedPlayer?.stop(atTime: 0)
            
            print(" 1. 패턴만들기")
            let pattern = try makePattern(durations: durations, powers: powers)
            
            print(" 2. 엔진시작, 플레이어 만들기")
            try hapticEngine.start()
            hapticAdvancedPlayer = try hapticEngine.makeAdvancedPlayer(with: pattern)
            hapticAdvancedPlayer?.loopEnabled = false
            hapticAdvancedPlayer?.playbackRate = 1.0
            
            print(" 3. 플레이어 시작")
            try hapticAdvancedPlayer?.start(atTime: 0)
        } catch {
            print("Failed to playHaptic: \(error)")
        }
    }
    
    /// duration 단위 : second(초)
    /// power 단위 : 0.0 ~ 1.0
    private func makePattern(durations: [Double], powers: [Float]) throws -> CHHapticPattern {
        
        var events: [CHHapticEvent] = []
        var relativeTime = 0.0
        
        durations.enumerated().forEach {
            let duration = $0.element
            let power = powers[$0.offset]
            
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: power)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.6)
            
            let params = [intensity, sharpness]
    
            let event = CHHapticEvent(eventType: .hapticContinuous, parameters: params, relativeTime: relativeTime, duration: duration)
            relativeTime += duration
            events.append(event)
        }
        
        return try CHHapticPattern(events: events, parameters: [])
    }
    
}
