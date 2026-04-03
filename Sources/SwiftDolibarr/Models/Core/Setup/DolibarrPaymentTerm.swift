// Copyright 2026 M34D - William Mead
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//
//  DolibarrPaymentTerm.swift
//  SwiftDolibarr
//
//  Created by William Mead on 03/04/2026.
//

import Foundation
#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
import OSLog
#endif

/// A Dolibarr payment term.
///
/// Maps to the Dolibarr `/setup/dictionary/payment_terms` REST API endpoint.
/// Each payment term defines how many ``days`` a client has to pay,
/// along with a ``code``, a ``label``, a ``description``,
/// and a ``type`` indicator.
///
/// - Note: Payment terms can be assigned to invoices, orders, and quotes.
/// - SeeAlso: ``DolibarrInvoice``, ``DolibarrOrder``, ``DolibarrQuote``
public struct DolibarrPaymentTerm: Hashable, Decodable, Sendable, DolibarrObject {

	// MARK: - Properties

	/// Payment term ID.
	public var id: String

	/// Payment term code (e.g. `RECEP`, `30D`, `60D`).
	public var code: String

	/// Display label for the payment term.
	public var label: String

	/// Detailed description of the payment term.
    ///
    /// Mapped Dolibarr property: **descr**
	public var description: String

	/// Payment type indicator.
    ///
    /// Mapped Dolibarr property: **type_cdr**
	public var type: String

	/// Number of days allowed for payment.
    ///
    /// Mapped Dolibarr property: **nbjour**
	public var days: String

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case id
		case code
		case label
		case description = "descr"
		case type = "type_cdr"
		case days = "nbjour"
	}

	// MARK: - Inits

	public init(
		id: String = "",
		code: String = "",
		label: String = "",
		description: String = "",
		type: String = "",
		days: String = ""
	) {
		self.id = id
		self.code = code
		self.label = label
		self.description = description
		self.type = type
		self.days = days
	}

	public init(from decoder: any Decoder) throws {
		do {
			#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
			Logger.logWithoutSignal("\(Self.self).init.decode", category: .api)
			#endif
			let container = try decoder.container(keyedBy: CodingKeys.self)
			self.id = try container.decode(String.self, forKey: .id)
			self.code = try container.decode(String.self, forKey: .code)
			self.label = try container.decode(String.self, forKey: .label)
			self.description = try container.decode(String.self, forKey: .description)
			self.type = try container.decode(String.self, forKey: .type)
			self.days = try container.decode(String.self, forKey: .days)
			#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
			Logger.logWithoutSignal("\(Self.self).init.decoded", category: .api)
			#endif
		} catch let error as DecodingError {
			#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
			Logger.logDecodingError(error, decodeContext: "\(Self.self).init")
			#endif
			throw error
		} catch {
			#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
			Logger.logErrorWithSignal(error, context: "\(Self.self).init", category: .api)
			#endif
			throw error
		}
	}
	
}
