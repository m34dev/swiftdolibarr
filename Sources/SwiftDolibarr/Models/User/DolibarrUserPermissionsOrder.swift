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
//  DolibarrUserPermissionsOrder.swift
//  SwiftDolibarr
//
//  Created by William Mead on 09/03/2026.
//

import Foundation

struct DolibarrUserPermissionsOrder: Codable, Hashable {

	// MARK: - Properties

	var lire: Int?
	var creer: Int?
	var supprimer: Int?
	var orderAdvance: [String: Int]?

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case lire
		case creer
		case supprimer
		case orderAdvance = "order_advance"
	}

	// MARK: - Inits

	internal init(
		lire: Int? = nil,
		creer: Int? = nil,
		supprimer: Int? = nil,
		orderAdvance: [String: Int]? = nil
	) {
		self.lire = lire
		self.creer = creer
		self.supprimer = supprimer
		self.orderAdvance = orderAdvance
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.lire = try container.decodeIfPresent(Int.self, forKey: .lire)
		self.creer = try container.decodeIfPresent(Int.self, forKey: .creer)
		self.supprimer = try container.decodeIfPresent(Int.self, forKey: .supprimer)
		self.orderAdvance = try container.decodeIfPresent([String: Int].self, forKey: .orderAdvance)
	}

}
