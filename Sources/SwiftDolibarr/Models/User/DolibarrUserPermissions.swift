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
//  DolibarrUserPermissions.swift
//  SwiftDolibarr
//
//  Created by William Mead on 19/05/2025.
//

import Foundation

public struct DolibarrUserPermissions: Codable, Hashable {

	// MARK: - Properties

	public var user: DolibarrUserPermissionsUser
	public var expensereport: DolibarrUserPermissionsExpenseReport?
	public var facture: DolibarrUserPermissionsInvoice?
	public var produit: DolibarrUserPermissionsProduct?
	public var service: DolibarrUserPermissionsService?
	public var ficheinter: DolibarrUserPermissionsIntervention?
	public var societe: DolibarrUserPermissionsThirdParty?
	public var agenda: DolibarrUserPermissionsAgenda?
	public var propale: DolibarrUserPermissionsQuote?
	public var commande: DolibarrUserPermissionsOrder?
	public var barcode: DolibarrUserPermissionsBarcode?
	public var stock: DolibarrUserPermissionsStock?
	public var projet: DolibarrUserPermissionsProject?

}
