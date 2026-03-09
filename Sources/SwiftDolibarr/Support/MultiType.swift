//
//  MultiType.swift
//  SwiftDolibarr
//
//  Created by William Mead on 06/05/2025.
//

import Foundation
import OSLog

enum MultiType: Codable, Hashable {

    // MARK: - Cases

    case string(String)
    case int(Int)
	case double(Double)

    // MARK: - Properties

    var stringValue: String {
        switch self {
        case .string(let value):
            return value
        case .int(let value):
            return String(value)
        case .double(let value):
			return String(value)
        }
    }

    var intValue: Int? {
        switch self {
        case .string(let value):
            return Int(value)
        case .int(let value):
            return value
        case .double(let value):
			return Int(value)
        }
    }

	var doubleValue: Double? {
		switch self {
		case .string(let value):
			return Double(value)
		case .int(let value):
			return Double(value)
		case .double(let value):
			return value
		}
	}

    // MARK: - Inits

    init() {
        self = .string("")
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(String.self) {
            self = .string(value)
            return
		} else if let value = try? container.decode(Int.self) {
			self = .int(value)
			return
		} else if let value = try? container.decode(Double.self) {
			self = .double(value)
			return
        } else {
            self = .string("")
            return
        }
    }

    // MARK: - Protocol methods

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let value):
            try container.encode(value)
        case .int(let value):
            try container.encode(value)
        case .double(let value):
			try container.encode(value)
        }
    }

}
