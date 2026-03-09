//
//  DolibarrUserPermissionsUser.swift
//  SwiftDolibarr
//
//  Created by William Mead on 09/03/2026.
//

import Foundation

struct DolibarrUserPermissionsUser: Codable, Hashable {

	// MARK: - Properties

	var user: [String: Int]
	var userSelf: [String: Int]
	var userAdvance: [String: Int]
	var selfAdvance: [String: Int]
	var groupAdvance: [String: Int]

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case user
		case userSelf = "self"
		case userAdvance = "user_advance"
		case selfAdvance = "self_advance"
		case groupAdvance = "group_advance"
	}

	// MARK: - Inits

	internal init(
		user: [String: Int],
		userSelf: [String: Int],
		userAdvance: [String: Int],
		selfAdvance: [String: Int],
		groupAdvance: [String: Int]
	) {
		self.user = user
		self.userSelf = userSelf
		self.userAdvance = userAdvance
		self.selfAdvance = selfAdvance
		self.groupAdvance = groupAdvance
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.user = try container.decode([String: Int].self, forKey: .user)
		self.userSelf = try container.decode([String: Int].self, forKey: .userSelf)
		self.userAdvance = try container.decode([String: Int].self, forKey: .userAdvance)
		self.selfAdvance = try container.decode([String: Int].self, forKey: .selfAdvance)
		self.groupAdvance = try container.decode([String: Int].self, forKey: .groupAdvance)
	}

}
