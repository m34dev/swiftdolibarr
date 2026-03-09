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
//  DolibarrUserPermissionsAgendaMyActions.swift
//  SwiftDolibarr
//
//  Created by William Mead on 09/03/2026.
//

import Foundation

public struct DolibarrUserPermissionsAgendaMyActions: Codable, Hashable {

	// MARK: - Properties

	public var read: Int?
	public var create: Int?
	public var delete: Int?

	// MARK: - Inits

	public  init(read: Int? = nil, create: Int? = nil, delete: Int? = nil) {
		self.read = read
		self.create = create
		self.delete = delete
	}

	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.read = try container.decodeIfPresent(Int.self, forKey: .read)
		self.create = try container.decodeIfPresent(Int.self, forKey: .create)
		self.delete = try container.decodeIfPresent(Int.self, forKey: .delete)
	}

}

public struct DolibarrUserPermissionsAgendaAllActions: Codable, Hashable {

	// MARK: - Properties

	public var read: Int?
	public var create: Int?
	public var delete: Int?

	// MARK: - Inits

	public init(read: Int? = nil, create: Int? = nil, delete: Int? = nil) {
		self.read = read
		self.create = create
		self.delete = delete
	}

	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.read = try container.decodeIfPresent(Int.self, forKey: .read)
		self.create = try container.decodeIfPresent(Int.self, forKey: .create)
		self.delete = try container.decodeIfPresent(Int.self, forKey: .delete)
	}

}
