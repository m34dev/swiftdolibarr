//
//  CommonBusinessObjectLine.swift
//  SwiftDolibarr
//
//  Created by William Mead on 09/02/2026.
//

import Foundation
import OSLog

class CommonBusinessObjectLine: Equatable, Hashable, Codable, DolibarrObject {

	// MARK: - Properties

	// Required

	var id: String
	var rang: String

	// Optional

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case id
		case rang
	}

	// MARK: - Inits

	init(
		id: String = "",
		rang: String = "",
	) {
		self.id = id
		self.rang = rang
	}

	required init(from decoder: Decoder) throws {
		do {
			Logger.logWithoutSignal("\(Self.self).init.decode", category: .api)
			let container = try decoder.container(keyedBy: CodingKeys.self)
			id = try container.decode(String.self, forKey: .id)
			rang = try container.decode(String.self, forKey: .rang)
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

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
		hasher.combine(rang)
	}

	func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encodeIfNotEmpty(id, forKey: .id)
		try container.encode(rang, forKey: .rang)
	}

	static func == (lhs: CommonBusinessObjectLine, rhs: CommonBusinessObjectLine) -> Bool {
		lhs.id == rhs.id
	}

}
