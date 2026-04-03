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
//  LaReponseComment.swift
//  SwiftDolibarr
//
//  Created by William Mead on 03/04/2026.
//

import Foundation
#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
import OSLog
#endif

/// A LaReponse comment object from the external Dolibarr module.
///
/// Maps to the Dolibarr `/lareponse/comments` REST API endpoint.
/// Each comment belongs to a ``LaReponseArticle`` via its ``articleId`` property
/// and contains user-provided ``content``.
///
/// - Note: Requires the **LaReponse** external module by CODE42.
/// - SeeAlso: ``LaReponseArticle``
#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
@Observable
#endif
public final class LaReponseComment: Hashable, Encodable, DolibarrObject {

    // MARK: - Properties

    /// Comment ID
    ///
    /// - Mapped Dolibarr property: **rowid**
    public var id: String

    /// Comment creation date (Unix timestamp)
    ///
    /// - Mapped Dolibarr property: **date_creation**
    public var dateCreate: Int

    /// Comment last modification (Unix timestamp)
    public var tms: Int

    /// Comment creator user ID
    ///
    /// - Mapped Dolibarr property: **fk_user_creat**
    public var userCreateId: Int

    /// Comment last modifier user ID
    ///
    /// - Mapped Dolibarr property: **fk_user_modif**
    public var userMoifyId: Int?

    /// Parent article ID
    ///
    /// - Mapped Dolibarr property: **fk_article**
    public var articleId: Int

    /// Comment content
    public var content: String

    // MARK: - Enums

    enum CodingKeys: String, CodingKey {
        case id = "rowid"
        case dateCreate = "date_creation"
        case tms
        case userCreateId = "fk_user_creat"
        case userMoifyId = "fk_user_modif"
        case articleId = "fk_article"
        case content
    }

    // MARK: - Inits

    public init(
        id: String = "",
        dateCreate: Int = 0,
        tms: Int = 0,
        userCreateId: Int = 0,
        userMoifyId: Int? = nil,
        articleId: Int = 0,
        content: String = "",
    ) {
        self.id = id
        self.dateCreate = dateCreate
        self.tms = tms
        self.userCreateId = userCreateId
        self.userMoifyId = userMoifyId
        self.articleId = articleId
        self.content = content
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
            self.articleId = try container.decode(Int.self, forKey: .articleId)
            self.content = try container.decode(String.self, forKey: .content)
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
        hasher.combine(articleId)
        hasher.combine(content)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfNotEmpty(id, forKey: .id)
        try container.encodeIfNotZero(dateCreate, forKey: .dateCreate)
        try container.encodeIfNotZero(tms, forKey: .tms)
        try container.encodeIfNotZero(userCreateId, forKey: .userCreateId)
        try container.encodeIfPresentAndNotZero(userMoifyId, forKey: .userMoifyId)
        try container.encodeIfNotZero(articleId, forKey: .articleId)
        try container.encodeIfNotEmpty(content, forKey: .content)
    }

    public static func == (lhs: LaReponseComment, rhs: LaReponseComment) -> Bool {
        lhs.id == rhs.id
    }

}
