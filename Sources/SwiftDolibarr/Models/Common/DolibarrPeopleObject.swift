//
//  DolibarrPeopleObject.swift
//  SwiftDolibarr
//
//  Created by William Mead on 02/05/2025.
//

import Foundation
import OSLog

protocol DolibarrPeopleObject: Hashable {

    var name: String { get }
    var email: String? { get set }
	var socialnetworks: [String: String]? { get set }

}
