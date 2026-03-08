//
//  DolibarrOrderLine.swift
//  SwiftDolibarr
//
//  Created by William Mead on 18/01/2026.
//

import Foundation
import OSLog

@Observable final class DolibarrOrderLine: CommonCommercialTransactionObjectLine {

	// MARK: - Properties

	var orderId: String

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case orderId = "fk_commande"
	}

	// MARK: - Inits

	init(
		orderId: String = "",
		specialCode: String = "0",
		taxRate: String = "0.0",
		unitPriceExclTax: String = "0.0",
		unitPriceInclTax: String = "0.0",
		discountRate: String = "0.0",
		totalExclTax: String = "0.0",
		totalInclTax: String = "0.0",
		totalTax: String = "0.0",
		productId: String? = nil,
		productRef: String? = nil,
		productLabel: String? = nil,
		quantity: String? = nil,
		description: String? = nil,
		id: String = "",
		rang: String = "",
	) {
		self.orderId = orderId
		super.init(
			specialCode: specialCode,
			taxRate: taxRate,
			unitPriceExclTax: unitPriceExclTax,
			discountRate: discountRate,
			totalExclTax: totalExclTax,
			totalInclTax: totalInclTax,
			totalTax: totalTax,
			productId: productId,
			productRef: productRef,
			productLabel: productLabel,
			quantity: quantity,
			description: description,
			unitPriceInclTax: unitPriceInclTax,
			id: id,
			rang: rang,
		)
	}

	required init(from decoder: Decoder) throws {
		do {
			Logger.logWithoutSignal("\(Self.self).init.decode", level: .info, category: .api)
			let container = try decoder.container(keyedBy: CodingKeys.self)
			orderId = try container.decode(String.self, forKey: .orderId)
			try super.init(from: decoder)
			Logger.logWithoutSignal("\(Self.self).init.decoded", level: .info, category: .api)
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
		hasher.combine(orderId)
		super.hash(into: &hasher)
	}

	override func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(orderId, forKey: .orderId)
		try super.encode(to: encoder)
	}

}
