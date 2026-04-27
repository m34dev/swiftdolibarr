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
//  DolibarrUserPermissionsLaReponse.swift
//  SwiftDolibarr
//
//  Created by William Mead on 27/04/2026.
//

import Foundation

/// La Réponse external module permissions for a Dolibarr user.
///
/// - SeeAlso: ``DolibarrUserPermissions``
public struct DolibarrUserPermissionsLaReponse: Codable, Hashable {

    // MARK: - Properties

    public var article: DolibarrUserPermissionsLaReponseArticle?
    public var configure: Int?
    public var tag: DolibarrUserPermissionsLaReponseTag?

    // MARK: - Inits

    public init(
        article: DolibarrUserPermissionsLaReponseArticle? = nil,
        configure: Int? = nil,
        tag: DolibarrUserPermissionsLaReponseTag? = nil
    ) {
        self.article = article
        self.configure = configure
        self.tag = tag
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.article = try container.decodeIfPresent(DolibarrUserPermissionsLaReponseArticle.self, forKey: .article)
        self.configure = try container.decodeIfPresent(Int.self, forKey: .configure)
        self.tag = try container.decodeIfPresent(DolibarrUserPermissionsLaReponseTag.self, forKey: .tag)
    }

}
