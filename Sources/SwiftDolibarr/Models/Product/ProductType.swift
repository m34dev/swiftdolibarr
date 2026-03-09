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
//  ProductType.swift
//  SwiftDolibarr
//
//  Created by William Mead on 01/07/2025.
//

import Foundation
import SwiftUI

public struct ProductType: Identifiable, Equatable, Hashable, Sendable {

	// MARK: - Properties

	public var id: UUID = UUID()
	public var code: String
	public var label: String
	public var color: Color
	public var sfSymbol: String

	// MARK: - Static properties

	static let product = ProductType(
		code: "0",
		label: String(localized: "Product"),
		color: .brown,
		sfSymbol: "shippingbox.circle.fill"
	)
	static let service = ProductType(
		code: "1",
		label: String(localized: "Service"),
		color: .blue,
		sfSymbol: "figure.wave.circle.fill"
	)
	static let unknown = ProductType(
		code: "9",
		label: String(localized: "Unknown"),
		color: .black,
		sfSymbol: "questionmark.circle.fill"
	)

    static let allProductTypes: [ProductType] = [product, service]

}
