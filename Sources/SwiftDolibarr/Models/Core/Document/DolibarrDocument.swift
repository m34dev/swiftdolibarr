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
//  DolibarrDocument.swift
//  SwiftDolibarr
//
//  Created by William Mead on 26/05/2025.
//

import Foundation
#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
import OSLog
#endif

#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
@Observable
#endif
public final class DolibarrDocument: Hashable, Codable, DolibarrObject {

    // MARK: - Properties

    public var id: String
    public var name: String?
    public var path: String
    public var level1name: String
    public var relativename: String
    public var fullname: String
    public var date: Int
    public var size: Int
    public var type: String
    public var filename: String
    public var filepath: String
    public var genOrUploaded: String
    public var srcObjectType: String
    public var srcObjectId: String
    public var share: String?

    // MARK: - Enums

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case path
        case level1name
        case relativename
        case fullname
        case date
        case size
        case type
        case filename
        case filepath
        case genOrUploaded = "gen_or_uploaded"
        case srcObjectType = "src_object_type"
        case srcObjectId = "src_object_id"
        case share
    }

    // MARK: - Inits

    public init(
        id: String = "",
        name: String? = nil,
        path: String = "",
        level1name: String = "",
        relativename: String = "",
        fullname: String = "",
        date: Int = 0,
        size: Int = 0,
        type: String = "",
        filename: String = "",
        filepath: String = "",
        genOrUploaded: String = "",
        srcObjectType: String = "",
        srcObjectId: String = "",
        share: String? = nil
    ) {
        self.id = id
        self.name = name
        self.path = path
        self.level1name = level1name
        self.relativename = relativename
        self.fullname = fullname
        self.date = date
        self.size = size
        self.type = type
        self.filename = filename
        self.filepath = filepath
        self.genOrUploaded = genOrUploaded
        self.srcObjectType = srcObjectType
        self.srcObjectId = srcObjectId
        self.share = share
    }

    public init(from decoder: any Decoder) throws {
        do {
            #if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
            Logger.logWithoutSignal("\(Self.self).init.decode", category: .api)
            #endif
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(String.self, forKey: .id)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.path = try container.decode(String.self, forKey: .path)
            self.level1name = try container.decode(String.self, forKey: .level1name)
            self.relativename = try container.decode(String.self, forKey: .relativename)
            self.fullname = try container.decode(String.self, forKey: .fullname)
            self.date = try container.decode(Int.self, forKey: .date)
            self.size = try container.decode(Int.self, forKey: .size)
            self.type = try container.decode(String.self, forKey: .type)
            self.filename = try container.decode(String.self, forKey: .filename)
            self.filepath = try container.decode(String.self, forKey: .filepath)
            self.genOrUploaded = try container.decode(String.self, forKey: .genOrUploaded)
            self.srcObjectType = try container.decode(String.self, forKey: .srcObjectType)
            self.srcObjectId = try container.decode(String.self, forKey: .srcObjectId)
            self.share = try container.decodeIfPresent(String.self, forKey: .share)
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

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(filename)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(filename, forKey: .filename)
    }

    public static func == (lhs: DolibarrDocument, rhs: DolibarrDocument) -> Bool {
        lhs.id == rhs.id && lhs.filename == rhs.filename
    }

}
