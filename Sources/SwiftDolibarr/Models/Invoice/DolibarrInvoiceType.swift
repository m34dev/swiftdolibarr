//
//  DolibarrInvoiceType.swift
//  SwiftDolibarr
//
//  Created by William Mead on 23/02/2026.
//

import Foundation

struct DolibarrInvoiceType: Equatable, Hashable {

	// MARK: - Properties

	var id: UUID = UUID()
	var code: String
	var label: String

	// MARK: - Static properties

	static let standard: DolibarrInvoiceType = .init(code: "0", label: String(localized: "Standard"))
	static let replacement: DolibarrInvoiceType = .init(code: "1", label: String(localized: "Replacement"))
	static let creditNote: DolibarrInvoiceType = .init(code: "2", label: String(localized: "Credit note"))
	static let deposit: DolibarrInvoiceType = .init(code: "3", label: String(localized: "Deposit"))
	static let proforma: DolibarrInvoiceType = .init(code: "4", label: String(localized: "Proforma")) // Deprecated
	static let situation: DolibarrInvoiceType = .init(code: "5", label: String(localized: "Situation"))
	static let unknown: DolibarrInvoiceType = .init(code: "", label: String(localized: "Unknown"))

	static let allTypes: [DolibarrInvoiceType] = [standard, replacement, creditNote, deposit, proforma, situation]

}
