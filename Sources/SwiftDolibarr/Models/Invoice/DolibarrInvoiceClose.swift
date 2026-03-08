//
//  DolibarrInvoiceClose.swift
//  SwiftDolibarr
//
//  Created by William Mead on 04/03/2026.
//

import Foundation

struct DolibarrInvoiceClose: Identifiable, Hashable {

	// MARK: - Properties

	var id: UUID = UUID()
	var code: String
	var label: String

	// MARK: - Static properties

	static let discount = DolibarrInvoiceClose(code: "discount_vat", label: String(localized: "Early payment discount"))
	static let badDebt = DolibarrInvoiceClose(code: "badcustomer", label: String(localized: "Bad customer"))
	static let bankCharge = DolibarrInvoiceClose(code: "bankcharge", label: String(localized: "Bank fee"))
	static let withholdingTax = DolibarrInvoiceClose(code: "withholdingtax", label: String(localized: "Withholding tax"))
	static let other = DolibarrInvoiceClose(code: "other", label: String(localized: "Other"))
	static let abandoned = DolibarrInvoiceClose(code: "abandon", label: String(localized: "Abandoned"))
	static let replaced = DolibarrInvoiceClose(code: "replaced", label: String(localized: "Replaced"))

	static let allClose: [DolibarrInvoiceClose] = [discount, badDebt, bankCharge, withholdingTax, other, abandoned, replaced]

}
