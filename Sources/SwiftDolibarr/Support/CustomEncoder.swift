// Copyright 2026 M34D - William Mead
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// 	http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//
//  CustomEncoder.swift
//  SwiftDolibarr
//
//  Created by William Mead on 06/02/2026.
//

import Foundation

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
