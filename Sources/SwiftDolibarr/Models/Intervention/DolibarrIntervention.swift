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
import OSLog

@Observable public final class DolibarrIntervention: CommonBusinessObject {

	// MARK: - Properties

	// Requried

	var socId: String
	var ref: String

	// Optional

	var contractId: String?
	var projectId: String?
	var dateo: Double?
	var datee: Double?
	var duration: String?
	var description: String?
	var clientRef: String?
	var lastMainDoc: String?
	var lines: [DolibarrInterventionLine]?
	var externalContactIds: [[String: MultiType]]?
	var internalContactIds: [[String: MultiType]]?

	// Computed

	override var status: DolibarrObjectStatus {
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

	init(
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

	required init(from decoder: any Decoder) throws {
		do {
			Logger.logWithoutSignal("\(Self.self).init.decode", category: .api)
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
