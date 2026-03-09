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
//  DolibarrProject.swift
//  SwiftDolibarr
//
//  Created by William Mead on 18/02/2026.
//

import Foundation
import OSLog

@Observable public final class DolibarrProject: CommonBusinessObject, DolibarrAPIObject {

	// MARK: - Properties

	// Required

	public var reference: String
	public var title: String

	// Computed

	override public var status: DolibarrObjectStatus {
		guard let status = DolibarrObjectStatus.projects.first(where: { $0.code == statusCode }) else { return .unknown }
		return status
	}

	enum CodingKeys: String, CodingKey {
		case reference = "ref"
		case title
	}

	// MARK: - Inits

	public init(
		reference: String = "",
		title: String = "",
		id: String = "",
		statusCode: String = "",
		entityId: String? = nil,
		arrayOptions: [String: MultiType]? = nil,
		notePublic: String? = nil,
		notePrivate: String? = nil
	) {
		self.reference = reference
		self.title = title
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
			self.reference = try container.decode(String.self, forKey: .reference)
			self.title = try container.decode(String.self, forKey: .title)
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
		hasher.combine(reference)
		hasher.combine(title)
		super.hash(into: &hasher)
	}

	override public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encodeIfNotEmpty(reference, forKey: .reference)
		try container.encodeIfNotEmpty(title, forKey: .title)
		try super.encode(to: encoder)
	}

}
