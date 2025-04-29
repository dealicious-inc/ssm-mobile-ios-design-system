//
//  SwiftUIView.swift
//  DealiDesignKit
//
//  Created by 이창호 on 4/28/25.
//

import SwiftUI

public struct Food: Identifiable {
    public var id = UUID().uuidString
    var title: String
    var description: String
    var price: String
}

public var foods = [Food(title: "피자빵", description: "피자맛이 나는 맛있는 동그란 피자빵", price: "2,500원"),
             Food(title: "메론빵", description: "메론맛이 나는 연초록색 메론빵 아주 아주 부드럽고 맛있는빵", price: "4,500원"),
             Food(title: "단팥빵", description: "팥앙금이 가득가득 꾸덕한 스타일에 단팥빵!! 진짜 너무 달콤하고 맛있어요!", price: "1,500원"),
             Food(title: "오므라이스", description: "야채와 할때 볶음밥에 노오랑 계란 지단을 덮어 맛있는 소스를 뿌려 억는 맛있는 오므라이스", price: "9,500원"),
             Food(title: "치킨", description: "바삭바삭 깨끗한 기름에 튀긴 치킨! 바삭바삭 소리가 청량함까지 느끼게 해주는 맛있는 치킨!", price: "23,000원"),
             Food(title: "족발", description: "쫄깃쫄깃 콜라겐덩어리 족발! 따뜻해도 맛난고 차가워도 맛나는 족발! 쫄깃쫄깃!", price: "34,000원")]


public struct TabModel: Identifiable {
    public var id = UUID().uuidString
    var tabTitle: String
    var foodList: [Food]
}

public var tabItems = [TabModel(tabTitle: "맛있는", foodList: foods.shuffled()),
                TabModel(tabTitle: "쫄깃한", foodList: foods.shuffled()),
                TabModel(tabTitle: "달콤한", foodList: foods.shuffled()),
                TabModel(tabTitle: "육즙이고기고기", foodList: foods.shuffled()),
                TabModel(tabTitle: "꾸덕한크림크림", foodList: foods.shuffled()),
                TabModel(tabTitle: "바삭바삭", foodList: foods.shuffled())]
