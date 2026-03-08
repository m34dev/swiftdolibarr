//
//  DolibarrWarehouse.swift
//  SwiftDolibarr
//
//  Created by William Mead on 02/07/2025.
//

import Foundation
import OSLog

@Observable final class DolibarrWarehouse: CommonBusinessObject, Locatable {

    // MARK: - Properties

	// Required

	var label: String

	// Optional

	var parentId: String?
    var description: String?
    var location: String?
    var address: String?
    var zip: String?
    var city: String?
    var countryId: String?
    var phone: String?

	// Computed

	override var status: DolibarrObjectStatus {
		guard let status = DolibarrObjectStatus.warehouses.first(where: { $0.code == statusCode }) else { return .unknown }
		return status
	}

    // MARK: - Enums

    enum CodingKeys: String, CodingKey {
		case label
		case parentId = "fk_parent"
        case description
        case location = "lieu"
        case address
        case zip
        case city = "town"
        case countryId = "country_id"
        case phone
    }

    // MARK: - Inits

    init(
		label: String = "",
		parentId: String? = nil,
		description: String? = nil,
		location: String? = nil,
		address: String? = nil,
		zip: String? = nil,
		city: String? = nil,
		countryId: String? = nil,
		phone: String? = nil,
		id: String = "",
		statusCode: String = "",
		arrayOptions: [String: MultiType]? = nil,
		notePublic: String? = nil,
		notePrivate: String? = nil,
    ) {
		self.label = label
		self.parentId = parentId
        self.description = description
        self.location = location
        self.address = address
        self.zip = zip
        self.city = city
        self.countryId = countryId
        self.phone = phone
		super.init(id: id, statusCode: statusCode, arrayOptions: arrayOptions, notePublic: notePublic, notePrivate: notePrivate)
    }

    required init(from decoder: any Decoder) throws {
        do {
            Logger.logWithoutSignal("\(Self.self).init.decode", category: .api)
            let container = try decoder.container(keyedBy: CodingKeys.self)
			self.label = try container.decode(String.self, forKey: .label)
			self.parentId = try container.decodeIfPresent(String.self, forKey: .parentId)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.location = try container.decodeIfPresent(String.self, forKey: .location)
			self.address = try container.decodeIfPresent(String.self, forKey: .address)
			self.zip = try container.decodeIfPresent(String.self, forKey: .zip)
			self.city = try container.decodeIfPresent(String.self, forKey: .city)
            self.countryId = try container.decodeIfPresent(String.self, forKey: .countryId)
            self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
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
		hasher.combine(label)
		hasher.combine(optional: parentId)
		hasher.combine(optional: description)
		hasher.combine(optional: location)
		hasher.combine(optional: address)
		hasher.combine(optional: zip)
		hasher.combine(optional: city)
		hasher.combine(optional: countryId)
		hasher.combine(optional: phone)
		super.hash(into: &hasher)
    }

    override func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encodeIfNotEmpty(label, forKey: .label)
		try container.encodeIfPresent(parentId, forKey: .parentId)
		try container.encodeIfPresent(location, forKey: .location)
		try container.encodeIfPresent(description, forKey: .description)
		try container.encodeIfPresent(address, forKey: .address)
		try container.encodeIfPresent(zip, forKey: .zip)
		try container.encodeIfPresent(city, forKey: .city)
		try container.encodeIfPresent(phone, forKey: .phone)
        try container.encodeIfPresent(countryId, forKey: .countryId)
		try super.encode(to: encoder)
    }

}
