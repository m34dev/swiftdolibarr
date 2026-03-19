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

/// Represents the type of a Dolibarr product entry.
///
/// Predefined static instances: ``product`` (code `"0"`) and
/// ``service`` (code `"1"`).
///
/// - SeeAlso: ``DolibarrProduct``
public struct ProductType: Identifiable, Equatable, Hashable, Sendable {

	// MARK: - Properties

	/// Product type unique identifier
	public var id: UUID = UUID()

	/// Product type code
	public var code: String

	// MARK: - Static properties

	public static let product = ProductType(code: "0")
	public static let service = ProductType(code: "1")
	public static let unknown = ProductType(code: "9")

	public static let allProductTypes: [ProductType] = [product, service]

}
