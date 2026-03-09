//
//  DolibarrUserPermissionsThirdParty.swift
//  SwiftDolibarr
//
//  Created by William Mead on 09/03/2026.
//

import Foundation

struct DolibarrUserPermissionsThirdParty: Codable, Hashable {

	// MARK: - Properties

	var lire: Int?
	var creer: Int?
	var supprimer: Int?
	var paymentInformationAdvance: [String: Int]?
	var client: [String: Int]?
	var contact: [String: Int]?

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case lire
		case creer
		case supprimer
		case paymentInformationAdvance = "thirdparty_paymentinformation_advance"
		case client
		case contact
	}

	// MARK: - Inits

	internal init(
		lire: Int? = nil,
		creer: Int? = nil,
		supprimer: Int? = nil,
		paymentInformationAdvance: [String: Int]? = nil,
		client: [String: Int]? = nil,
		contact: [String: Int]? = nil
	) {
		self.lire = lire
		self.creer = creer
		self.supprimer = supprimer
		self.paymentInformationAdvance = paymentInformationAdvance
		self.client = client
		self.contact = contact
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.lire = try container.decodeIfPresent(Int.self, forKey: .lire)
		self.creer = try container.decodeIfPresent(Int.self, forKey: .creer)
		self.supprimer = try container.decodeIfPresent(Int.self, forKey: .supprimer)
		self.paymentInformationAdvance = try container.decodeIfPresent([String: Int].self, forKey: .paymentInformationAdvance)
		self.client = try container.decodeIfPresent([String: Int].self, forKey: .client)
		self.contact = try container.decodeIfPresent([String: Int].self, forKey: .contact)
	}

}
