//
//  DolibarrUserPermissionsBarcode.swift
//  SwiftDolibarr
//
//  Created by William Mead on 09/03/2026.
//

import Foundation

struct DolibarrUserPermissionsBarcode: Codable, Hashable {

	// MARK: - Properties

	var read: Int?
	var lireAdvance: Int?
	var creerAdvance: Int?

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case read
		case lireAdvance = "lire_advance"
		case creerAdvance = "creer_advance"
	}

	// MARK: - Inits

	internal init(read: Int? = nil, lireAdvance: Int? = nil, creerAdvance: Int? = nil) {
		self.read = read
		self.lireAdvance = lireAdvance
		self.creerAdvance = creerAdvance
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.read = try container.decodeIfPresent(Int.self, forKey: .read)
		self.lireAdvance = try container.decodeIfPresent(Int.self, forKey: .lireAdvance)
		self.creerAdvance = try container.decodeIfPresent(Int.self, forKey: .creerAdvance)
	}

}
