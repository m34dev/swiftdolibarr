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

	/// Invoice close unique identifier
	public var id: UUID = UUID()

	/// Invoice close code
	public var code: String

	// MARK: - Static properties

	public static let discount = DolibarrInvoiceClose(code: "discount_vat")
	public static let badDebt = DolibarrInvoiceClose(code: "badcustomer")
	public static let bankCharge = DolibarrInvoiceClose(code: "bankcharge")
	public static let withholdingTax = DolibarrInvoiceClose(code: "withholdingtax")
	public static let other = DolibarrInvoiceClose(code: "other")
	public static let abandoned = DolibarrInvoiceClose(code: "abandon")
	public static let replaced = DolibarrInvoiceClose(code: "replaced")
	public static let unknown = DolibarrInvoiceClose(code: "")

	public static let allClose: [DolibarrInvoiceClose] = [
		discount, badDebt, bankCharge, withholdingTax, other, abandoned, replaced
	]

}
