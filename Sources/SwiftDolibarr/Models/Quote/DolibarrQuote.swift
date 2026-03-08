//
//  DolibarrQuote.swift
//  SwiftDolibarr
//
//  Created by William Mead on 11/08/2025.
//

import Foundation
import OSLog

@Observable final class DolibarrQuote: CommonCommercialTransactionObject {

	// MARK: - Properties

	// Required

	var lines: [DolibarrQuoteLine]

	// Optional

	var clientRef: String?
	var dateP: Int
	var dateV: Int?
	var validityEndDate: Int?
	var deliveryDate: Int?
 	var pdfModel: String?
	var lastMainDoc: String?
	var userAuthorId: String
	var paymentMethodId: String?
	var paymentTermsId: String?
	var availabilityId: String?
	var shippingMethodId: String?
	var sourceReasonId: String?
	var externalContactIds: [String]?

	// Computed

	override var status: DolibarrObjectStatus {
		guard let status = DolibarrObjectStatus.quotes.first(where: { $0.code == statusCode }) else { return .unknown }
		return status
	}

	// MARK: - Enums

	enum Errors: String, Error {
		case createQuote = "Unable to create quote"
		case readQuote = "Unable to read quote"
		case readQuotes = "Unable to read quotes"
		case updateQuote = "Unable to update quote"
		case updateQuoteStatus = "Unable to update quote status"
		case routeNotFound = "Route not found"
		case readExternalContacts = "Unable to read external contacts"
	}

	enum CodingKeys: String, CodingKey {
		case lines
		case clientRef = "ref_client"
		case dateP = "datep"
		case dateV = "datev"
		case validityEndDate = "fin_validite"
		case deliveryDate = "delivery_date"
		case pdfModel = "model_pdf"
		case lastMainDoc = "last_main_doc"
		case userAuthorId = "user_author_id"
		case paymentMethodId = "mode_reglement_id"
		case paymentTermsId = "cond_reglement_id"
		case availabilityId = "availability_id"
		case shippingMethodId = "shipping_method_id"
		case sourceReasonId = "demand_reason_id"
		case externalContactIds = "contacts_ids"
	}

	// MARK: - Inits

	init(
		lines: [DolibarrQuoteLine] = [],
		clientRef: String? = nil,
		dateP: Int = 0,
		dateV: Int? = nil,
		validityEndDate: Int? = nil,
		deliveryDate: Int? = nil,
		pdfModel: String? = nil,
		lastMainDoc: String? = nil,
		userAuthorId: String = "",
		paymentMethodId: String? = nil,
		paymentTermsId: String? = nil,
		availabilityId: String? = nil,
		shippingMethodId: String? = nil,
		sourceReasonId: String? = nil,
		externalContactIds: [String]? = nil,
		thirdPartyId: String = "",
		statusCode: String = "",
		ref: String = "",
		totalExclTax: String = "0.00",
		totalTax: String = "0.00",
		totalInclTax: String = "0.00",
		multicurrencyCode: String? = nil,
		id: String = "",
		arrayOptions: [String: MultiType]? = nil,
		notePublic: String? = nil,
		notePrivate: String? = nil
	) {
		self.lines = lines
		self.clientRef = clientRef
		self.dateP = dateP
		self.dateV = dateV
		self.validityEndDate = validityEndDate
		self.deliveryDate = deliveryDate
		self.pdfModel = pdfModel
		self.lastMainDoc = lastMainDoc
		self.userAuthorId = userAuthorId
		self.paymentMethodId = paymentMethodId
		self.paymentTermsId = paymentTermsId
		self.availabilityId = availabilityId
		self.shippingMethodId = shippingMethodId
		self.sourceReasonId = sourceReasonId
		self.externalContactIds = externalContactIds
		super.init(
			thirdPartyId: thirdPartyId,
			statusCode: statusCode,
			totalExclTax: totalExclTax,
			totalTax: totalTax,
			totalInclTax: totalInclTax,
			multicurrencyCode: multicurrencyCode,
			id: id,
			arrayOptions: arrayOptions,
			notePublic: notePublic,
			notePrivate: notePrivate
		)
	}

	required init(from decoder: any Decoder) throws {
		do {
			Logger.logWithoutSignal("\(Self.self).init.decode", category: .api)
			let container = try decoder.container(keyedBy: CodingKeys.self)
			self.lines = try container.decode([DolibarrQuoteLine].self, forKey: .lines)
			self.clientRef = try container.decodeIfPresent(String.self, forKey: .clientRef)
			self.dateP = try container.decode(Int.self, forKey: .dateP)
			self.dateV = try container.decodeIfPresent(MultiType.self, forKey: .dateV)?.intValue
			self.validityEndDate = try container.decodeIfPresent(MultiType.self, forKey: .validityEndDate)?.intValue
			self.deliveryDate = try container.decodeIfPresent(MultiType.self, forKey: .deliveryDate)?.intValue
			self.pdfModel = try container.decodeIfPresent(String.self, forKey: .pdfModel)
			self.lastMainDoc = try container.decodeIfPresent(String.self, forKey: .lastMainDoc)
			self.userAuthorId = try container.decode(String.self, forKey: .userAuthorId)
			self.paymentMethodId = try container.decodeIfPresent(String.self, forKey: .paymentMethodId)
			self.paymentTermsId = try container.decodeIfPresent(String.self, forKey: .paymentTermsId)
			self.availabilityId = try container.decodeIfPresent(String.self, forKey: .availabilityId)
			self.shippingMethodId = try container.decodeIfPresent(String.self, forKey: .shippingMethodId)
			self.sourceReasonId = try container.decodeIfPresent(String.self, forKey: .sourceReasonId)
			self.externalContactIds = try container.decodeIfPresent([String].self, forKey: .externalContactIds)
			try super.init(from: decoder)
			Logger.logWithoutSignal("\(Self.self).init.decoded", category: .api)
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
		hasher.combine(lines)
		hasher.combine(optional: clientRef)
		hasher.combine(dateP)
		hasher.combine(optional: dateV)
		hasher.combine(optional: validityEndDate)
		hasher.combine(optional: deliveryDate)
		hasher.combine(optional: pdfModel)
		hasher.combine(optional: lastMainDoc)
		hasher.combine(userAuthorId)
		hasher.combine(optional: paymentMethodId)
		hasher.combine(optional: paymentTermsId)
		hasher.combine(optional: availabilityId)
		hasher.combine(optional: shippingMethodId)
		hasher.combine(optional: sourceReasonId)
		hasher.combine(optional: externalContactIds)
		super.hash(into: &hasher)
	}

	override func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(lines, forKey: .lines)
		try container.encodeIfPresent(clientRef, forKey: .clientRef)
		if dateP != 0 {
			try container.encode(dateP, forKey: .dateP)
		}
		try container.encodeIfPresent(dateV, forKey: .dateV)
		try container.encodeIfPresent(validityEndDate, forKey: .validityEndDate)
		try container.encodeIfPresent(deliveryDate, forKey: .deliveryDate)
		try container.encodeIfPresent(pdfModel, forKey: .pdfModel)
		try container.encodeIfPresent(lastMainDoc, forKey: .lastMainDoc)
		try container.encodeIfNotEmpty(userAuthorId, forKey: .userAuthorId)
		try container.encodeIfPresentAndNotEmpty(paymentMethodId, forKey: .paymentMethodId)
		try container.encodeIfPresentAndNotEmpty(paymentTermsId, forKey: .paymentTermsId)
		try container.encodeIfPresentAndNotEmpty(availabilityId, forKey: .availabilityId)
		try container.encodeIfPresentAndNotEmpty(shippingMethodId, forKey: .shippingMethodId)
		try container.encodeIfPresentAndNotEmpty(sourceReasonId, forKey: .sourceReasonId)
		try super.encode(to: encoder)
	}

}
