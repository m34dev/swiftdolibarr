//
//  CommonBusinessObject.swift
//  SwiftDolibarr
//
//  Created by William Mead on 11/11/2025.
//

import Foundation
import OSLog

class CommonBusinessObject: Equatable, Codable, DolibarrBusinessObject {

	// MARK: - Properties

	var id: String
	var statusCode: String
	var entityId: String?
	var arrayOptions: [String: MultiType]?
	var notePublic: String?
	var notePrivate: String?

	// Computed

	var status: DolibarrObjectStatus {
		return .unknown
	}

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case id
		case statusCode = "status"
		case statusCodeLegacy = "statut"
		case entityId = "entity"
		case arrayOptions = "array_options"
		case notePublic = "note_public"
		case notePrivate = "note_private"
	}

	// MARK: - Inits

	init(
		id: String = "",
		statusCode: String = "",
		entityId: String? = nil,
		arrayOptions: [String: MultiType]? = nil,
		notePublic: String? = nil,
		notePrivate: String? = nil
	) {
		self.id = id
		self.statusCode = statusCode
		self.entityId = entityId
		self.arrayOptions = arrayOptions
		self.notePublic = notePublic
		self.notePrivate = notePrivate
	}

	required init(from decoder: any Decoder) throws {
		do {
			Logger.logWithoutSignal("\(Self.self).init.decode", category: .api)
			let container = try decoder.container(keyedBy: CodingKeys.self)
			self.id = try container.decode(String.self, forKey: .id)
			if let status = try? container.decode(MultiType.self, forKey: .statusCode), !status.stringValue.isEmpty {
				self.statusCode = status.stringValue
			} else if let status = try? container.decode(MultiType.self, forKey: .statusCodeLegacy),
				!status.stringValue.isEmpty {
				self.statusCode = status.stringValue
			} else {
				self.statusCode = ""
			}
			self.entityId = try container.decodeIfPresent(String.self, forKey: .entityId)
			if let dictArrayOptions = try? container.decode([String: MultiType].self, forKey: .arrayOptions) {
				self.arrayOptions = dictArrayOptions
			} else {
				self.arrayOptions = nil
			}
			self.notePublic = try container.decodeIfPresent(String.self, forKey: .notePublic)
			self.notePrivate = try container.decodeIfPresent(String.self, forKey: .notePrivate)
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
		hasher.combine(statusCode)
		hasher.combine(optional: entityId)
		hasher.combine(optional: notePublic)
		hasher.combine(optional: notePrivate)
	}

	func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encodeIfNotEmpty(id, forKey: .id)
		try container.encodeIfNotEmpty(statusCode, forKey: .statusCode)
		try container.encodeIfPresentAndNotEmpty(entityId, forKey: .entityId)
		try container.encodeIfPresent(notePublic, forKey: .notePublic)
		try container.encodeIfPresent(notePrivate, forKey: .notePrivate)
	}

	static func == (lhs: CommonBusinessObject, rhs: CommonBusinessObject) -> Bool {
		lhs.id == rhs.id
	}

}
