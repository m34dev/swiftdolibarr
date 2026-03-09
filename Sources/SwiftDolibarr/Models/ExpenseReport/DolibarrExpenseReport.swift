//
//  DolibarrExpenseReport.swift
//  SwiftDolibarr
//
//  Created by William Mead on 27/05/2025.
//

import Foundation
import OSLog

@Observable final class DolibarrExpenseReport: CommonBusinessObject {

    // MARK: - Properties

	// Required

	var lines: [DolibarrExpenseReportLine]

	// Optional

    var ref: String
    var dateStart: Int
    var dateEnd: Int
    var dateCreated: Int
    var dateValidated: String
    var dateApproved: String
    var dateRefused: String
    var dateCanceled: String
    var userAuthorId: String
    var userValidatorId: String?
    var userApprovedById: String?
    var userCanceledById: String?
    var userRefusedById: String?
    var detailCanceled: String?
    var detailRefused: String?
    var paid: String
    var totalExclTax: String
    var totalTax: String
    var totalInclTax: String

	// Computed

	override var status: DolibarrObjectStatus {
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

    init(
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

    required init(from decoder: any Decoder) throws {
        do {
            Logger.logWithoutSignal("\(Self.self).init.decode", level: .info, category: .api)
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
            Logger.logWithoutSignal("\(Self.self).init.decoded", level: .info, category: .api)
        } catch let error as DecodingError {
			Logger.logDecodingError(error, decodeContext: "\(Self.self).init")
			throw error
        } catch {
            Logger.logErrorWithSignal(error, context: "\(Self.self).init", category: .api)
            throw error
        }
    }

    // MARK: - Protocol methods

    override func hash(into hasher: inout Hasher) {
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

    override func encode(to encoder: any Encoder) throws {
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
