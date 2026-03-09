//
//  ProductType.swift
//  SwiftDolibarr
//
//  Created by William Mead on 01/07/2025.
//

import Foundation
import SwiftUI

struct ProductType: Identifiable, Equatable, Hashable {

	// MARK: - Properties

    var id: UUID = UUID()
	var code: String
    var label: String
	var color: Color
    var sfSymbol: String

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
