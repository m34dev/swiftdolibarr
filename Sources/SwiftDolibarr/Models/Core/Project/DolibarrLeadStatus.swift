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
//  DolibarrLeadStatus.swift
//  SwiftDolibarr
//
//  Created by William Mead on 31/03/2026.
//

import Foundation
#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
import OSLog
#endif

public struct DolibarrLeadStatus: Identifiable, Hashable, Decodable, Sendable {

    // MARK: - Properties

    public var id: String
    public var code: String
    public var label: String
    public var progress: String
    public var active: String

    // MARK: - Enums

    enum CodingKeys: String, CodingKey {
        case id
        case code
        case label
        case progress = "percent"
        case active
    }

    // MARK: - Inits

    public init(
        id: String = "",
        code: String = "",
        label: String = "",
        progress: String = "",
        active: String = ""
    ) {
        self.id = id
        self.code = code
        self.label = label
        self.progress = progress
        self.active = active
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
            self.progress = try container.decode(String.self, forKey: .progress)
            self.active = try container.decode(String.self, forKey: .active)
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
