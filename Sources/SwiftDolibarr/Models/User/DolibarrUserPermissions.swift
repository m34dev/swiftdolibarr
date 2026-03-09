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

struct DolibarrUserPermissions: Codable, Hashable {

	// MARK: - Properties

	var user: DolibarrUserPermissionsUser
	var expensereport: DolibarrUserPermissionsExpenseReport?
	var facture: DolibarrUserPermissionsInvoice?
	var produit: DolibarrUserPermissionsProduct?
	var service: DolibarrUserPermissionsService?
	var ficheinter: DolibarrUserPermissionsIntervention?
	var societe: DolibarrUserPermissionsThirdParty?
	var agenda: DolibarrUserPermissionsAgenda?
	var propale: DolibarrUserPermissionsQuote?
	var commande: DolibarrUserPermissionsOrder?
	var barcode: DolibarrUserPermissionsBarcode?
	var stock: DolibarrUserPermissionsStock?
	var projet: DolibarrUserPermissionsProject?

}
