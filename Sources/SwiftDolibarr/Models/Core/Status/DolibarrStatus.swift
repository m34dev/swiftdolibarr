// Copyright 2026 M34D - William Mead
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//
//  DolibarrStatus.swift
//  SwiftDolibarr
//
//  Created by William Mead on 01/11/2024.
//

import Foundation
#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
import OSLog
#endif

/// The top-level response returned by the Dolibarr `/status` REST API endpoint.
///
/// Contains a single ``success`` payload with server version and availability details.
///
/// - SeeAlso: ``DolibarrStatusSuccess``
public struct DolibarrStatus: Decodable, Sendable {

    // MARK: - Properties

    // Required

    /// The success payload containing server status details.
    public var success: DolibarrStatusSuccess

}

/// Detailed status information returned inside a ``DolibarrStatus`` response.
///
/// Provides the Dolibarr server version, access lock state, and optional
/// environment and timestamp metadata.
///
/// - SeeAlso: ``DolibarrStatus``
public struct DolibarrStatusSuccess: Equatable, Hashable, Decodable, Sendable {

    // MARK: - Properties

    // Required

    /// The HTTP-style status code (e.g. `200`).
    public var code: Int

    /// The version string of the Dolibarr instance (e.g. `"23.0.1"`).
    public var dolibarrVersion: String

    /// Whether access to the instance is locked (`"0"` for open, `"1"` for locked).
    public var accessLocked: String

    // Optional

    /// The server environment identifier, if available.
    public var environment: String?

    /// The current UTC Unix timestamp on the server, if available.
    public var timestampNowUTC: Int?

    /// The server's configured PHP timezone name, if available.
    public var timestampPHPTZ: String?

    /// The current time in the server's PHP timezone, if available.
    public var dateTZ: String?

    // MARK: - Enums

    enum CodingKeys: String, CodingKey {
        case code
        case dolibarrVersion = "dolibarr_version"
        case accessLocked = "access_locked"
        case environment
        case timestampNowUTC = "timestamp_now_utc"
        case timestampPHPTZ = "timestamp_php_tz"
        case dateTZ = "date_tz"
    }

    // MARK: - Inits

    public init(
        code: Int,
        dolibarrVersion: String,
        accessLocked: String,
        environment: String? = nil,
        timestampNowUTC: Int? = nil,
        timestampPHPTZ: String? = nil,
        dateTZ: String? = nil
    ) {
        self.code = code
        self.dolibarrVersion = dolibarrVersion
        self.accessLocked = accessLocked
        self.environment = environment
        self.timestampNowUTC = timestampNowUTC
        self.timestampPHPTZ = timestampPHPTZ
        self.dateTZ = dateTZ
    }

    public init(from decoder: any Decoder) throws {
        do {
            #if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
            Logger.logWithoutSignal("\(Self.self).init.decode", category: .api)
            #endif
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.code = try container.decode(Int.self, forKey: .code)
            self.dolibarrVersion = try container.decode(String.self, forKey: .dolibarrVersion)
            self.accessLocked = try container.decode(String.self, forKey: .accessLocked)
            self.environment = try container.decodeIfPresent(String.self, forKey: .environment)
            self.timestampNowUTC = try container.decodeIfPresent(Int.self, forKey: .timestampNowUTC)
            self.timestampPHPTZ = try container.decodeIfPresent(String.self, forKey: .timestampPHPTZ)
            self.dateTZ = try container.decodeIfPresent(String.self, forKey: .dateTZ)
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
