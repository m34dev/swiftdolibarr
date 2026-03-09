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
//  DolibarrExpenseReportLine.swift
//  SwiftDolibarr
//
//  Created by William Mead on 27/05/2025.
//

import Foundation
import OSLog

@Observable public final class DolibarrExpenseReportLine: Identifiable, Hashable, Codable {

    // MARK: - Properties

	public var id: String
	public var quantity: String
	public var unitPriceInclTax: String
	public var date: Int
	public var feeTypeId: String
	public var feeTypeCode: String
	public var feeTypeLabel: String
	public var totalExclTax: String
	public var totalTax: String
	public var totalInclTax: String
	public var taxRate: String
	public var comments: String?

    // MARK: - Enums

    enum CodingKeys: String, CodingKey {
        case id
        case quantity = "qty"
        case unitPriceInclTax = "value_unit"
        case date = "dates"
        case feeTypeId = "fk_c_type_fees"
        case feeTypeCode = "type_fees_code"
        case feeTypeLabel = "type_fees_libelle"
        case totalExclTax = "total_ht"
        case totalTax = "total_tva"
        case totalInclTax = "total_ttc"
        case taxRate = "tva_tx"
        case comments
    }

    // MARK: - Inits

    public init(
        id: String,
        quantity: String,
        unitPriceInclTax: String,
        date: Int,
        feeTypeId: String,
        feeTypeCode: String,
        feeTypeLabel: String,
        totalExclTax: String,
        totalTax: String,
        totalInclTax: String,
        taxRate: String,
        comments: String? = nil
    ) {
        self.id = id
        self.quantity = quantity
        self.unitPriceInclTax = unitPriceInclTax
        self.date = date
        self.feeTypeId = feeTypeId
        self.feeTypeCode = feeTypeCode
        self.feeTypeLabel = feeTypeLabel
        self.totalExclTax = totalExclTax
        self.totalTax = totalTax
        self.totalInclTax = totalInclTax
        self.taxRate = taxRate
        self.comments = comments
    }

	public init(from decoder: any Decoder) throws {
        do {
            Logger.logWithoutSignal("\(Self.self).init.decode", level: .info, category: .api)
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(String.self, forKey: .id)
            self.quantity = try container.decode(String.self, forKey: .quantity)
            self.unitPriceInclTax = try container.decode(String.self, forKey: .unitPriceInclTax)
            self.date = try container.decode(Int.self, forKey: .date)
            self.feeTypeId = try container.decode(String.self, forKey: .feeTypeId)
            self.feeTypeCode = try container.decode(String.self, forKey: .feeTypeCode)
            self.feeTypeLabel = try container.decode(String.self, forKey: .feeTypeLabel)
            self.totalExclTax = try container.decode(String.self, forKey: .totalExclTax)
            self.totalTax = try container.decode(String.self, forKey: .totalTax)
            self.totalInclTax = try container.decode(String.self, forKey: .totalInclTax)
            self.taxRate = try container.decode(String.self, forKey: .taxRate)
            self.comments = try container.decodeIfPresent(String.self, forKey: .comments)
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

	public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(quantity)
		hasher.combine(unitPriceInclTax)
        hasher.combine(date)
		hasher.combine(feeTypeId)
		hasher.combine(feeTypeCode)
		hasher.combine(feeTypeLabel)
		hasher.combine(totalExclTax)
		hasher.combine(totalTax)
		hasher.combine(totalInclTax)
		hasher.combine(taxRate)
		if let comments {
			hasher.combine(comments)
		}
    }

	public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
		try container.encode(quantity, forKey: .quantity)
		try container.encode(unitPriceInclTax, forKey: .unitPriceInclTax)
		try container.encode(date, forKey: .date)
		try container.encode(feeTypeId, forKey: .feeTypeId)
		try container.encode(feeTypeCode, forKey: .feeTypeCode)
		try container.encode(feeTypeLabel, forKey: .feeTypeLabel)
		try container.encode(totalExclTax, forKey: .totalExclTax)
		try container.encode(totalTax, forKey: .totalTax)
		try container.encode(totalInclTax, forKey: .totalInclTax)
		try container.encode(taxRate, forKey: .taxRate)
		try container.encodeIfPresent(comments, forKey: .comments)
    }

	public static func == (lhs: DolibarrExpenseReportLine, rhs: DolibarrExpenseReportLine) -> Bool {
        lhs.id == rhs.id
    }

}
