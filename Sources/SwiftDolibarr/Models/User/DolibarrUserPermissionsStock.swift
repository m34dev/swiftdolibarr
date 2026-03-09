//
//  DolibarrUserPermissionsStock.swift
//  SwiftDolibarr
//
//  Created by William Mead on 09/03/2026.
//

import Foundation

struct DolibarrUserPermissionsStock: Codable, Hashable {

	// MARK: - Properties

	var lire: Int?
	var creer: Int?
	var supprimer: Int?
	var mouvement: [String: Int]?
	var inventoryAdvance: [String: Int]?

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case lire
		case creer
		case supprimer
		case mouvement
		case inventoryAdvance = "inventory_advance"
	}

	// MARK: - Inits

	internal init(
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

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.lire = try container.decodeIfPresent(Int.self, forKey: .lire)
		self.creer = try container.decodeIfPresent(Int.self, forKey: .creer)
		self.supprimer = try container.decodeIfPresent(Int.self, forKey: .supprimer)
		self.mouvement = try container.decodeIfPresent([String: Int].self, forKey: .mouvement)
		self.inventoryAdvance = try container.decodeIfPresent([String: Int].self, forKey: .inventoryAdvance)
	}

}
