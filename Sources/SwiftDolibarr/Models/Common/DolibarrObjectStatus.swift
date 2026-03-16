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
//  DolibarrObjectStatus.swift
//  SwiftDolibarr
//
//  Created by William Mead on 09/02/2026.
//

import Foundation
import OSLog
import SwiftUI

public struct DolibarrObjectStatus: Identifiable, Equatable, Hashable, Sendable {

	// MARK: - Properties

	public var id: UUID = UUID()
	public var code: String
	public var label: String
	public var foregroundStyle: AnyShapeStyle
	public var sfSymbol: String

	// MARK: - Static properties

	// Generic

	public static let canceled: DolibarrObjectStatus = .init(
		code: "-1",
		label: String(localized: "Canceled"),
		foregroundStyle: AnyShapeStyle(.gray),
		sfSymbol: "xmark.circle"
	)
	public static let draft: DolibarrObjectStatus = .init(
		code: "0",
		label: String(localized: "Draft"),
		foregroundStyle: AnyShapeStyle(.tertiary),
		sfSymbol: "pencil.circle"
	)
	public static let validated: DolibarrObjectStatus = .init(
		code: "1",
		label: String(localized: "Validated"),
		foregroundStyle: AnyShapeStyle(.orange),
		sfSymbol: "checkmark.circle"
	)
	public static let unknown: DolibarrObjectStatus = .init(
		code: "",
		label: "Unknown",
		foregroundStyle: AnyShapeStyle(.black),
		sfSymbol: "questionmark.circle"
	)

	// ThirdParty & Contacts

	public static let inactive: DolibarrObjectStatus = .init(
		code: "0",
		label: String(localized: "Inactive"),
		foregroundStyle: AnyShapeStyle(.gray),
		sfSymbol: "stop.circle"
	)
	public static let active: DolibarrObjectStatus = .init(
		code: "1",
		label: String(localized: "Active"),
		foregroundStyle: AnyShapeStyle(.green),
		sfSymbol: "play.circle"
	)

	public static let thirdPartiesContacts: [DolibarrObjectStatus] = [inactive, active]

	// Products & Services

	public static let forSaleForPurchase: DolibarrObjectStatus = .init(
		code: "11",
		label: String(localized: "For sale & purchase"),
		foregroundStyle: AnyShapeStyle(.green),
		sfSymbol: "play.circle"
	)
	public static let forSaleNotForPurchase: DolibarrObjectStatus = .init(
		code: "10",
		label: String(localized: "For sale only"),
		foregroundStyle: AnyShapeStyle(.blue),
		sfSymbol: "storefront.circle"
	)
	public static let forPurchaseNotForSale: DolibarrObjectStatus = .init(
		code: "01",
		label: String(localized: "For purchase only"),
		foregroundStyle: AnyShapeStyle(.purple),
		sfSymbol: "cart.circle"
	)
	public static let notForSaleNotForPurchase: DolibarrObjectStatus = .init(
		code: "00",
		label: String(localized: "Not for sale or purchase"),
		foregroundStyle: AnyShapeStyle(.gray),
		sfSymbol: "slash.circle"
	)

	public static let productsServices: [DolibarrObjectStatus] = [
		forSaleForPurchase, forSaleNotForPurchase, forPurchaseNotForSale, notForSaleNotForPurchase
	]

	// Warehouse

	public static let warehouseClosed: DolibarrObjectStatus = .init(
		code: "0",
		label: String(localized: "Closed"),
		foregroundStyle: AnyShapeStyle(.gray),
		sfSymbol: "stop.circle"
	)
	public static let warehouseOpen: DolibarrObjectStatus = .init(
		code: "1",
		label: String(localized: "Open"),
		foregroundStyle: AnyShapeStyle(.green),
		sfSymbol: "play.circle"
	)

	public static let warehouses: [DolibarrObjectStatus] = [warehouseClosed, warehouseOpen]

	// Quote

	public static let quoteSigned: DolibarrObjectStatus = .init(
		code: "2",
		label: String(localized: "Signed"),
		foregroundStyle: AnyShapeStyle(.green),
		sfSymbol: "checkmark.seal")
	public static let quoteNotSigned: DolibarrObjectStatus = .init(
		code: "3",
		label: String(localized: "Not signed"),
		foregroundStyle: AnyShapeStyle(.red),
		sfSymbol: "xmark.seal")
	public static let quoteBilled: DolibarrObjectStatus = .init(
		code: "4",
		label: String(localized: "Billed"),
		foregroundStyle: AnyShapeStyle(.secondary),
		sfSymbol: "creditcard.circle")

	public static let quotes: [DolibarrObjectStatus] = [
		canceled, draft, validated, quoteSigned, quoteNotSigned, quoteBilled
	]

	// Order

	public static let orderBackorder: DolibarrObjectStatus = .init(
		code: "-3",
		label: String(localized: "Backorder"),
		foregroundStyle: AnyShapeStyle(.red),
		sfSymbol: "slash.circle")
	public static let orderShipped: DolibarrObjectStatus = .init(
		code: "2",
		label: String(localized: "Shipped"),
		foregroundStyle: AnyShapeStyle(.blue),
		sfSymbol: "shippingbox.circle")
	public static let orderClosed: DolibarrObjectStatus = .init(
		code: "3",
		label: String(localized: "Delivered"),
		foregroundStyle: AnyShapeStyle(.green),
		sfSymbol: "flag.checkered.circle")

	public static let orders: [DolibarrObjectStatus] = [
		orderBackorder, canceled, draft, validated, orderShipped, orderClosed
	]

	// Invoice

	public static let invoiceClosed: DolibarrObjectStatus = .init(
		code: "2",
		label: String(localized: "Paid"),
		foregroundStyle: AnyShapeStyle(.green),
		sfSymbol: "creditcard.circle")
	public static let invoiceAbandoned: DolibarrObjectStatus = .init(
		code: "3",
		label: String(localized: "Abandoned"),
		foregroundStyle: AnyShapeStyle(.gray),
		sfSymbol: "xmark.circle")

	public static let invoices: [DolibarrObjectStatus] = [draft, validated, invoiceClosed, invoiceAbandoned]

	// Intervention

	public static let interventionBilled: DolibarrObjectStatus = .init(
		code: "2",
		label: String(localized: "Billed"),
		foregroundStyle: AnyShapeStyle(.secondary),
		sfSymbol: "creditcard.circle")
	public static let interventionClosed: DolibarrObjectStatus = .init(
		code: "3",
		label: String(localized: "Done"),
		foregroundStyle: AnyShapeStyle(.green),
		sfSymbol: "flag.checkered.circle")

	public static let interventions: [DolibarrObjectStatus] = [draft, validated, interventionBilled, interventionClosed]

	// Expense report

	public static let expenseReportValidated: DolibarrObjectStatus = .init(
		code: "2",
		label: String(localized: "Validated"),
		foregroundStyle: AnyShapeStyle(.orange),
		sfSymbol: "checkmark.circle")
	public static let expenseReportCanceled: DolibarrObjectStatus = .init(
		code: "4",
		label: String(localized: "Canceled"),
		foregroundStyle: AnyShapeStyle(.gray),
		sfSymbol: "xmark.circle")
	public static let expenseReportApproved: DolibarrObjectStatus = .init(
		code: "5",
		label: String(localized: "Approved"),
		foregroundStyle: AnyShapeStyle(.green),
		sfSymbol: "checkmark.seal")
	public static let expenseReportClosed: DolibarrObjectStatus = .init(
		code: "6",
		label: String(localized: "Paid"),
		foregroundStyle: AnyShapeStyle(.secondary),
		sfSymbol: "creditcard.circle")
	public static let expenseReportRefused: DolibarrObjectStatus = .init(
		code: "99",
		label: String(localized: "Refused"),
		foregroundStyle: AnyShapeStyle(.red),
		sfSymbol: "xmark.seal")

	public static let expenseReports: [DolibarrObjectStatus] = [
		draft, expenseReportValidated, expenseReportCanceled, expenseReportApproved, expenseReportClosed, expenseReportRefused
	]

	// Project

	public static let projectClosed: DolibarrObjectStatus = .init(
		code: "2",
		label: String(localized: "Closed"),
		foregroundStyle: AnyShapeStyle(.secondary),
		sfSymbol: "flag.checkered.circle"
	)

	public static let projects: [DolibarrObjectStatus] = [draft, validated, projectClosed]

	// Task

	public static let taskClosed: DolibarrObjectStatus = .init(
		code: "3",
		label: String(localized: "Done"),
		foregroundStyle: AnyShapeStyle(.secondary),
		sfSymbol: "flag.checkered.circle"
	)

	public static let taskTransferred: DolibarrObjectStatus = .init(
		code: "4",
		label: String(localized: "Transferred"),
		foregroundStyle: AnyShapeStyle(.gray),
		sfSymbol: "arrow.left.arrow.right.circle"
	)

	public static let taskCanceled: DolibarrObjectStatus = .init(
		code: "9",
		label: String(localized: "Canceled"),
		foregroundStyle: AnyShapeStyle(.gray),
		sfSymbol: "xmark.circle"
	)

	public static let task: [DolibarrObjectStatus] = [
		draft, validated, taskClosed, taskTransferred, taskCanceled
	]

	// Agenda event

	public static let agendaEventNA: DolibarrObjectStatus = .init(
		code: "-1",
		label: String(localized: "N/A"),
		foregroundStyle: AnyShapeStyle(.gray),
		sfSymbol: "nosign"
	)
	public static let agendaEventToDo: DolibarrObjectStatus = .init(
		code: "0",
		label: String(localized: "To do"),
		foregroundStyle: AnyShapeStyle(.orange),
		sfSymbol: "pause.circle"
	)
	public static let agendaEventInProgress: DolibarrObjectStatus = .init(
		code: "50",
		label: String(localized: "In progress"),
		foregroundStyle: AnyShapeStyle(.blue),
		sfSymbol: "play.circle"
	)
	public static let agendaEventFinished: DolibarrObjectStatus = .init(
		code: "100",
		label: String(localized: "Finished"),
		foregroundStyle: AnyShapeStyle(.green),
		sfSymbol: "flag.checkered.circle"
	)

	public static let agendaEvents: [DolibarrObjectStatus] = [
		agendaEventNA, agendaEventToDo, agendaEventInProgress, agendaEventFinished
	]

	// MARK: - Protocol methods

	public static func == (lhs: DolibarrObjectStatus, rhs: DolibarrObjectStatus) -> Bool {
		lhs.id == rhs.id &&
		lhs.code == rhs.code
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(id)
		hasher.combine(code)
		hasher.combine(label)
		hasher.combine(sfSymbol)
	}

}
