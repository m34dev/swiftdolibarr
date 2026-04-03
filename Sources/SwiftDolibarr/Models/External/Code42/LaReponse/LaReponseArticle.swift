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
//  LaReponseArticle.swift
//  SwiftDolibarr
//
//  Created by William Mead on 03/04/2026.
//

import Foundation
#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
import OSLog
#endif

/// A LaReponse article object from the external Dolibarr module.
///
/// Maps to the Dolibarr `/lareponse/articles` REST API endpoint.
/// Each article has a ``title``, ``content``, ``visibility`` setting,
/// and a ``publishToken`` for sharing.
///
/// - Note: Requires the **LaReponse** external module by CODE42.
/// - SeeAlso: ``LaReponseComment``
#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
@Observable
#endif
public final class LaReponseArticle: Hashable, Encodable, DolibarrObject {

    // MARK: - Properties

    /// Article ID
    ///
    /// - Mapped Dolibarr property: **rowid**
    public var id: String

    /// Article creation date (Unix timestamp)
    ///
    /// - Mapped Dolibarr property: **date_creation**
    public var dateCreate: Int

    /// Article last modification (Unix timestamp)
    public var tms: Int

    /// Article creator user ID
    ///
    /// - Mapped Dolibarr property: **fk_user_creat**
    public var userCreateId: Int

    /// Article last modifier user ID
    ///
    /// - Mapped Dolibarr property: **fk_user_modif**
    public var userMoifyId: Int?

    /// Article title
    public var title: String

    /// Article content
    public var content: String

    /// Article visibility setting
    ///
    /// - Mapped Dolibarr property: **private**
    public var visibility: Int

    /// Article publish token for sharing
    ///
    /// - Mapped Dolibarr property: **publish_token**
    public var publishToken: String

    /// Article type
    public var type: Int

    // MARK: - Enums

    enum CodingKeys: String, CodingKey {
        case id = "rowid"
        case dateCreate = "date_creation"
        case tms
        case userCreateId = "fk_user_creat"
        case userMoifyId = "fk_user_modif"
        case title
        case content
        case visibility = "private"
        case publishToken = "publish_token"
        case type
    }

    // MARK: - Inits

    public init(
        id: String = "",
        dateCreate: Int = 0,
        tms: Int = 0,
        userCreateId: Int = 0,
        userMoifyId: Int? = nil,
        title: String = "",
        content: String = "",
        visibility: Int = 0,
        publishToken: String = "",
        type: Int = 0
    ) {
        self.id = id
        self.dateCreate = dateCreate
        self.tms = tms
        self.userCreateId = userCreateId
        self.userMoifyId = userMoifyId
        self.title = title
        self.content = content
        self.visibility = visibility
        self.publishToken = publishToken
        self.type = type
    }

    public required init(from decoder: any Decoder) throws {
        do {
            #if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
            Logger.logWithoutSignal("\(Self.self).init.decode", level: .info, category: .api)
            #endif
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(MultiType.self, forKey: .id).stringValue
            self.dateCreate = try container.decode(Int.self, forKey: .dateCreate)
            self.tms = try container.decode(Int.self, forKey: .tms)
            self.userCreateId = try container.decode(Int.self, forKey: .userCreateId)
            self.userMoifyId = try container.decodeIfPresent(Int.self, forKey: .userMoifyId)
            self.title = try container.decode(String.self, forKey: .title)
            self.content = try container.decode(String.self, forKey: .content)
            self.visibility = try container.decode(Int.self, forKey: .visibility)
            self.publishToken = try container.decode(String.self, forKey: .publishToken)
            self.type = try container.decode(Int.self, forKey: .type)
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
        hasher.combine(dateCreate)
        hasher.combine(tms)
        hasher.combine(userCreateId)
        hasher.combine(optional: userMoifyId)
        hasher.combine(title)
        hasher.combine(content)
        hasher.combine(visibility)
        hasher.combine(publishToken)
        hasher.combine(type)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfNotEmpty(id, forKey: .id)
        try container.encodeIfNotZero(dateCreate, forKey: .dateCreate)
        try container.encodeIfNotZero(tms, forKey: .tms)
        try container.encodeIfNotZero(userCreateId, forKey: .userCreateId)
        try container.encodeIfPresentAndNotZero(userMoifyId, forKey: .userMoifyId)
        try container.encodeIfNotEmpty(title, forKey: .title)
        try container.encodeIfNotEmpty(content, forKey: .content)
        try container.encodeIfNotZero(visibility, forKey: .visibility)
        try container.encodeIfNotEmpty(publishToken, forKey: .publishToken)
        try container.encodeIfNotZero(type, forKey: .type)
    }

    public static func == (lhs: LaReponseArticle, rhs: LaReponseArticle) -> Bool {
        lhs.id == rhs.id
    }

}
