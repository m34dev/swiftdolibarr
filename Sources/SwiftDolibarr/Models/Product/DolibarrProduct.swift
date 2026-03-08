//
//  DolibarrProduct.swift
//  SwiftDolibarr
//
//  Created by William Mead on 16/05/2025.
//

import Foundation
import OSLog

@Observable final class DolibarrProduct: CommonBusinessObject {

	// MARK: - Properties

	// Required

	var ref: String
	var sellStatus: String
	var buyStatus: String
	var typeCode: String
	var label: String

	// Optional

	var description: String?
	var duration: String?
	var finished: String?
	var priceExclTax: String?
	var priceInclTax: String?
	var priceMinExclTax: String?
	var priceMinInclTax: String?
	var priceBaseType: String?
	var priceLabel: String?
	var taxRate: String?
	var url: String?
	var barcode: String?
	var barcodeType: String?
	var stockWarehouse: DolibarrProductStockWarehouse?
	var defaultWarehouseId: String?

	// Computed

	var type: ProductType {
		guard let type = ProductType.allProductTypes.first(where: { $0.code == typeCode }) else { return .unknown }
		return type
	}

	override var status: DolibarrObjectStatus {
		let combinedStatusCodes = "\(sellStatus)\(buyStatus)"
		guard let status = DolibarrObjectStatus.productsServices.first(where: { $0.code == combinedStatusCodes }) else { return .unknown }
		return status
	}

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case ref = "ref"
		case sellStatus = "status"
		case buyStatus = "status_buy"
		case typeCode = "type"
		case label
		case description
		case duration
		case finished
		case priceExclTax = "price"
		case priceInclTax = "price_ttc"
		case priceMinExclTax = "price_min"
		case priceMinInclTax = "price_min_ttc"
		case priceBaseType = "price_base_type"
		case priceLabel = "price_label"
		case taxRate = "tva_tx"
		case url
		case barcode
		case barcodeType = "barcode_type"
		case stockWarehouse = "stockWarehouse"
		case defaultWarehouseId = "fk_default_warehouse"
	}

	// MARK: - Inits

	init(
		ref: String = "",
		sellStatus: String = "1",
		buyStatus: String = "1",
		typeCode: String = "0",
		label: String = "",
		description: String? = nil,
		duration: String? = nil,
		finished: String? = nil,
		priceExclTax: String? = nil,
		priceInclTax: String? = nil,
		priceMinExclTax: String? = nil,
		priceMinInclTax: String? = nil,
		priceBaseType: String? = nil,
		priceLabel: String? = nil,
		taxRate: String? = nil,
		url: String? = nil,
		barcode: String? = nil,
		barcodeType: String? = nil,
		stockWarehouse: DolibarrProductStockWarehouse? = nil,
		defaultWarehouseId: String? = nil,
		id: String = "",
		arrayOptions: [String: MultiType]? = nil,
		notePublic: String? = nil,
		notePrivate: String? = nil,
	) {
		self.ref = ref
		self.sellStatus = sellStatus
		self.buyStatus = buyStatus
		self.typeCode = typeCode
		self.label = label
		self.description = description
		self.duration = duration
		self.finished = finished
		self.priceExclTax = priceExclTax
		self.priceInclTax = priceInclTax
		self.priceMinExclTax = priceMinExclTax
		self.priceMinInclTax = priceMinInclTax
		self.priceBaseType = priceBaseType
		self.priceLabel = priceLabel
		self.taxRate = taxRate
		self.url = url
		self.barcode = barcode
		self.barcodeType = barcodeType
		self.stockWarehouse = stockWarehouse
		self.defaultWarehouseId = defaultWarehouseId
		super.init(id: id, arrayOptions: arrayOptions, notePublic: notePublic, notePrivate: notePrivate)
	}

	required init(from decoder: any Decoder) throws {
		do {
			Logger.logWithoutSignal("\(Self.self).init.decode", category: .api)
			let container = try decoder.container(keyedBy: CodingKeys.self)
			self.ref = try container.decode(String.self, forKey: .ref)
			self.sellStatus = try container.decode(String.self, forKey: .sellStatus)
			self.buyStatus = try container.decode(String.self, forKey: .buyStatus)
			self.typeCode = try container.decode(String.self, forKey: .typeCode)
			self.label = try container.decode(String.self, forKey: .label)
			self.description = try container.decodeIfPresent(String.self, forKey: .description)
			self.duration = try container.decodeIfPresent(String.self, forKey: .duration)
			self.finished = try container.decodeIfPresent(String.self, forKey: .finished)
			self.priceExclTax = try container.decodeIfPresent(String.self, forKey: .priceExclTax)
			self.priceInclTax = try container.decodeIfPresent(String.self, forKey: .priceInclTax)
			self.priceMinExclTax = try container.decodeIfPresent(String.self, forKey: .priceMinExclTax)
			self.priceMinInclTax = try container.decodeIfPresent(String.self, forKey: .priceMinInclTax)
			self.priceBaseType = try container.decodeIfPresent(String.self, forKey: .priceBaseType)
			self.priceLabel = try container.decodeIfPresent(String.self, forKey: .priceLabel)
			self.taxRate = try container.decodeIfPresent(String.self, forKey: .taxRate)
			self.url = try container.decodeIfPresent(String.self, forKey: .url)
			self.barcode = try container.decodeIfPresent(String.self, forKey: .barcode)
			self.barcodeType = try container.decodeIfPresent(String.self, forKey: .barcodeType)
			if let productStock = try? container.decode(DolibarrProductStockWarehouse.self, forKey: .stockWarehouse) {
				self.stockWarehouse = productStock
			} else {
				self.stockWarehouse = nil
			}
			self.defaultWarehouseId = try container.decodeIfPresent(String.self, forKey: .defaultWarehouseId)
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
		hasher.combine(ref)
		hasher.combine(sellStatus)
		hasher.combine(buyStatus)
		hasher.combine(typeCode)
		hasher.combine(label)
		hasher.combine(optional: description)
		hasher.combine(optional: duration)
		hasher.combine(optional: finished)
		hasher.combine(optional: priceExclTax)
		hasher.combine(optional: priceInclTax)
		hasher.combine(optional: priceMinExclTax)
		hasher.combine(optional: priceMinInclTax)
		hasher.combine(optional: priceBaseType)
		hasher.combine(optional: priceLabel)
		hasher.combine(optional: taxRate)
		hasher.combine(optional: url)
		hasher.combine(optional: barcode)
		hasher.combine(optional: barcodeType)
		hasher.combine(optional: stockWarehouse)
		hasher.combine(optional: defaultWarehouseId)
		super.hash(into: &hasher)
	}

	override func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encodeIfNotEmpty(ref, forKey: .ref)
		try container.encodeIfNotEmpty(sellStatus, forKey: .sellStatus)
		try container.encodeIfNotEmpty(buyStatus, forKey: .buyStatus)
		try container.encodeIfNotEmpty(typeCode, forKey: .typeCode)
		try container.encodeIfNotEmpty(label, forKey: .label)
		try container.encodeIfPresent(description, forKey: .description)
		try container.encodeIfPresent(duration, forKey: .duration)
		try container.encodeIfPresent(finished, forKey: .finished)
		try container.encodeIfPresent(priceExclTax, forKey: .priceExclTax)
		try container.encodeIfPresent(priceInclTax, forKey: .priceInclTax)
		try container.encodeIfPresent(priceMinExclTax, forKey: .priceMinExclTax)
		try container.encodeIfPresent(priceMinInclTax, forKey: .priceMinInclTax)
		try container.encodeIfPresent(priceBaseType, forKey: .priceBaseType)
		try container.encodeIfPresent(priceLabel, forKey: .priceLabel)
		try container.encodeIfPresent(taxRate, forKey: .taxRate)
		try container.encodeIfPresent(url, forKey: .url)
		try container.encodeIfPresent(barcode, forKey: .barcode)
		try container.encodeIfPresent(barcodeType, forKey: .barcodeType)
		try container.encodeIfPresent(defaultWarehouseId, forKey: .defaultWarehouseId)
		try super.encode(to: encoder)
	}

}
