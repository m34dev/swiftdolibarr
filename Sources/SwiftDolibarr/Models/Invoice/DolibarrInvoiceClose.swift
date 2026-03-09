// Copyright 2026 M34D - William Mead
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// 	http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//
//  DolibarrInvoiceClose.swift
//  SwiftDolibarr
//
//  Created by William Mead on 04/03/2026.
//

import Foundation

public struct DolibarrInvoiceClose: Identifiable, Hashable, Sendable {

	// MARK: - Properties

	public var id: UUID = UUID()
	public var code: String
	public var label: String

	// MARK: - Static properties

	static let discount = DolibarrInvoiceClose(code: "discount_vat", label: String(localized: "Early payment discount"))
	static let badDebt = DolibarrInvoiceClose(code: "badcustomer", label: String(localized: "Bad customer"))
	static let bankCharge = DolibarrInvoiceClose(code: "bankcharge", label: String(localized: "Bank fee"))
	static let withholdingTax = DolibarrInvoiceClose(code: "withholdingtax", label: String(localized: "Withholding tax"))
	static let other = DolibarrInvoiceClose(code: "other", label: String(localized: "Other"))
	static let abandoned = DolibarrInvoiceClose(code: "abandon", label: String(localized: "Abandoned"))
	static let replaced = DolibarrInvoiceClose(code: "replaced", label: String(localized: "Replaced"))

	static let allClose: [DolibarrInvoiceClose] = [
		discount, badDebt, bankCharge, withholdingTax, other, abandoned, replaced
	]

}
