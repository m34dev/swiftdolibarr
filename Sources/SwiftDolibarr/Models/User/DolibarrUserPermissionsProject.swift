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
