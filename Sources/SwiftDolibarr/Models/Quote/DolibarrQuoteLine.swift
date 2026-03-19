// Copyright 2026 M34D - William Mead
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// 	http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//
//  DolibarrQuoteLine.swift
//  SwiftDolibarr
//
//  Created by William Mead on 13/08/2025.
//

import Foundation
import OSLog

/// A single line item within a Dolibarr quote.
///
/// Each line references its parent quote via ``quoteId`` and inherits
/// pricing, tax, and product details from ``CommonCommercialTransactionObjectLine``.
///
/// - Note: Requires the **Propal** module to be activated in Dolibarr.
/// - SeeAlso: ``DolibarrQuote``
@Observable public final class DolibarrQuoteLine: CommonCommercialTransactionObjectLine {

	// MARK: - Properties

	/// Associated quote ID
	///
	/// - Mapped Dolibarr property: **fk_propal**
	public var quoteId: String

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case quoteId = "fk_propal"
	}

	// MARK: - Inits

	public init(
		quoteId: String = "",
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
		self.quoteId = quoteId
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

	public required init(from decoder: Decoder) throws {
		do {
			Logger.logWithoutSignal("\(Self.self).init.decode", category: .api)
			let container = try decoder.container(keyedBy: CodingKeys.self)
			quoteId = try container.decode(String.self, forKey: .quoteId)
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

	override public func hash(into hasher: inout Hasher) {
		hasher.combine(quoteId)
		super.hash(into: &hasher)
	}

	override public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(quoteId, forKey: .quoteId)
		try super.encode(to: encoder)
	}

}
