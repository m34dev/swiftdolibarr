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
//  DolibarrIntervention.swift
//  SwiftDolibarr
//
//  Created by William Mead on 06/12/2024.
//

import Foundation
#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
import OSLog
#endif

/// A Dolibarr intervention (field service) object.
///
/// Maps to the Dolibarr `/interventions` REST API endpoint. An intervention
/// is linked to a third party via ``socId`` and can optionally be associated
/// with a project or contract.
///
/// ## Overview
///
/// Each intervention has a ``status``, optional ``DolibarrInterventionLine`` items,
/// start/end dates, and duration.
///
/// - Note: Requires the **Fichinter** module to be activated in Dolibarr.
/// - SeeAlso: ``DolibarrInterventionLine``
@Observable public final class DolibarrIntervention: CommonBusinessObject {

	// MARK: - Properties

	// Required

	/// Associated third party ID
	///
	/// - Mapped Dolibarr property: **socid**
	public var socId: String

	/// Intervention reference
	public var ref: String

	// Optional

	/// Associated contract ID
	///
	/// - Mapped Dolibarr property: **fk_contrat**
	public var contractId: String?

	/// Associated project ID
	///
	/// - Mapped Dolibarr property: **fk_project**
	public var projectId: String?

	/// Intervention start date (Unix timestamp)
	public var dateo: Double?

	/// Intervention end date (Unix timestamp)
	public var datee: Double?

	/// Intervention duration in seconds
	public var duration: String?

	/// Intervention description
	public var description: String?

	/// Intervention client reference
	///
	/// - Mapped Dolibarr property: **ref_client**
	public var clientRef: String?

	/// Intervention last generated main document path
	///
	/// - Mapped Dolibarr property: **last_main_doc**
	public var lastMainDoc: String?

	/// Intervention lines
	public var lines: [DolibarrInterventionLine]?

	/// Intervention external contact IDs
	///
	/// - Mapped Dolibarr property: **contacts_ids**
	public var externalContactIds: [[String: MultiType]]?

	/// Intervention internal contact IDs
	///
	/// - Mapped Dolibarr property: **contacts_ids_internal**
	public var internalContactIds: [[String: MultiType]]?

	// Computed

	/// Associated intervention status type
	override public var status: DolibarrObjectStatus {
		guard let status = DolibarrObjectStatus.interventions.first(where: { $0.code == statusCode }) else { return .unknown }
		return status
	}

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case socId = "socid"
		case ref
		case contractId = "fk_contrat"
		case projectId = "fk_project"
		case dateo
		case datee
		case duration
		case description
		case clientRef = "ref_client"
		case lastMainDoc = "last_main_doc"
		case lines
		case externalContactIds = "contacts_ids"
		case internalContactIds = "contacts_ids_internal"
	}

	// MARK: - Inits

	public init(
		socId: String = "",
		ref: String = "",
		contractId: String? = nil,
		projectId: String? = nil,
		dateo: Double? = nil,
		datee: Double? = nil,
		duration: String? = nil,
		description: String? = nil,
		clientRef: String? = nil,
		lastMainDoc: String? = nil,
		lines: [DolibarrInterventionLine]? = nil,
		externalContactIds: [[String: MultiType]]? = nil,
		internalContactIds: [[String: MultiType]]? = nil,
		id: String = "",
		statusCode: String = "",
		arrayOptions: [String: MultiType]? = nil,
		notePublic: String? = nil,
		notePrivate: String? = nil
	) {
		self.socId = socId
		self.ref = ref
		self.contractId = contractId
		self.projectId = projectId
		self.dateo = dateo
		self.datee = datee
		self.duration = duration
		self.description = description
		self.clientRef = clientRef
		self.lastMainDoc = lastMainDoc
		self.lines = lines
		self.externalContactIds = externalContactIds
		self.internalContactIds = internalContactIds
		super.init(
			id: id,
			statusCode: statusCode,
			arrayOptions: arrayOptions,
			notePublic: notePublic,
			notePrivate: notePrivate
		)
	}

	public required init(from decoder: any Decoder) throws {
		do {
			#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
			Logger.logWithoutSignal("\(Self.self).init.decode", category: .api)
			#endif
			let container = try decoder.container(keyedBy: CodingKeys.self)
			self.socId = try container.decode(String.self, forKey: .socId)
			self.ref = try container.decode(String.self, forKey: .ref)
			self.contractId = try container.decodeIfPresent(String.self, forKey: .contractId)
			self.projectId = try container.decodeIfPresent(String.self, forKey: .projectId)
			self.dateo = try container.decodeIfPresent(MultiType.self, forKey: .dateo)?.doubleValue
			self.datee = try container.decodeIfPresent(MultiType.self, forKey: .datee)?.doubleValue
			self.duration = try container.decodeIfPresent(String.self, forKey: .duration)
			self.description = try container.decodeIfPresent(String.self, forKey: .description)
			self.clientRef = try container.decodeIfPresent(String.self, forKey: .clientRef)
			self.lastMainDoc = try container.decodeIfPresent(String.self, forKey: .lastMainDoc)
			self.lines = try container.decodeIfPresent([DolibarrInterventionLine].self, forKey: .lines)
			self.externalContactIds = try container.decodeIfPresent([[String: MultiType]].self, forKey: .externalContactIds)
			self.internalContactIds = try container.decodeIfPresent([[String: MultiType]].self, forKey: .internalContactIds)
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
		hasher.combine(socId)
		hasher.combine(ref)
		hasher.combine(optional: contractId)
		hasher.combine(optional: projectId)
		hasher.combine(optional: dateo)
		hasher.combine(optional: datee)
		hasher.combine(optional: duration)
		hasher.combine(optional: description)
		hasher.combine(optional: clientRef)
		hasher.combine(optional: lastMainDoc)
		hasher.combine(optional: lines)
		hasher.combine(optional: externalContactIds)
		hasher.combine(optional: internalContactIds)
		super.hash(into: &hasher)
	}

	override public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encodeIfNotEmpty(socId, forKey: .socId)
		try container.encodeIfNotEmpty(ref, forKey: .ref)
		try container.encodeIfPresent(contractId, forKey: .contractId)
		try container.encodeIfPresent(projectId, forKey: .projectId)
		try container.encodeIfPresent(dateo, forKey: .dateo)
		try container.encodeIfPresent(datee, forKey: .datee)
		try container.encodeIfPresent(duration, forKey: .duration)
		try container.encodeIfPresent(description, forKey: .description)
		try container.encodeIfPresent(clientRef, forKey: .clientRef)
		try container.encodeIfPresent(lastMainDoc, forKey: .lastMainDoc)
		try super.encode(to: encoder)
	}

}
