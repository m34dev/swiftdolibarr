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
//  DolibarrShippingMethod.swift
//  SwiftDolibarr
//
//  Created by William Mead on 24/03/2026.
//

import Foundation
#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
import OSLog
#endif

/// A Dolibarr shipping method configuration.
///
/// Maps to the Dolibarr `/setup/shipping_methods` REST API endpoint.
/// Each shipping method has a ``code``, a ``label``, a ``description``,
/// and a ``trackingURL`` template.
///
/// - Note: Requires the **Expedition** and/or **Receptions** module(s) to be activated in Dolibarr.
public struct DolibarrShippingMethod: Identifiable, Hashable, Decodable, Sendable {

	// MARK: - Properties

	public var id: String
	public var code: String
	public var label: String
	public var description: String
	public var trackingURL: String

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case id
		case code
		case label
		case description
		case trackingURL = "tracking"
	}

	// MARK: - Inits

	public init(
		id: String = "",
		code: String = "",
		label: String = "",
		description: String = "",
		trackingURL: String = ""
	) {
		self.id = id
		self.code = code
		self.label = label
		self.description = description
		self.trackingURL = trackingURL
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
			self.trackingURL = try container.decode(String.self, forKey: .trackingURL)
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
