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
//  DolibarrUserPermissionsBarcode.swift
//  SwiftDolibarr
//
//  Created by William Mead on 09/03/2026.
//

import Foundation

/// Barcode module permissions for a Dolibarr user.
///
/// - SeeAlso: ``DolibarrUserPermissions``
public struct DolibarrUserPermissionsBarcode: Codable, Hashable {

	// MARK: - Properties

	public var read: Int?
	public var lireAdvance: Int?
	public var creerAdvance: Int?

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case read
		case lireAdvance = "lire_advance"
		case creerAdvance = "creer_advance"
	}

	// MARK: - Inits

	public init(read: Int? = nil, lireAdvance: Int? = nil, creerAdvance: Int? = nil) {
		self.read = read
		self.lireAdvance = lireAdvance
		self.creerAdvance = creerAdvance
	}

	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.read = try container.decodeIfPresent(Int.self, forKey: .read)
		self.lireAdvance = try container.decodeIfPresent(Int.self, forKey: .lireAdvance)
		self.creerAdvance = try container.decodeIfPresent(Int.self, forKey: .creerAdvance)
	}

}
