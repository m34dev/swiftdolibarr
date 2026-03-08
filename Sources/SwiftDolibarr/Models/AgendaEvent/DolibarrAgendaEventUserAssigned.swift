//
//  DolibarrAgendaEventUserAssigned.swift
//  SwiftDolibarr
//
//  Created by William Mead on 25/06/2025.
//

import Foundation

struct DolibarrAgendaEventUserAssigned: Identifiable, Codable, Equatable, Hashable {

	// MARK: - Properties

    var id: String
    var mandatory: String?
    var answer_status: String?
    var transparency: String?
	
}
