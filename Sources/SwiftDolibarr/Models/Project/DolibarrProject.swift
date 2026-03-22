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
#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
import OSLog
#endif

/// A Dolibarr project object.
///
/// Maps to the Dolibarr `/projects` REST API endpoint. A project groups
/// related tasks and can have start/end dates.
///
/// - Note: Requires the **Projet** module to be activated in Dolibarr.
/// - SeeAlso: ``DolibarrTask``
@Observable public final class DolibarrProject: CommonBusinessObject {

	// MARK: - Properties

	// Required

	/// Project reference
	///
	/// - Mapped Dolibarr property: **ref**
	public var reference: String

	/// Project title
	public var title: String

	// Optional

	/// Project start date (Unix timestamp)
	///
	/// - Mapped Dolibarr property: **date_start**
	public var dateStart: Int?

	/// Project end date (Unix timestamp)
	///
	/// - Mapped Dolibarr property: **date_end**
	public var dateEnd: Int?

	/// Project description
	public var description: String?

	// Computed

	/// Associated project status type
	override public var status: DolibarrObjectStatus {
		guard let status = DolibarrObjectStatus.projects.first(where: { $0.code == statusCode }) else { return .unknown }
		return status
	}

	enum CodingKeys: String, CodingKey {
		case reference = "ref"
		case title
		case dateStart = "date_start"
		case dateEnd = "date_end"
		case description
	}

	// MARK: - Inits

	public init(
		reference: String = "",
		title: String = "",
		dateStart: Int? = nil,
		dateEnd: Int? = nil,
		description: String? = nil,
		id: String = "",
		statusCode: String = "",
		entityId: String? = nil,
		arrayOptions: [String: MultiType]? = nil,
		notePublic: String? = nil,
		notePrivate: String? = nil
	) {
		self.reference = reference
		self.title = title
		self.dateStart = dateStart
		self.dateEnd = dateEnd
		self.description = description
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
			self.reference = try container.decode(String.self, forKey: .reference)
			self.title = try container.decode(String.self, forKey: .title)
			self.dateStart = try container.decodeIfPresent(MultiType.self, forKey: .dateStart)?.intValue
			self.dateEnd = try container.decodeIfPresent(MultiType.self, forKey: .dateEnd)?.intValue
			self.description = try container.decodeIfPresent(String.self, forKey: .description)
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
		hasher.combine(reference)
		hasher.combine(title)
		hasher.combine(optional: dateStart)
		hasher.combine(optional: dateEnd)
		hasher.combine(optional: description)
		super.hash(into: &hasher)
	}

	override public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encodeIfNotEmpty(reference, forKey: .reference)
		try container.encodeIfNotEmpty(title, forKey: .title)
		try container.encodeIfPresentAndNotZero(dateStart, forKey: .dateStart)
		try container.encodeIfPresentAndNotZero(dateEnd, forKey: .dateEnd)
		try container.encodeIfPresent(description, forKey: .description)
		try super.encode(to: encoder)
	}

}
