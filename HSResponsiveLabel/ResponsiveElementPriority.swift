//
//  ResponsiveElementPriority.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/06/15.
//

import Foundation

public enum ResponsiveElementPriority {

    case required
    case high
    case low
    case custom(Int)

    var priority: Int {
        switch self {
        case .required:
            return 1000
        case .high:
            return 750
        case .low:
            return 250
        case let .custom(value):
            return value
        }
    }
}

extension ResponsiveElementPriority {
    public init?(_ rawValue: Int) {
        guard rawValue >= 0 || rawValue <= 1000 else {
            return nil
        }
        self = .custom(rawValue)
    }
}

extension ResponsiveElementPriority: Comparable {

    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.priority < rhs.priority
    }

    public static func <= (lhs: Self, rhs: Self) -> Bool {
        return lhs.priority <= rhs.priority
    }

    public static func >= (lhs: Self, rhs: Self) -> Bool {
        return lhs.priority >= rhs.priority
    }

    public static func > (lhs: Self, rhs: Self) -> Bool {
        return lhs.priority > rhs.priority
    }
}
