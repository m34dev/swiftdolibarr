//
//  DolibarrUserPermissionsAgendaMyActions.swift
//  SwiftDolibarr
//
//  Created by William Mead on 09/03/2026.
//

import Foundation

struct DolibarrUserPermissionsAgendaMyActions: Codable, Hashable {

	// MARK: - Properties

	var read: Int?
	var create: Int?
	var delete: Int?

	// MARK: - Inits

	internal init(read: Int? = nil, create: Int? = nil, delete: Int? = nil) {
		self.read = read
		self.create = create
		self.delete = delete
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.read = try container.decodeIfPresent(Int.self, forKey: .read)
		self.create = try container.decodeIfPresent(Int.self, forKey: .create)
		self.delete = try container.decodeIfPresent(Int.self, forKey: .delete)
	}

}

struct DolibarrUserPermissionsAgendaAllActions: Codable, Hashable {

	// MARK: - Properties

	var read: Int?
	var create: Int?
	var delete: Int?

	// MARK: - Inits

	internal init(read: Int? = nil, create: Int? = nil, delete: Int? = nil) {
		self.read = read
		self.create = create
		self.delete = delete
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.read = try container.decodeIfPresent(Int.self, forKey: .read)
		self.create = try container.decodeIfPresent(Int.self, forKey: .create)
		self.delete = try container.decodeIfPresent(Int.self, forKey: .delete)
	}

}
