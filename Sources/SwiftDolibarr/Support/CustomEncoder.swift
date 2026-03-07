//
//  CustomEncoder.swift
//  SwiftDolibarr
//
//  Created by William Mead on 06/02/2026.
//

import Foundation
import OSLog

extension KeyedEncodingContainer {

	mutating func encodeIfNotEmpty(_ value: String, forKey key: KeyedEncodingContainer<K>.Key) throws {
		if !value.isEmpty {
			try self.encode(value, forKey: key)
		}
	}

	mutating func encodeIfNotZero(_ value: Int, forKey key: KeyedEncodingContainer<K>.Key) throws {
		if value != 0 {
			try self.encode(value, forKey: key)
		}
	}

	mutating func encodeIfPresentAndNotEmpty(_ value: String?, forKey key: KeyedEncodingContainer<K>.Key) throws {
		if let value {
			try encodeIfNotEmpty(value, forKey: key)
		}
	}

	mutating func encodeIfPresentAndNotZero(_ value: Int?, forKey key: KeyedEncodingContainer<K>.Key) throws {
		if let value {
			try encodeIfNotZero(value, forKey: key)
		}
	}

}
