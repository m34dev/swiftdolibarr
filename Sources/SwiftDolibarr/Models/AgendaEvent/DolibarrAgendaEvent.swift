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
//  DolibarrAgendaEvent.swift
//  SwiftDolibarr
//
//  Created by William Mead on 17/06/2025.
//

import Foundation
#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
import OSLog
#endif

/// A Dolibarr agenda event object.
///
/// Maps to the Dolibarr `/agendaevents` REST API endpoint. Represents
/// calendar events that can be linked to third parties, users, and
/// other business objects.
///
/// ## Overview
///
/// Each event has a ``progress`` percentage that drives its ``status``,
/// start/end dates, assigned users, and an optional linked element.
///
/// - Note: Requires the **Agenda** module to be activated in Dolibarr.
/// - SeeAlso: ``DolibarrAgendaEventUserAssigned``
@Observable public final class DolibarrAgendaEvent: CommonBusinessObject {

	// MARK: - Properties

	// Required

	/// Agenda event reference
	public var ref: String

	/// Agenda event label
	public var label: String

	/// Agenda event progress percentage
	///
	/// - Mapped Dolibarr property: **percentage**
	public var progress: String

	/// Agenda event full day flag
	///
	/// - Mapped Dolibarr property: **fulldayevent**
	public var fullDayEvent: String

	/// Agenda event visibility (not yet implemented in Dolibarr)
	public var visibility: String?

	// Optional

	/// Agenda event type ID
	///
	/// - Mapped Dolibarr property: **type_id**
	public var typeId: String?

	/// Agenda event type
	public var type: String?

	/// Agenda event type code
	///
	/// - Mapped Dolibarr property: **type_code**
	public var typeCode: String?

	/// Agenda event code
	public var code: String?

	/// Agenda event creation date (Unix timestamp)
	///
	/// - Mapped Dolibarr property: **datec**
	public var dateCreated: Int?

	/// Agenda event modification date (Unix timestamp)
	///
	/// - Mapped Dolibarr property: **datem**
	public var dateModified: Int?

	/// Agenda event start date (Unix timestamp)
	///
	/// - Mapped Dolibarr property: **datep**
	public var dateStart: Int?

	/// Agenda event end date (Unix timestamp)
	///
	/// - Mapped Dolibarr property: **datef**
	public var dateEnd: Int?

	/// Agenda event author ID
	///
	/// - Mapped Dolibarr property: **authorid**
	public var authorId: String?

	/// Agenda event last modifier user ID
	///
	/// - Mapped Dolibarr property: **usermodid**
	public var userModifiedId: String?

	/// Agenda event location
	public var location: String?

	/// Associated third party ID
	///
	/// - Mapped Dolibarr property: **socid**
	public var thirdPartyId: String?

	/// Agenda event priority
	public var priority: String?

	/// Agenda event assigned users
	///
	/// - Mapped Dolibarr property: **userassigned**
	public var usersAssigned: [String: DolibarrAgendaEventUserAssigned]?

	/// Agenda event owner user ID
	///
	/// - Mapped Dolibarr property: **userownerid**
	public var userOwnerId: String?

	/// Associated element ID
	///
	/// - Mapped Dolibarr property: **elementid**
	public var elementId: String?

	/// Associated element type
	///
	/// - Mapped Dolibarr property: **elementtype**
	public var elementType: String?

	// Computed

	/// Associated agenda event status type
	override public var status: DolibarrObjectStatus {
		if let progressValue = Int(progress) {
			switch progressValue {
			case -1:
				return .agendaEventNA
			case 0:
				return .agendaEventToDo
			case 1...99:
				return .agendaEventInProgress
			case 100:
				return .agendaEventFinished
			default:
				return .unknown
			}
		} else {
			return .unknown
		}
	}

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case ref
		case label
		case progress = "percentage"
		case fullDayEvent = "fulldayevent"
		case visibility
		case typeId = "type_id"
		case type
		case typeCode = "type_code"
		case code
		case dateCreated = "datec"
		case dateModified = "datem"
		case dateStart = "datep"
		case dateEnd = "datef"
		case authorId = "authorid"
		case userModifiedId = "usermodid"
		case location
		case thirdPartyId = "socid"
		case priority
		case usersAssigned = "userassigned"
		case userOwnerId = "userownerid"
		case elementId = "elementid"
		case elementType = "elementtype"
	}

	// MARK: - Inits

	public init(
		ref: String = "",
		label: String = "",
		progress: String = "",
		fullDayEvent: String = "",
		visibility: String? = nil,
		typeId: String? = nil,
		type: String? = nil,
		typeCode: String? = nil,
		code: String? = nil,
		dateCreated: Int? = nil,
		dateModified: Int? = nil,
		dateStart: Int? = nil,
		dateEnd: Int? = nil,
		authorId: String? = nil,
		userModifiedId: String? = nil,
		location: String? = nil,
		thirdPartyId: String? = nil,
		priority: String? = nil,
		usersAssigned: [String: DolibarrAgendaEventUserAssigned]? = nil,
		userOwnerId: String? = nil,
		elementId: String? = nil,
		elementType: String? = nil,
		id: String = "",
		statusCode: String = "",
		arrayOptions: [String: MultiType]? = nil,
		notePublic: String? = nil,
		notePrivate: String? = nil
	) {
		self.ref = ref
		self.label = label
		self.progress = progress
		self.fullDayEvent = fullDayEvent
		self.visibility = visibility
		self.typeId = typeId
		self.type = type
		self.typeCode = typeCode
		self.code = code
		self.dateCreated = dateCreated
		self.dateModified = dateModified
		self.dateStart = dateStart
		self.dateEnd = dateEnd
		self.authorId = authorId
		self.userModifiedId = userModifiedId
		self.location = location
		self.thirdPartyId = thirdPartyId
		self.priority = priority
		self.usersAssigned = usersAssigned
		self.userOwnerId = userOwnerId
		self.elementId = elementId
		self.elementType = elementType
		super.init(
			id: id, statusCode: statusCode,
			arrayOptions: arrayOptions,
			notePublic: notePublic,
			notePrivate: notePrivate
		)
	}

	required public init(from decoder: any Decoder) throws {
		do {
			#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
			Logger.logWithoutSignal("\(Self.self).init.decode", category: .api)
			#endif
			let container = try decoder.container(keyedBy: CodingKeys.self)
			self.ref = try container.decode(String.self, forKey: .ref)
			self.label = try container.decode(String.self, forKey: .label)
			self.progress = try container.decode(String.self, forKey: .progress)
			self.fullDayEvent = try container.decode(String.self, forKey: .fullDayEvent)
			self.visibility = try container.decodeIfPresent(String.self, forKey: .visibility)
			self.typeId = try container.decodeIfPresent(String.self, forKey: .typeId)
			self.type = try container.decodeIfPresent(String.self, forKey: .type)
			self.typeCode = try container.decodeIfPresent(String.self, forKey: .typeCode)
			self.code = try container.decodeIfPresent(String.self, forKey: .code)
			self.dateCreated = try container.decodeIfPresent(Int.self, forKey: .dateCreated)
			self.dateModified = try container.decodeIfPresent(Int.self, forKey: .dateModified)
			self.dateStart = try container.decode(MultiType.self, forKey: .dateStart).intValue
			self.dateEnd = try container.decode(MultiType.self, forKey: .dateEnd).intValue
			self.authorId = try container.decodeIfPresent(String.self, forKey: .authorId)
			self.userModifiedId = try container.decodeIfPresent(String.self, forKey: .userModifiedId)
			self.location = try container.decodeIfPresent(String.self, forKey: .location)
			self.thirdPartyId = try container.decodeIfPresent(String.self, forKey: .thirdPartyId)
			self.priority = try container.decodeIfPresent(String.self, forKey: .priority)
			if let userAssigned = try? container.decode([String: DolibarrAgendaEventUserAssigned].self, forKey: .usersAssigned) {
				self.usersAssigned = userAssigned
			} else {
				self.usersAssigned = nil
			}
			self.userOwnerId = try container.decodeIfPresent(String.self, forKey: .userOwnerId)
			self.elementId = try container.decodeIfPresent(String.self, forKey: .elementId)
			self.elementType = try container.decodeIfPresent(String.self, forKey: .elementType)
			try super.init(from: decoder)
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

	// MARK: - Protocol methods

	override public func hash(into hasher: inout Hasher) {
		hasher.combine(ref)
		hasher.combine(label)
		hasher.combine(progress)
		hasher.combine(fullDayEvent)
		hasher.combine(optional: visibility)
		hasher.combine(optional: typeId)
		hasher.combine(optional: type)
		hasher.combine(optional: typeCode)
		hasher.combine(optional: code)
		hasher.combine(optional: dateCreated)
		hasher.combine(optional: dateModified)
		hasher.combine(optional: dateStart)
		hasher.combine(optional: dateEnd)
		hasher.combine(optional: authorId)
		hasher.combine(optional: userModifiedId)
		hasher.combine(optional: location)
		hasher.combine(optional: thirdPartyId)
		hasher.combine(optional: priority)
		hasher.combine(optional: usersAssigned)
		hasher.combine(optional: userOwnerId)
		hasher.combine(optional: elementId)
		hasher.combine(optional: elementType)
		super.hash(into: &hasher)
	}

	override public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encodeIfNotEmpty(ref, forKey: .ref)
		try container.encodeIfNotEmpty(label, forKey: .label)
		try container.encodeIfNotEmpty(progress, forKey: .progress)
		try container.encodeIfNotEmpty(fullDayEvent, forKey: .fullDayEvent)
		try container.encodeIfPresentAndNotEmpty(visibility, forKey: .visibility)
		try container.encodeIfPresentAndNotEmpty(typeId, forKey: .typeId)
		try container.encodeIfPresentAndNotEmpty(type, forKey: .type)
		try container.encodeIfPresentAndNotEmpty(typeCode, forKey: .typeCode)
		try container.encodeIfPresentAndNotEmpty(code, forKey: .code)
		try container.encodeIfPresentAndNotZero(dateCreated, forKey: .dateCreated)
		try container.encodeIfPresentAndNotZero(dateModified, forKey: .dateModified)
		try container.encodeIfPresentAndNotZero(dateStart, forKey: .dateStart)
		try container.encodeIfPresentAndNotZero(dateEnd, forKey: .dateEnd)
		try container.encodeIfPresentAndNotEmpty(authorId, forKey: .authorId)
		try container.encodeIfPresentAndNotEmpty(userModifiedId, forKey: .userModifiedId)
		try container.encodeIfPresent(location, forKey: .location)
		try container.encodeIfPresent(thirdPartyId, forKey: .thirdPartyId)
		try container.encodeIfPresentAndNotEmpty(priority, forKey: .priority)
		try container.encodeIfPresent(usersAssigned, forKey: .usersAssigned)
		try container.encodeIfPresentAndNotEmpty(userOwnerId, forKey: .userOwnerId)
		try container.encodeIfPresent(elementId, forKey: .elementId)
		try container.encodeIfPresent(elementType, forKey: .elementType)
		try super.encode(to: encoder)
	}

}
