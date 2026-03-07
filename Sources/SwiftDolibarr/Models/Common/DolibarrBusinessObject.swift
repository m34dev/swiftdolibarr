//
//  DolibarrBusinessObject.swift
//  SwiftDolibarr
//
//  Created by William Mead on 24/12/2024.
//

import Foundation

protocol DolibarrBusinessObject: Hashable, DolibarrObject {

    // Properties

    var statusCode: String { get set }
    var arrayOptions: [String: MultiType]? { get set }
    var notePublic: String? { get set }
    var notePrivate: String? { get set }

    // Computed properties

    var status: DolibarrObjectStatus { get }

}
