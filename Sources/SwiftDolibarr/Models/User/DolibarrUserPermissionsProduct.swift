//
//  DolibarrUserPermissionsProduct.swift
//  SwiftDolibarr
//
//  Created by William Mead on 09/03/2026.
//

import Foundation

struct DolibarrUserPermissionsProduct: Codable, Hashable {

	// MARK: - Properties

	var lire: Int?
	var creer: Int?
	var supprimer: Int?
	var productAdvance: [String: Int]?

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case lire
		case creer
		case supprimer
		case productAdvance = "product_advance"
	}

	// MARK: - Inits

	internal init(lire: Int? = nil, creer: Int? = nil, supprimer: Int? = nil, productAdvance: [String: Int]? = nil) {
		self.lire = lire
		self.creer = creer
		self.supprimer = supprimer
		self.productAdvance = productAdvance
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.lire = try container.decodeIfPresent(Int.self, forKey: .lire)
		self.creer = try container.decodeIfPresent(Int.self, forKey: .creer)
		self.supprimer = try container.decodeIfPresent(Int.self, forKey: .supprimer)
		self.productAdvance = try container.decodeIfPresent([String: Int].self, forKey: .productAdvance)
	}

}
