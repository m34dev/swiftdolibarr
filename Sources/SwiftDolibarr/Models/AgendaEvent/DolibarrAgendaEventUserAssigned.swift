//
//  DolibarrAgendaEventUserAssigned.swift
//  SwiftDolibarr
//
//  Created by William Mead on 25/06/2025.
//

import Foundation

struct DolibarrAgendaEventUserAssigned: Codable, Equatable, Hashable, DolibarrObject {

	// MARK: - Properties

    var id: String
    var mandatory: String?
    var answerStatus: String?
    var transparency: String?

}
