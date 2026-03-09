//
//  DolibarrProductStockWarehouse.swift
//  SwiftDolibarr
//
//  Created by William Mead on 02/07/2025.
//

import Foundation

struct DolibarrProductStockWarehouse: Codable, Hashable, Equatable {

	// MARK: - Properties

    var stockWarehouses: [String: DolibarrProductWarehouseStock]

}

struct DolibarrProductWarehouseStock: Codable, Hashable, Equatable, DolibarrObject {

	// MARK: - Properties

    var id: String
    var real: String

}
