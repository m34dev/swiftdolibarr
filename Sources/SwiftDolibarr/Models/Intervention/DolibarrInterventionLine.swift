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
//  DolibarrInterventionLine.swift
//  SwiftDolibarr
//
//  Created by William Mead on 11/12/2024.
//

import Foundation
import OSLog

/// A single line item within a Dolibarr intervention.
///
/// Each line represents a time entry with a ``datei`` timestamp,
/// a ``duration`` in seconds, and an optional description.
///
/// - Note: Requires the **Ficheinter** module to be activated in Dolibarr.
/// - SeeAlso: ``DolibarrIntervention``
@Observable public final class DolibarrInterventionLine: CommonBusinessObjectLine {

    // MARK: - Properties

	// Required

	/// Intervention line date (Unix timestamp)
	public var datei: Double

	/// Intervention line duration in seconds
	public var duration: String

	// Optional

	/// Intervention line description
	public  var desc: String?

    // MARK: - Enums

    enum CodingKeys: CodingKey {
		case datei
		case duration
        case desc
    }

    // MARK: - Inits

	public init(
		datei: Double = Date.now.timeIntervalSince1970,
		duration: String = "3600",
		desc: String? = nil,
		id: String = "",
		rang: String = ""
	) {
		self.datei = datei
		self.duration = duration
        self.desc = desc
		super.init(id: id, rang: rang)
    }

	public required init(from decoder: any Decoder) throws {
        do {
            Logger.logWithoutSignal("\(Self.self).init.decode", level: .info, category: .api)
            let container = try decoder.container(keyedBy: CodingKeys.self)
			self.datei = try container.decode(Double.self, forKey: .datei)
			self.duration = try container.decode(String.self, forKey: .duration)
            self.desc = try container.decodeIfPresent(String.self, forKey: .desc)
			try super.init(from: decoder)
            Logger.logWithoutSignal("\(Self.self).init.decoded", level: .info, category: .api)
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
        hasher.combine(datei)
		hasher.combine(duration)
		hasher.combine(optional: desc)
		super.hash(into: &hasher)
    }

    override public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(datei, forKey: .datei)
        try container.encode(duration, forKey: .duration)
		try container.encode(desc, forKey: .desc)
		try super.encode(to: encoder)
    }

}
