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
//  hades
//
//  Created by William Mead on 20/02/2026.
//

import Foundation
import OSLog

@Observable public final class DolibarrTask: CommonBusinessObject, DolibarrAPIObject {

	// MARK: - Properties

	// Required

	public var ref: String
	public var label: String
	public var projectId: String
	public var parentId: String

	// MARK: - Computed Properties

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
		ref: String,
		label: String,
		projectId: String,
		parentId: String,
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
			Logger.logWithoutSignal("\(Self.self).init.decode", category: .api)
			let container = try decoder.container(keyedBy: CodingKeys.self)
			self.ref = try container.decode(String.self, forKey: .ref)
			self.label = try container.decode(String.self, forKey: .label)
			self.projectId = try container.decode(String.self, forKey: .projectId)
			self.parentId = try container.decode(String.self, forKey: .parentId)
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

	// MARK: - Instance methods

	@MainActor override func refreshAPIObjectProperties(with refreshedObject: CommonBusinessObject?) {
		Logger.logWithoutSignal("\(Self.self).refreshAPIObjectProperties", category: .api)
		if let refreshedObject = refreshedObject as? DolibarrTask {
			super.refreshAPIObjectProperties(with: refreshedObject)
			self.ref = refreshedObject.ref
			self.label = refreshedObject.label
			self.projectId = refreshedObject.projectId
			self.parentId = refreshedObject.parentId
		}
	}

}
