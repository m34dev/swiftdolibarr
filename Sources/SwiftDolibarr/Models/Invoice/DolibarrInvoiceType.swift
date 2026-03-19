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
//  DolibarrInvoiceType.swift
//  SwiftDolibarr
//
//  Created by William Mead on 23/02/2026.
//

import Foundation

public struct DolibarrInvoiceType: Equatable, Hashable, Sendable {

	// MARK: - Properties

	/// Invoice type unique identifier
	public var id: UUID = UUID()

	/// Invoice type code
	public var code: String

	// MARK: - Static properties

	public static let standard = DolibarrInvoiceType(code: "0")
	public static let replacement = DolibarrInvoiceType(code: "1")
	public static let creditNote = DolibarrInvoiceType(code: "2")
	public static let deposit = DolibarrInvoiceType(code: "3")
	public static let proforma = DolibarrInvoiceType(code: "4") // Deprecated
	public static let situation = DolibarrInvoiceType(code: "5")
	public static let unknown = DolibarrInvoiceType(code: "")

	public static let allTypes: [DolibarrInvoiceType] = [standard, replacement, creditNote, deposit, proforma, situation]

}
