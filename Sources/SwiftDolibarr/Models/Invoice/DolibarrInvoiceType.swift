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

	public var id: UUID = UUID()
	public var code: String
	public var label: String

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
