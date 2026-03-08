//
//  CommonCommercialTransactionObject.swift
//  SwiftDolibarr
//
//  Created by William Mead on 09/02/2026.
//

import Foundation
import OSLog

class CommonCommercialTransactionObject: CommonBusinessObject, CommercialTransaction {

	// MARK: - Properties

	// Required

	var thirdPartyId: String
	var ref: String
	var totalExclTax: String
	var totalTax: String
	var totalInclTax: String

	// Optional

	var multicurrencyCode: String?
	var linkedObjectsIds: [String: [String: String]]?

	// Computed

	var linkedQuotesIds: [String: String]? {
		return linkedObjectsIds?["propal"]
	}

	var linkedOrdersIds: [String: String]? {
		return linkedObjectsIds?["commande"]
	}

	var linkedInterventionIds: [String: String]? {
		return linkedObjectsIds?["fichinter"]
	}

	var linkedInvoiceIds: [String: String]? {
		return linkedObjectsIds?["facture"]
	}

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case thirdPartyId = "socid"
		case ref = "ref"
		case totalExclTax = "total_ht"
		case totalTax = "total_tva"
		case totalInclTax = "total_ttc"
		case multicurrencyCode = "multicurrency_code"
		case linkedObjectsIds = "linkedObjectsIds"
	}

	// MARK: - Inits

	init(
		thirdPartyId: String = "",
		statusCode: String = "",
		ref: String = "",
		totalExclTax: String = "0.00",
		totalTax: String = "0.00",
		totalInclTax: String = "0.00",
		multicurrencyCode: String? = nil,
		linkedObjectsIds: [String: [String: String]]? = nil,
		id: String = "",
		arrayOptions: [String: MultiType]? = nil,
		notePublic: String? = nil,
		notePrivate: String? = nil
	) {
		self.thirdPartyId = thirdPartyId
		self.ref = ref
		self.totalExclTax = totalExclTax
		self.totalTax = totalTax
		self.totalInclTax = totalInclTax
		self.multicurrencyCode = multicurrencyCode
		self.linkedObjectsIds = linkedObjectsIds
		super.init(id: id, statusCode: statusCode, arrayOptions: arrayOptions, notePublic: notePublic, notePrivate: notePrivate)
	}

	required init(from decoder: any Decoder) throws {
		do {
			Logger.logWithoutSignal("\(Self.self).init.decode", category: .api)
			let container = try decoder.container(keyedBy: CodingKeys.self)
			self.thirdPartyId = try container.decode(String.self, forKey: .thirdPartyId)
			self.ref = try container.decode(String.self, forKey: .ref)
			self.totalExclTax = try container.decode(MultiType.self, forKey: .totalExclTax).stringValue
			self.totalTax = try container.decode(MultiType.self, forKey: .totalTax).stringValue
			self.totalInclTax = try container.decode(MultiType.self, forKey: .totalInclTax).stringValue
			self.multicurrencyCode = try container.decodeIfPresent(String.self, forKey: .multicurrencyCode)
			if let dictlinkedObjectsIds = try? container.decode([String: [String: String]].self, forKey: .linkedObjectsIds) {
				self.linkedObjectsIds = dictlinkedObjectsIds
			} else {
				self.linkedObjectsIds = nil
			}
			try super.init(from: decoder)
			Logger.logWithoutSignal("\(Self.self).init.decoded", category: .api)
		} catch let error as DecodingError {
			Logger.logDecodingError(error, decodeContext: "\(Self.self).init")
			throw error
		} catch {
			Logger.logErrorWithSignal(error, context: "\(Self.self).init", category: .api)
			throw error
		}
	}

	// MARK: - Protocol methods

	override func hash(into hasher: inout Hasher) {
		hasher.combine(thirdPartyId)
		hasher.combine(ref)
		hasher.combine(totalExclTax)
		hasher.combine(totalTax)
		hasher.combine(totalInclTax)
		hasher.combine(optional: multicurrencyCode)
		hasher.combine(optional: linkedObjectsIds)
		super.hash(into: &hasher)
	}

	override func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encodeIfNotEmpty(thirdPartyId, forKey: .thirdPartyId)
		try container.encodeIfNotEmpty(ref, forKey: .ref)
		try container.encode(totalExclTax, forKey: .totalExclTax)
		try container.encode(totalTax, forKey: .totalTax)
		try container.encode(totalInclTax, forKey: .totalInclTax)
		try container.encodeIfPresent(multicurrencyCode, forKey: .multicurrencyCode)
		try container.encodeIfPresent(linkedObjectsIds, forKey: .linkedObjectsIds)
		try super.encode(to: encoder)
	}

}
