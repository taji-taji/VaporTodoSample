//
//  Array+OrderSortable.swift
//  ToDoAPI
//
//  Created by tajika on 2016/09/23.
//
//

import Foundation

extension Array where Element: OrderSortable {
    func sorted(asc: Bool = true) -> Array {
        return self.sorted { (orderSortable1, orderSortable2) -> Bool in
            guard
                let order1 = orderSortable1.order,
                let order2 = orderSortable2.order
                else {
                    return false
            }
            if asc {
                return order1 < order2
            } else {
                return order1 > order2
            }
        }
    }
}
