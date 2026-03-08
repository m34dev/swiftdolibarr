//
//  CommercialTransaction.swift
//  SwiftDolibarr
//
//  Created by William Mead on 08/02/2026.
//

import Foundation
import OSLog

protocol CommercialTransaction {

	// Properties

	var thirdPartyId: String { get set }
	var statusCode: String { get set }
	var ref: String { get set }
	var totalExclTax: String { get set }
	var totalTax: String { get set }
	var totalInclTax: String { get set }

}
