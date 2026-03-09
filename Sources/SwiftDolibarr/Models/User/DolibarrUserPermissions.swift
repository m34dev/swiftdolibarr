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
