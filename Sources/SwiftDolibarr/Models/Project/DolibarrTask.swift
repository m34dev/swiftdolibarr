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
//  DolibarrTask.swift
//  SwiftDolibarr
//
//  Created by William Mead on 20/02/2026.
//

import Foundation
#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
import OSLog
#endif

/// A Dolibarr task object.
///
/// Maps to the Dolibarr `/tasks` REST API endpoint. Each task belongs to
/// a ``DolibarrProject`` via ``projectId`` and can optionally have a parent
/// task via ``parentId``.
///
/// - Note: Requires the **Projet** module to be activated in Dolibarr.
/// - SeeAlso: ``DolibarrProject``
@Observable public final class DolibarrTask: CommonBusinessObject {

	// MARK: - Properties

	// Required

	/// Task reference
	public var ref: String

	/// Task label
	public var label: String

	/// Associated project ID
	///
	/// - Mapped Dolibarr property: **fk_project**
	public var projectId: String

	/// Parent task ID
	///
	/// - Mapped Dolibarr property: **fk_task_parent**
	public var parentId: String

	// MARK: - Computed Properties

	/// Associated task status type
	override public var status: DolibarrObjectStatus {
		return .unknown
	}

	enum CodingKeys: String, CodingKey {
		case ref
		case label
		case projectId = "fk_project"
		case parentId = "fk_task_parent"
	}

	// MARK: - Inits

	public init(
		ref: String = "",
		label: String = "",
		projectId: String = "",
		parentId: String = "",
		id: String = "",
		statusCode: String = "",
		entityId: String? = nil,
		arrayOptions: [String: MultiType]? = nil,
		notePublic: String? = nil,
		notePrivate: String? = nil
	) {
		self.ref = ref
		self.label = label
		self.projectId = projectId
		self.parentId = parentId
		super.init(
			id: id,
			statusCode: statusCode,
			entityId: entityId,
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
			self.ref = try container.decode(String.self, forKey: .ref)
			self.label = try container.decode(String.self, forKey: .label)
			self.projectId = try container.decode(String.self, forKey: .projectId)
			self.parentId = try container.decode(String.self, forKey: .parentId)
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
		super.hash(into: &hasher)
		hasher.combine(ref)
		hasher.combine(label)
		hasher.combine(projectId)
		hasher.combine(parentId)
	}

	override public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encodeIfNotEmpty(ref, forKey: .ref)
		try container.encodeIfNotEmpty(label, forKey: .label)
		try container.encodeIfNotEmpty(projectId, forKey: .projectId)
		try container.encodeIfNotEmpty(parentId, forKey: .parentId)
		try super.encode(to: encoder)
	}

}
