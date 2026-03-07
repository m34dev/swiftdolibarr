//
//  CustomHasher.swift
//  SwiftDolibarr
//
//  Created by William Mead on 06/02/2026.
//

import Foundation
import OSLog

extension Hasher {

	mutating func combine<T: Hashable>(optional value: T?) {
		if let value {
			self.combine(true)
			self.combine(value)
		} else {
			self.combine(false)
		}
	}

}
