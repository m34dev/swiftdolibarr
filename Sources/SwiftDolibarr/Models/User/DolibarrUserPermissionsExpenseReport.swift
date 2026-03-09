//
//  File.swift
//  SwiftDolibarr
//
//  Created by William Mead on 09/03/2026.
//

import Foundation

struct DolibarrUserPermissionsExpenseReport: Codable, Hashable {

	// MARK: - Properties

	var lire: Int?
	var creer: Int?
	var supprimer: Int?
	var approve: Int?
	var toPaid: Int?
	var readall: Int?
	var writeallAdvance: Int?

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case lire
		case creer
		case supprimer
		case approve
		case toPaid = "to_paid"
		case readall
		case writeallAdvance = "writeall_advance"
	}

	// MARK: - Inits

	internal init(
		lire: Int?,
		creer: Int?,
		supprimer: Int?,
		approve: Int?,
		toPaid: Int?,
		readall: Int?,
		writeallAdvance: Int?
	) {
		self.lire = lire
		self.creer = creer
		self.supprimer = supprimer
		self.approve = approve
		self.toPaid = toPaid
		self.readall = readall
		self.writeallAdvance = writeallAdvance
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.lire = try container.decodeIfPresent(Int.self, forKey: .lire)
		self.creer = try container.decodeIfPresent(Int.self, forKey: .creer)
		self.supprimer = try container.decodeIfPresent(Int.self, forKey: .supprimer)
		self.approve = try container.decodeIfPresent(Int.self, forKey: .approve)
		self.toPaid = try container.decodeIfPresent(Int.self, forKey: .toPaid)
		self.readall = try container.decodeIfPresent(Int.self, forKey: .readall)
		self.writeallAdvance = try container.decodeIfPresent(Int.self, forKey: .writeallAdvance)
	}

}
