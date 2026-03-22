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
//  DolibarrExpenseReport.swift
//  SwiftDolibarr
//
//  Created by William Mead on 27/05/2025.
//

import Foundation
#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
import OSLog
#endif

/// A Dolibarr expense report object.
///
/// Maps to the Dolibarr `/expensereports` REST API endpoint. Tracks employee
/// expenses through a validation and approval workflow.
///
/// ## Overview
///
/// Each expense report has a ``status``, an array of ``DolibarrExpenseReportLine`` items,
/// date range, totals, and references to author, validator, and approver users.
///
/// - Note: Requires the **Expensereport** module to be activated in Dolibarr.
/// - SeeAlso: ``DolibarrExpenseReportLine``
@Observable public final class DolibarrExpenseReport: CommonBusinessObject {

    // MARK: - Properties

	// Required

	/// Expense report lines
	public var lines: [DolibarrExpenseReportLine]

	// Optional

	/// Expense report reference
	public var ref: String

	/// Expense report start date (Unix timestamp)
	///
	/// - Mapped Dolibarr property: **date_debut**
	public var dateStart: Int

	/// Expense report end date (Unix timestamp)
	///
	/// - Mapped Dolibarr property: **date_fin**
	public var dateEnd: Int

	/// Expense report creation date (Unix timestamp)
	///
	/// - Mapped Dolibarr property: **date_create**
	public var dateCreated: Int

	/// Expense report validation date
	///
	/// - Mapped Dolibarr property: **date_valid**
	public var dateValidated: String

	/// Expense report approval date
	///
	/// - Mapped Dolibarr property: **date_approve**
	public var dateApproved: String

	/// Expense report refusal date
	///
	/// - Mapped Dolibarr property: **date_refuse**
	public var dateRefused: String

	/// Expense report cancellation date
	///
	/// - Mapped Dolibarr property: **date_cancel**
	public var dateCanceled: String

	/// Expense report author user ID
	///
	/// - Mapped Dolibarr property: **fk_user_author**
	public var userAuthorId: String

	/// Expense report validator user ID
	///
	/// - Mapped Dolibarr property: **fk_user_validator**
	public var userValidatorId: String?

	/// Expense report approver user ID
	///
	/// - Mapped Dolibarr property: **fk_user_approve**
	public var userApprovedById: String?

	/// Expense report canceler user ID
	///
	/// - Mapped Dolibarr property: **fk_user_cancel**
	public var userCanceledById: String?

	/// Expense report refuser user ID
	///
	/// - Mapped Dolibarr property: **fk_user_refuse**
	public var userRefusedById: String?

	/// Expense report cancellation detail
	///
	/// - Mapped Dolibarr property: **detail_cancel**
	public var detailCanceled: String?

	/// Expense report refusal detail
	///
	/// - Mapped Dolibarr property: **detail_refuse**
	public var detailRefused: String?

	/// Expense report paid status
	public var paid: String

	/// Expense report total amount excluding tax
	///
	/// - Mapped Dolibarr property: **total_ht**
	public var totalExclTax: String

	/// Expense report total tax amount
	///
	/// - Mapped Dolibarr property: **total_tva**
	public var totalTax: String

	/// Expense report total amount including tax
	///
	/// - Mapped Dolibarr property: **total_ttc**
	public var totalInclTax: String

	// Computed

	/// Associated expense report status type
	override public var status: DolibarrObjectStatus {
		guard let status = DolibarrObjectStatus.expenseReports.first(where: { $0.code == statusCode }) else {
			return .unknown
		}
		return status
	}

    // MARK: - Enums

    enum CodingKeys: String, CodingKey {
        case ref
        case dateStart = "date_debut"
        case dateEnd = "date_fin"
        case dateCreated = "date_create"
        case dateValidated = "date_valid"
        case dateApproved = "date_approve"
        case dateRefused = "date_refuse"
        case dateCanceled = "date_cancel"
        case userAuthorId = "fk_user_author"
        case userValidatorId = "fk_user_validator"
        case userApprovedById = "fk_user_approve"
        case userCanceledById = "fk_user_cancel"
        case userRefusedById = "fk_user_refuse"
        case detailCanceled = "detail_cancel"
        case detailRefused = "detail_refuse"
        case paid
        case totalExclTax = "total_ht"
        case totalTax = "total_tva"
        case totalInclTax = "total_ttc"
        case lines
    }

    // MARK: - Inits

	public init(
        ref: String = "",
        dateStart: Int = 0,
        dateEnd: Int = 0,
        dateCreated: Int = 0,
        dateValidated: String = "",
        dateApproved: String = "",
        dateRefused: String = "",
        dateCanceled: String = "",
        userAuthorId: String = "",
        userValidatorId: String? = nil,
        userApprovedById: String? = nil,
        userCanceledById: String? = nil,
        userRefusedById: String? = nil,
        detailCanceled: String? = nil,
        detailRefused: String? = nil,
        paid: String = "",
        totalExclTax: String = "",
        totalTax: String = "",
        totalInclTax: String = "",
        lines: [DolibarrExpenseReportLine] = [],
        id: String = "",
        statusCode: String = "",
        arrayOptions: [String: MultiType]? = nil,
        notePublic: String? = nil,
        notePrivate: String? = nil
    ) {
        self.ref = ref
        self.dateStart = dateStart
        self.dateEnd = dateEnd
        self.dateCreated = dateCreated
        self.dateValidated = dateValidated
        self.dateApproved = dateApproved
        self.dateRefused = dateRefused
        self.dateCanceled = dateCanceled
        self.userAuthorId = userAuthorId
        self.userValidatorId = userValidatorId
        self.userApprovedById = userApprovedById
        self.userCanceledById = userCanceledById
        self.userRefusedById = userRefusedById
        self.detailCanceled = detailCanceled
        self.detailRefused = detailRefused
        self.paid = paid
        self.totalExclTax = totalExclTax
        self.totalTax = totalTax
        self.totalInclTax = totalInclTax
        self.lines = lines
		super.init(
			id: id,
			statusCode: statusCode,
			arrayOptions: arrayOptions,
			notePublic: notePublic,
			notePrivate: notePrivate
		)
    }

	public required init(from decoder: any Decoder) throws {
        do {
            #if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
            Logger.logWithoutSignal("\(Self.self).init.decode", level: .info, category: .api)
            #endif
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.ref = try container.decode(String.self, forKey: .ref)
            self.dateStart = try container.decode(Int.self, forKey: .dateStart)
            self.dateEnd = try container.decode(Int.self, forKey: .dateEnd)
            self.dateCreated = try container.decode(Int.self, forKey: .dateCreated)
            self.dateValidated = try container.decode(MultiType.self, forKey: .dateValidated).stringValue
            self.dateApproved = try container.decode(MultiType.self, forKey: .dateApproved).stringValue
            self.dateRefused = try container.decode(MultiType.self, forKey: .dateRefused).stringValue
            self.dateCanceled = try container.decode(MultiType.self, forKey: .dateCanceled).stringValue
            self.userAuthorId = try container.decode(String.self, forKey: .userAuthorId)
            self.userValidatorId = try container.decodeIfPresent(String.self, forKey: .userValidatorId)
            self.userApprovedById = try container.decodeIfPresent(String.self, forKey: .userApprovedById)
            self.userCanceledById = try container.decodeIfPresent(String.self, forKey: .userCanceledById)
            self.userRefusedById = try container.decodeIfPresent(String.self, forKey: .userRefusedById)
            self.detailCanceled = try container.decodeIfPresent(String.self, forKey: .detailCanceled)
            self.detailRefused = try container.decodeIfPresent(String.self, forKey: .detailRefused)
            self.paid = try container.decode(String.self, forKey: .paid)
            self.totalExclTax = try container.decode(String.self, forKey: .totalExclTax)
            self.totalTax = try container.decode(String.self, forKey: .totalTax)
            self.totalInclTax = try container.decode(String.self, forKey: .totalInclTax)
            self.lines = try container.decode([DolibarrExpenseReportLine].self, forKey: .lines)
			try super.init(from: decoder)
            #if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
            Logger.logWithoutSignal("\(Self.self).init.decoded", level: .info, category: .api)
            #endif
        } catch let error as DecodingError {
			#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
			Logger.logDecodingError(error, decodeContext: "\(Self.self).init")
			#endif
			throw error
        } catch {
            #if os(iOS) || os(macOS) || os(watchOS) || os(tvOS) || os(visionOS)
            Logger.logErrorWithSignal(error, context: "\(Self.self).init", category: .api)
            #endif
            throw error
        }
    }

    // MARK: - Protocol methods

    override public func hash(into hasher: inout Hasher) {
        hasher.combine(ref)
		hasher.combine(dateStart)
		hasher.combine(dateEnd)
		hasher.combine(dateCreated)
		hasher.combine(dateValidated)
		hasher.combine(dateApproved)
		hasher.combine(dateRefused)
		hasher.combine(dateCanceled)
		hasher.combine(userAuthorId)
		hasher.combine(optional: userValidatorId)
		hasher.combine(optional: userApprovedById)
		hasher.combine(optional: userCanceledById)
		hasher.combine(optional: userRefusedById)
		hasher.combine(optional: detailRefused)
		hasher.combine(optional: detailCanceled)
		hasher.combine(paid)
		hasher.combine(totalExclTax)
		hasher.combine(totalTax)
		hasher.combine(totalInclTax)
		hasher.combine(lines)
		super.hash(into: &hasher)
    }

    override public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfNotEmpty(ref, forKey: .ref)
		try container.encodeIfNotZero(dateStart, forKey: .dateStart)
		try container.encodeIfNotZero(dateEnd, forKey: .dateEnd)
		try container.encodeIfNotZero(dateCreated, forKey: .dateCreated)
		try container.encodeIfNotEmpty(dateValidated, forKey: .dateValidated)
		try container.encodeIfNotEmpty(dateApproved, forKey: .dateApproved)
		try container.encodeIfNotEmpty(dateRefused, forKey: .dateRefused)
		try container.encodeIfNotEmpty(dateCanceled, forKey: .dateCanceled)
		try container.encodeIfNotEmpty(userAuthorId, forKey: .userAuthorId)
		try container.encodeIfPresentAndNotEmpty(userValidatorId, forKey: .userValidatorId)
		try container.encodeIfPresentAndNotEmpty(userApprovedById, forKey: .userApprovedById)
		try container.encodeIfPresentAndNotEmpty(userCanceledById, forKey: .userCanceledById)
		try container.encodeIfPresentAndNotEmpty(userRefusedById, forKey: .userRefusedById)
		try container.encodeIfPresentAndNotEmpty(detailCanceled, forKey: .detailCanceled)
		try container.encodeIfPresentAndNotEmpty(detailRefused, forKey: .detailRefused)
		try container.encodeIfNotEmpty(paid, forKey: .paid)
		try container.encodeIfNotEmpty(totalExclTax, forKey: .totalExclTax)
		try container.encodeIfNotEmpty(totalTax, forKey: .totalTax)
		try container.encodeIfNotEmpty(totalInclTax, forKey: .totalInclTax)
		try super.encode(to: encoder)
    }

}
