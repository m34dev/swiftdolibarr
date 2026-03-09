//
//  File.swift
//  SwiftDolibarr
//
//  Created by William Mead on 09/03/2026.
//

import Foundation

struct DolibarrUserPermissionsInvoice: Codable, Hashable {

	// MARK: - Properties

	var lire: Int?
	var creer: Int?
	var invoiceAdvance: [String: Int]?
	var paiement: Int?
	var supprimer: Int?

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case lire
		case creer
		case invoiceAdvance = "invoice_advance"
		case paiement
		case supprimer
	}

	// MARK: - Inits

	internal init(lire: Int?, creer: Int?, invoiceAdvance: [String: Int]?, paiement: Int?, supprimer: Int?) {
		self.lire = lire
		self.creer = creer
		self.invoiceAdvance = invoiceAdvance
		self.paiement = paiement
		self.supprimer = supprimer
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.lire = try container.decodeIfPresent(Int.self, forKey: .lire)
		self.creer = try container.decodeIfPresent(Int.self, forKey: .creer)
		self.invoiceAdvance = try container.decodeIfPresent([String: Int].self, forKey: .invoiceAdvance)
		self.paiement = try container.decodeIfPresent(Int.self, forKey: .paiement)
		self.supprimer = try container.decodeIfPresent(Int.self, forKey: .supprimer)
	}

}
