//
//  Model.swift
//  DecimalConverter
//
//  Created by Ryo on 2019/12/27.
//  Copyright © 2019 Ryoga. All rights reserved.
//

import Foundation

struct Model {

    enum Radix: Int {
        case decimal = 10
        case hex = 16
        case octal = 8
        case binary = 2

        fileprivate var maxValue: UInt64 {
            switch self {
            case .decimal:
                return 9999999999999999999
            case .hex:
                return 18446744073709551615
            case .octal:
                return 9223372036854775807
            case .binary:
                return 18446744073709551615
            }
        }
    }

    public init() { }

    private(set) var decimalString: String = ""
    private(set) var hexString: String = ""
    private(set) var octalString: String = ""
    private(set) var binaryString: String = ""

    mutating func updateValue(toNumericalString string: String, radix: Radix) {
        guard !string.isEmpty else {
            decimalString = ""
            hexString = ""
            octalString = ""
            binaryString = ""
            return
        }

        let maxValueString = String(radix.maxValue, radix: radix.rawValue)
        let limitedValue: UInt64 = {
            if string.count > maxValueString.count {
                return radix.maxValue
            }
            return UInt64(string, radix: radix.rawValue) ?? radix.maxValue
        }()
        decimalString = String(limitedValue)
        hexString = String(limitedValue, radix: Radix.hex.rawValue, uppercase: true)
        octalString = String(limitedValue, radix: Radix.octal.rawValue, uppercase: true)
        binaryString = String(limitedValue, radix: Radix.binary.rawValue, uppercase: true)
    }
}
