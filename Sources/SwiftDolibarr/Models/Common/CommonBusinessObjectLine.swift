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
//  CommonBusinessObjectLine.swift
//  SwiftDolibarr
//
//  Created by William Mead on 09/02/2026.
//

import Foundation
import OSLog

public class CommonBusinessObjectLine: Equatable, Hashable, Codable, DolibarrObject {

	// MARK: - Properties

	// Required

	public var id: String
	var rang: String

	// Optional

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case id
		case rang
	}

	// MARK: - Inits

	init(
		id: String = "",
		rang: String = "",
	) {
		self.id = id
		self.rang = rang
	}

	public required init(from decoder: Decoder) throws {
		do {
			Logger.logWithoutSignal("\(Self.self).init.decode", category: .api)
			let container = try decoder.container(keyedBy: CodingKeys.self)
			id = try container.decode(String.self, forKey: .id)
			rang = try container.decode(String.self, forKey: .rang)
			Logger.logWithoutSignal("\(Self.self).init.decoded", category: .api)
		} catch let error as DecodingError {
			Logger.logDecodingError(error, decodeContext: "\(Self.self).init")
			throw error
		} catch {
			Logger.logErrorWithSignal(error, context: "\(Self.self).init", category: .api)
			throw error
		}
	}

	// MARK: - Protocol methods

	public func hash(into hasher: inout Hasher) {
		hasher.combine(id)
		hasher.combine(rang)
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encodeIfNotEmpty(id, forKey: .id)
		try container.encode(rang, forKey: .rang)
	}

	static public func == (lhs: CommonBusinessObjectLine, rhs: CommonBusinessObjectLine) -> Bool {
		lhs.id == rhs.id
	}

}
