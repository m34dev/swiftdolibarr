//
//  DolibarrUserPermissionsAgenda.swift
//  SwiftDolibarr
//
//  Created by William Mead on 09/03/2026.
//

import Foundation

struct DolibarrUserPermissionsAgenda: Codable, Hashable {

	// MARK: - Properties

	var myactions: DolibarrUserPermissionsAgendaMyActions?
	var allactions: DolibarrUserPermissionsAgendaAllActions?

	// MARK: - Inits

	internal init(
		myactions: DolibarrUserPermissionsAgendaMyActions? = nil,
		allactions: DolibarrUserPermissionsAgendaAllActions? = nil
	) {
		self.myactions = myactions
		self.allactions = allactions
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.myactions = try container.decodeIfPresent(DolibarrUserPermissionsAgendaMyActions.self, forKey: .myactions)
		self.allactions = try container.decodeIfPresent(DolibarrUserPermissionsAgendaAllActions.self, forKey: .allactions)
	}

}
