//
//  CountStepperViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 7/7/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit
import RxSwift
import RxCocoa
import SwiftUI
import Combine

final class CountStepperViewController: UIViewController {

    private let countStepper = DealiCountStepper()
    private let disabledCountStepper = DealiCountStepper()
    private let disposeBag = DisposeBag()
    
    private var isSwiftUI: Bool = false
    
    init(isSwiftUI: Bool = false) {
        self.isSwiftUI = isSwiftUI
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "CountStepper Component"
        self.view.backgroundColor = .primary04
        
        self.countStepper.changeCountAction.asSignal().emit(with: self, onNext: { owner, selectCount in
            print("count = \(selectCount)")
        }).disposed(by: self.disposeBag)
    }
    
    override func loadView() {
        super.loadView()
        
        if self.isSwiftUI {
            let swiftUIView = self.swiftUIView()
            self.view.addSubview(swiftUIView)
            
            swiftUIView.snp.makeConstraints {
                $0.top.horizontalEdges.equalToSuperview().offset(30)
                $0.bottom.equalToSuperview()
            }
        } else {
            self.view.addSubview(self.countStepper)
            self.countStepper.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
            
            self.view.addSubview(self.disabledCountStepper)
            self.disabledCountStepper.then {
                $0.isEnabled = false
                $0.currentCount = 5
            }.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(self.countStepper.snp.bottom).offset(20)
            }
        }
    }
    
    func swiftUIView() -> UIView {
        return PublishTestView()
        .toUIView(embeddedIn: self)
        .view
    }
}

struct CountStepperPreview: View {
    @StateObject var vm = CountStepperViewModel(
        value: 100, isEnabled: true, minValue: 99, maxValue: 101, acceptCountWhenEditingDidEnd: false
    )

    var body: some View {
        VStack {
            CountStepperView(viewModel: vm)
            Text("\(vm.value)")   // ✅ 같은 vm을 관찰하므로 값 변경 시 자동 갱신
        }
    }
}

final class PublishTestViewModel: ObservableObject {
    @Published var value: Int {
        didSet {
            print(self.value)
            self.checkBoxViewModel.isSelected = self.value > 5
        }
    }
    var checkBoxViewModel: CheckboxViewModel
    
    init(value: Int) {
        self.value = value
        self.checkBoxViewModel = CheckboxViewModel(isSelected: false)
    }
}

struct PublishTestView: View {
    @ObservedObject var vm = PublishTestViewModel(value: 0)
    
    var body: some View {
        VStack {
            CountStepperView(viewModel: CountStepperViewModel(
                value: vm.value,
                isEnabled: true,
                minValue: 0,
                maxValue: 10,
                acceptCountWhenEditingDidEnd: false
            )) {
                vm.value = $0
            }
            Text("\(vm.value)")
            CheckboxView(label: "5 이상 선택됨", viewModel: vm.checkBoxViewModel)
        }
    }
}

#Preview {
    PublishTestView()
}
