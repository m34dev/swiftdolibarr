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
