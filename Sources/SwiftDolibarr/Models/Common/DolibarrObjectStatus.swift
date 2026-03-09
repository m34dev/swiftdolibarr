//
//  DolibarrObjectStatus.swift
//  SwiftDolibarr
//
//  Created by William Mead on 09/02/2026.
//

import Foundation
import OSLog
import SwiftUI

struct DolibarrObjectStatus: Identifiable, Equatable, Hashable {

	// MARK: - Properties

	var id: UUID = UUID()
	var code: String
	var label: String
	var color: Color
	var sfSymbol: String

	// MARK: - Static properties

	// Generic

	static let canceled: DolibarrObjectStatus = .init(
		code: "-1",
		label: String(localized: "Canceled"),
		color: .gray,
		sfSymbol: "xmark.circle"
	)
	static let draft: DolibarrObjectStatus = .init(
		code: "0",
		label: String(localized: "Draft"),
		color: Color(UIColor.tertiaryLabel),
		sfSymbol: "pencil.circle"
	)
	static let validated: DolibarrObjectStatus = .init(
		code: "1",
		label: String(localized: "Validated"),
		color: .orange,
		sfSymbol: "checkmark.circle"
	)
	static let unknown: DolibarrObjectStatus = .init(
		code: "",
		label: "Unknown",
		color: .black,
		sfSymbol: "questionmark.circle"
	)

	// ThirdParty & Contacts

	static let inactive: DolibarrObjectStatus = .init(
		code: "0",
		label: String(localized: "Inactive"),
		color: .gray,
		sfSymbol: "stop.circle"
	)
	static let active: DolibarrObjectStatus = .init(
		code: "1",
		label: String(localized: "Active"),
		color: .green,
		sfSymbol: "play.circle"
	)

	static let thirdPartiesContacts: [DolibarrObjectStatus] = [inactive, active]

	// Products & Services

	static let forSaleForPurchase: DolibarrObjectStatus = .init(
		code: "11",
		label: String(localized: "For sale & purchase"),
		color: .green,
		sfSymbol: "play.circle"
	)
	static let forSaleNotForPurchase: DolibarrObjectStatus = .init(
		code: "10",
		label: String(localized: "For sale only"),
		color: .blue,
		sfSymbol: "storefront.circle"
	)
	static let forPurchaseNotForSale: DolibarrObjectStatus = .init(
		code: "01",
		label: String(localized: "For purchase only"),
		color: .purple,
		sfSymbol: "cart.circle"
	)
	static let notForSaleNotForPurchase: DolibarrObjectStatus = .init(
		code: "00",
		label: String(localized: "Not for sale or purchase"),
		color: .gray,
		sfSymbol: "slash.circle"
	)

	static let productsServices: [DolibarrObjectStatus] = [
		forSaleForPurchase, forSaleNotForPurchase, forPurchaseNotForSale, notForSaleNotForPurchase
	]

	// Warehouse

	static let closed: DolibarrObjectStatus = .init(
		code: "0",
		label: String(localized: "Closed"),
		color: .gray,
		sfSymbol: "stop.circle"
	)
	static let open: DolibarrObjectStatus = .init(
		code: "1",
		label: String(localized: "Open"),
		color: .green,
		sfSymbol: "play.circle"
	)

	static let warehouses: [DolibarrObjectStatus] = [closed, open]

	// Quote

	static let quoteSigned: DolibarrObjectStatus = .init(
		code: "2",
		label: String(localized: "Signed"),
		color: .green,
		sfSymbol: "checkmark.seal")
	static let quoteNotSigned: DolibarrObjectStatus = .init(
		code: "3",
		label: String(localized: "Not signed"),
		color: .red,
		sfSymbol: "xmark.seal")
	static let quoteBilled: DolibarrObjectStatus = .init(
		code: "4",
		label: String(localized: "Billed"),
		color: Color(UIColor.secondaryLabel),
		sfSymbol: "creditcard.circle")

	static let quotes: [DolibarrObjectStatus] = [canceled, draft, validated, quoteSigned, quoteNotSigned, quoteBilled]

	// Order

	static let orderBackorder: DolibarrObjectStatus = .init(
		code: "-3",
		label: String(localized: "Backorder"),
		color: .red,
		sfSymbol: "slash.circle")
	static let orderShipped: DolibarrObjectStatus = .init(
		code: "2",
		label: String(localized: "Shipped"),
		color: .blue,
		sfSymbol: "shippingbox.circle")
	static let orderClosed: DolibarrObjectStatus = .init(
		code: "3",
		label: String(localized: "Delivered"),
		color: .green,
		sfSymbol: "flag.checkered.circle")

	static let orders: [DolibarrObjectStatus] = [orderBackorder, canceled, draft, validated, orderShipped, orderClosed]

	// Invoice

	static let invoiceClosed: DolibarrObjectStatus = .init(
		code: "2",
		label: String(localized: "Paid"),
		color: .green,
		sfSymbol: "creditcard.circle")
	static let invoiceAbandoned: DolibarrObjectStatus = .init(
		code: "3",
		label: String(localized: "Abandoned"),
		color: .gray,
		sfSymbol: "xmark.circle")

	static let invoices: [DolibarrObjectStatus] = [draft, validated, invoiceClosed, invoiceAbandoned]

	// Intervention

	static let interventionBilled: DolibarrObjectStatus = .init(
		code: "2",
		label: String(localized: "Billed"),
		color: Color(UIColor.secondaryLabel),
		sfSymbol: "creditcard.circle")
	static let interventionClosed: DolibarrObjectStatus = .init(
		code: "3",
		label: String(localized: "Done"),
		color: .green,
		sfSymbol: "flag.checkered.circle")

	static let interventions: [DolibarrObjectStatus] = [draft, validated, interventionBilled, interventionClosed]

	// Expense report

	static let expenseReportValidated: DolibarrObjectStatus = .init(
		code: "2",
		label: String(localized: "Validated"),
		color: .orange,
		sfSymbol: "checkmark.circle")
	static let expenseReportCanceled: DolibarrObjectStatus = .init(
		code: "4",
		label: String(localized: "Canceled"),
		color: .gray,
		sfSymbol: "xmark.circle")
	static let expenseReportApproved: DolibarrObjectStatus = .init(
		code: "5",
		label: String(localized: "Approved"),
		color: .green,
		sfSymbol: "checkmark.seal")
	static let expenseReportClosed: DolibarrObjectStatus = .init(
		code: "6",
		label: String(localized: "Paid"),
		color: Color(UIColor.secondaryLabel),
		sfSymbol: "creditcard.circle")
	static let expenseReportRefused: DolibarrObjectStatus = .init(
		code: "99",
		label: String(localized: "Refused"),
		color: .red,
		sfSymbol: "xmark.seal")

	static let expenseReports: [DolibarrObjectStatus] = [
		draft, expenseReportValidated, expenseReportCanceled, expenseReportApproved, expenseReportClosed, expenseReportRefused
	]

	// Project

	static let projectClosed: DolibarrObjectStatus = .init(
		code: "2",
		label: String(localized: "Closed"),
		color: Color(UIColor.secondaryLabel),
		sfSymbol: "flag.checkered.circle"
	)

	static let projects: [DolibarrObjectStatus] = [draft, validated, projectClosed]

	// Agenda event

	static let agendaEventNA: DolibarrObjectStatus = .init(
		code: "-1",
		label: String(localized: "N/A"),
		color: .gray,
		sfSymbol: "nosign"
	)
	static let agendaEventToDo: DolibarrObjectStatus = .init(
		code: "0",
		label: String(localized: "To do"),
		color: .orange,
		sfSymbol: "pause.circle"
	)
	static let agendaEventInProgress: DolibarrObjectStatus = .init(
		code: "50",
		label: String(localized: "In progress"),
		color: .blue,
		sfSymbol: "play.circle"
	)
	static let agendaEventFinished: DolibarrObjectStatus = .init(
		code: "100",
		label: String(localized: "Finished"),
		color: .green,
		sfSymbol: "flag.checkered.circle"
	)

	static let agendaEvents: [DolibarrObjectStatus] = [
		agendaEventNA, agendaEventToDo, agendaEventInProgress, agendaEventFinished
	]

}
