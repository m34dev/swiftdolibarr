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
//  DolibarrUserPermissionsLaReponseArticle.swift
//  SwiftDolibarr
//
//  Created by William Mead on 27/04/2026.
//

import Foundation

/// La Réponse article permissions for a Dolibarr user.
///
/// - SeeAlso: ``DolibarrUserPermissionsLaReponse``
public struct DolibarrUserPermissionsLaReponseArticle: Codable, Hashable {

    // MARK: - Properties

    public var read: Int?
    public var write: Int?
    public var close: Int?
    public var open: Int?
    public var updateOther: Int?
    public var delete: Int?
    public var export: Int?
    public var publish: Int?

    // MARK: - Enums

    enum CodingKeys: String, CodingKey {
        case read
        case write
        case close
        case open
        case updateOther = "update_other"
        case delete
        case export
        case publish
    }

    // MARK: - Inits

    public init(
        read: Int? = nil,
        write: Int? = nil,
        close: Int? = nil,
        open: Int? = nil,
        updateOther: Int? = nil,
        delete: Int? = nil,
        export: Int? = nil,
        publish: Int? = nil
    ) {
        self.read = read
        self.write = write
        self.close = close
        self.open = open
        self.updateOther = updateOther
        self.delete = delete
        self.export = export
        self.publish = publish
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.read = try container.decodeIfPresent(Int.self, forKey: .read)
        self.write = try container.decodeIfPresent(Int.self, forKey: .write)
        self.close = try container.decodeIfPresent(Int.self, forKey: .close)
        self.open = try container.decodeIfPresent(Int.self, forKey: .open)
        self.updateOther = try container.decodeIfPresent(Int.self, forKey: .updateOther)
        self.delete = try container.decodeIfPresent(Int.self, forKey: .delete)
        self.export = try container.decodeIfPresent(Int.self, forKey: .export)
        self.publish = try container.decodeIfPresent(Int.self, forKey: .publish)
    }

}
