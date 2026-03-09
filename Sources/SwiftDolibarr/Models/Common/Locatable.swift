//
//  Locatable.swift
//  SwiftDolibarr
//
//  Created by William Mead on 16/07/2025.
//

import Foundation
import OSLog

protocol Locatable: Hashable {

    // Properties

    var address: String? { get set }
    var zipCode: String? { get set }
    var city: String? { get set }
    var countryId: String? { get set }

}
