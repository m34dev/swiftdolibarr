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
//  DolibarrUserPermissionsService.swift
//  SwiftDolibarr
//
//  Created by William Mead on 09/03/2026.
//

import Foundation

/// Service module permissions for a Dolibarr user.
///
/// - SeeAlso: ``DolibarrUserPermissions``
public struct DolibarrUserPermissionsService: Codable, Hashable {

	// MARK: - Properties

	public var lire: Int?
	public var creer: Int?
	public var supprimer: Int?
	public var serviceAdvance: [String: Int]?

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case lire
		case creer
		case supprimer
		case serviceAdvance = "service_advance"
	}

	// MARK: - Inits

	public init(lire: Int? = nil, creer: Int? = nil, supprimer: Int? = nil, serviceAdvance: [String: Int]? = nil) {
		self.lire = lire
		self.creer = creer
		self.supprimer = supprimer
		self.serviceAdvance = serviceAdvance
	}

	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.lire = try container.decodeIfPresent(Int.self, forKey: .lire)
		self.creer = try container.decodeIfPresent(Int.self, forKey: .creer)
		self.supprimer = try container.decodeIfPresent(Int.self, forKey: .supprimer)
		self.serviceAdvance = try container.decodeIfPresent([String: Int].self, forKey: .serviceAdvance)
	}

}
