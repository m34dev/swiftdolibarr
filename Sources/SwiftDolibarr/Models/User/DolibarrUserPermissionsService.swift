//
//  DolibarrUserPermissionsService.swift
//  SwiftDolibarr
//
//  Created by William Mead on 09/03/2026.
//

import Foundation

struct DolibarrUserPermissionsService: Codable, Hashable {

	// MARK: - Properties

	var lire: Int?
	var creer: Int?
	var supprimer: Int?
	var serviceAdvance: [String: Int]?

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case lire
		case creer
		case supprimer
		case serviceAdvance = "service_advance"
	}

	// MARK: - Inits

	internal init(lire: Int? = nil, creer: Int? = nil, supprimer: Int? = nil, serviceAdvance: [String: Int]? = nil) {
		self.lire = lire
		self.creer = creer
		self.supprimer = supprimer
		self.serviceAdvance = serviceAdvance
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.lire = try container.decodeIfPresent(Int.self, forKey: .lire)
		self.creer = try container.decodeIfPresent(Int.self, forKey: .creer)
		self.supprimer = try container.decodeIfPresent(Int.self, forKey: .supprimer)
		self.serviceAdvance = try container.decodeIfPresent([String: Int].self, forKey: .serviceAdvance)
	}

}
