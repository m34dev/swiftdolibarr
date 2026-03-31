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
//  DolibarrUserPermissionsStock.swift
//  SwiftDolibarr
//
//  Created by William Mead on 09/03/2026.
//

import Foundation

/// Stock module permissions for a Dolibarr user.
///
/// - SeeAlso: ``DolibarrUserPermissions``
public struct DolibarrUserPermissionsStock: Codable, Hashable {

	// MARK: - Properties

	public var lire: Int?
	public var creer: Int?
	public var supprimer: Int?
	public var mouvement: [String: Int]?
	public var inventoryAdvance: [String: Int]?

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case lire
		case creer
		case supprimer
		case mouvement
		case inventoryAdvance = "inventory_advance"
	}

	// MARK: - Inits

	public init(
		lire: Int? = nil,
		creer: Int? = nil,
		supprimer: Int? = nil,
		mouvement: [String: Int]? = nil,
		inventoryAdvance: [String: Int]? = nil
	) {
		self.lire = lire
		self.creer = creer
		self.supprimer = supprimer
		self.mouvement = mouvement
		self.inventoryAdvance = inventoryAdvance
	}

	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.lire = try container.decodeIfPresent(Int.self, forKey: .lire)
		self.creer = try container.decodeIfPresent(Int.self, forKey: .creer)
		self.supprimer = try container.decodeIfPresent(Int.self, forKey: .supprimer)
		self.mouvement = try container.decodeIfPresent([String: Int].self, forKey: .mouvement)
		self.inventoryAdvance = try container.decodeIfPresent([String: Int].self, forKey: .inventoryAdvance)
	}

}
