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
//  DolibarrUserPermissionsProject.swift
//  SwiftDolibarr
//
//  Created by William Mead on 09/03/2026.
//

import Foundation

struct DolibarrUserPermissionsProject: Codable, Hashable {

	// MARK: - Properties

	var lire: Int?
	var creer: Int?
	var supprimer: Int?
	var all: [String: Int]?
	var time: Int?

	// MARK: - Inits

	internal init(
		lire: Int? = nil,
		creer: Int? = nil,
		supprimer: Int? = nil,
		all: [String: Int]? = nil,
		time: Int? = nil
	) {
		self.lire = lire
		self.creer = creer
		self.supprimer = supprimer
		self.all = all
		self.time = time
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.lire = try container.decodeIfPresent(Int.self, forKey: .lire)
		self.creer = try container.decodeIfPresent(Int.self, forKey: .creer)
		self.supprimer = try container.decodeIfPresent(Int.self, forKey: .supprimer)
		self.all = try container.decodeIfPresent([String: Int].self, forKey: .all)
		self.time = try container.decodeIfPresent(Int.self, forKey: .time)
	}

}
