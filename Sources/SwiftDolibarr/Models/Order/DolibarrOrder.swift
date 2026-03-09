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
//  DolibarrOrder.swift
//  SwiftDolibarr
//
//  Created by William Mead on 18/01/2026.
//

import Foundation
import OSLog

@Observable public final class DolibarrOrder: CommonCommercialTransactionObject {

	// MARK: - Properties

	// Required

	var lines: [DolibarrOrderLine]

	// Optional

	var clientRef: String?
	var dateCreation: Int?
	var date: Int
	var dateValidation: Int?
	var deliveryDate: Int?
 	var pdfModel: String?
	var lastMainDoc: String?
	var userAuthorId: String?
	var paymentMethodId: String?
	var paymentTermsId: String?
	var availabilityId: String?
	var shippingMethodId: String?
	var sourceReasonId: String?
	var externalContactIds: [String]?

	// Computed

	override var status: DolibarrObjectStatus {
		guard let status = DolibarrObjectStatus.orders.first(where: { $0.code == statusCode }) else { return .unknown }
		return status
	}

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case lines
		case clientRef = "ref_client"
		case dateCreation = "date_creation"
		case date
		case dateValidation = "date_validation"
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
		lines: [DolibarrOrderLine] = [],
		clientRef: String? = nil,
		dateCreation: Int? = nil,
		date: Int = 0,
		dateValidation: Int? = nil,
		deliveryDate: Int? = nil,
		pdfModel: String? = nil,
		lastMainDoc: String? = nil,
		userAuthorId: String? = nil,
		paymentMethodId: String? = nil,
		paymentTermsId: String? = nil,
		availabilityId: String? = nil,
		shippingMethodId: String? = nil,
		sourceReasonId: String? = nil,
		externalContactIds: [String]? = nil,
		thirdPartyId: String = "",
		statusCode: String = "0",
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
		self.dateCreation = dateCreation
		self.date = date
		self.dateValidation = dateValidation
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
			Logger.logWithoutSignal("\(Self.self).init.decode", level: .info, category: .api)
			let container = try decoder.container(keyedBy: CodingKeys.self)
			self.clientRef = try container.decodeIfPresent(String.self, forKey: .clientRef)
			self.dateCreation = try container.decodeIfPresent(Int.self, forKey: .dateCreation)
			self.date = try container.decode(Int.self, forKey: .date)
			self.dateValidation = try container.decodeIfPresent(MultiType.self, forKey: .dateValidation)?.intValue
			self.deliveryDate = try container.decodeIfPresent(MultiType.self, forKey: .deliveryDate)?.intValue
			self.pdfModel = try container.decodeIfPresent(String.self, forKey: .pdfModel)
			self.lastMainDoc = try container.decodeIfPresent(String.self, forKey: .lastMainDoc)
			self.userAuthorId = try container.decodeIfPresent(String.self, forKey: .userAuthorId)
			self.paymentMethodId = try container.decodeIfPresent(String.self, forKey: .paymentMethodId)
			self.paymentTermsId = try container.decodeIfPresent(String.self, forKey: .paymentTermsId)
			self.availabilityId = try container.decodeIfPresent(String.self, forKey: .availabilityId)
			self.shippingMethodId = try container.decodeIfPresent(String.self, forKey: .shippingMethodId)
			self.sourceReasonId = try container.decodeIfPresent(String.self, forKey: .sourceReasonId)
			self.lines = try container.decode([DolibarrOrderLine].self, forKey: .lines)
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

	override public func hash(into hasher: inout Hasher) {
		hasher.combine(lines)
		hasher.combine(optional: clientRef)
		hasher.combine(optional: dateCreation)
		hasher.combine(date)
		hasher.combine(optional: dateValidation)
		hasher.combine(optional: deliveryDate)
		hasher.combine(optional: pdfModel)
		hasher.combine(optional: lastMainDoc)
		hasher.combine(optional: userAuthorId)
		hasher.combine(optional: paymentMethodId)
		hasher.combine(optional: paymentTermsId)
		hasher.combine(optional: availabilityId)
		hasher.combine(optional: shippingMethodId)
		hasher.combine(optional: sourceReasonId)
		hasher.combine(optional: externalContactIds)
		super.hash(into: &hasher)
	}

	override public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(lines, forKey: .lines)
		try container.encodeIfPresent(clientRef, forKey: .clientRef)
		try container.encodeIfPresentAndNotZero(dateCreation, forKey: .dateCreation)
		try container.encodeIfNotZero(date, forKey: .date)
		try container.encodeIfPresent(dateValidation, forKey: .dateValidation)
		try container.encodeIfPresent(deliveryDate, forKey: .deliveryDate)
		try container.encodeIfPresent(pdfModel, forKey: .pdfModel)
		try container.encodeIfPresent(lastMainDoc, forKey: .lastMainDoc)
		try container.encodeIfPresentAndNotEmpty(userAuthorId, forKey: .userAuthorId)
		try container.encodeIfPresentAndNotEmpty(paymentMethodId, forKey: .paymentMethodId)
		try container.encodeIfPresentAndNotEmpty(paymentTermsId, forKey: .paymentTermsId)
		try container.encodeIfPresentAndNotEmpty(availabilityId, forKey: .availabilityId)
		try container.encodeIfPresentAndNotEmpty(shippingMethodId, forKey: .shippingMethodId)
		try container.encodeIfPresentAndNotEmpty(sourceReasonId, forKey: .sourceReasonId)
		try super.encode(to: encoder)
	}
}
