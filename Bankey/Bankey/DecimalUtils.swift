//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Damir Aliyev on 10.08.2022.
//

import Foundation

extension Decimal{
    var doubleValue: Double{
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
