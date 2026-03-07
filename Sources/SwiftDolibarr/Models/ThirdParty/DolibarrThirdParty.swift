//
//  DolibarrThirdParty.swift
//  SwiftDolibarr
//
//  Created by William Mead on 30/10/2024.
//

import Foundation
import OSLog

@Observable final class DolibarrThirdParty: CommonBusinessObject, DolibarrPeopleObject, Locatable {

    // MARK: - Properties

	// Required

	var name: String

	// Optional

    var countryId: String?
    var countryCode: String?
    var multicurrencyCode: String?
    var nameAlias: String?
    var phone: String?
    var fax: String?
    var email: String?
    var url: String?
    var idprof1: String?
    var idprof2: String?
    var idprof3: String?
    var idprof4: String?
    var idprof5: String?
    var tvaIntra: String?
    var capital: String?
    var workforce: String?
    var legalEntityType: String?
    var client: String?
    var supplier: String?
    var clientCode: String?
    var supplierCode: String?
    var parentId: String?
    var socialnetworks: [String: String]?
    var address: String?
    var zip: String?
    var city: String?

	// Computed

	override var status: DolibarrObjectStatus {
		guard let status = DolibarrObjectStatus.thirdPartiesContacts.first(where: { $0.code == statusCode }) else { return .unknown }
		return status
	}

    // MARK: - Enums

    enum CodingKeys: String, CodingKey {
        case name
        case countryId = "country_id"
        case countryCode = "country_code"
        case multicurrencyCode = "multicurrency_code"
        case nameAlias = "name_alias"
        case phone
        case fax
        case email
        case url
        case idprof1
        case idprof2
        case idprof3
        case idprof4
        case idprof5
        case tvaIntra = "tva_intra"
        case capital
        case workforce = "effectif"
        case legalEntityType = "forme_juridique"
        case client
        case supplier = "fournisseur"
        case clientCode = "code_client"
        case supplierCode = "code_fournisseur"
        case parentId = "parent"
        case socialnetworks
        case address
        case zip
        case city = "town"
    }

    // MARK: - Inits

    init(
        name: String = "",
        countryId: String? = nil,
        country_code: String? = nil,
        multicurrency_code: String? = nil,
        name_alias: String? = nil,
        phone: String? = nil,
        fax: String? = nil,
        email: String? = nil,
        url: String? = nil,
        idprof1: String? = nil,
        idprof2: String? = nil,
        idprof3: String? = nil,
        idprof4: String? = nil,
        idprof5: String? = nil,
        tva_intra: String? = nil,
        capital: String? = nil,
        effectif: String? = nil,
        forme_juridique: String? = nil,
        client: String? = nil,
        supplier: String? = nil,
        code_client: String? = nil,
        code_fournisseur: String? = nil,
        parent: String? = nil,
        socialnetworks: [String: String]? = nil,
        address: String? = nil,
        zip: String? = nil,
        city: String? = nil,
        id: String = "",
        statusCode: String = "",
        arrayOptions: [String: MultiType]? = nil,
        notePublic: String? = nil,
        notePrivate: String? = nil
    ) {
        self.name = name
        self.countryId = countryId
        self.countryCode = country_code
        self.multicurrencyCode = multicurrency_code
        self.nameAlias = name_alias
        self.phone = phone
        self.fax = fax
        self.email = email
        self.url = url
        self.idprof1 = idprof1
        self.idprof2 = idprof2
        self.idprof3 = idprof3
        self.idprof4 = idprof4
        self.idprof5 = idprof5
        self.tvaIntra = tva_intra
        self.capital = capital
        self.workforce = effectif
        self.legalEntityType = forme_juridique
        self.client = client
        self.supplier = supplier
        self.clientCode = code_client
        self.supplierCode = code_fournisseur
        self.parentId = parent
        self.socialnetworks = socialnetworks
        self.address = address
        self.zip = zip
        self.city = city
		super.init(id: id, statusCode: statusCode, arrayOptions: arrayOptions, notePublic: notePublic, notePrivate: notePrivate)
    }

    required init(from decoder: any Decoder) throws {
        do {
			Logger.logWithoutSignal("\(Self.self).init.decode", category: .api)
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decode(String.self, forKey: .name)
			self.countryId = try container.decodeIfPresent(MultiType.self, forKey: .countryId)?.stringValue
            self.countryCode = try container.decodeIfPresent(String.self, forKey: .countryCode)
            self.multicurrencyCode = try container.decodeIfPresent(String.self, forKey: .multicurrencyCode)
            self.nameAlias = try container.decodeIfPresent(String.self, forKey: .nameAlias)
            self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
            self.fax = try container.decodeIfPresent(String.self, forKey: .fax)
            self.email = try container.decodeIfPresent(String.self, forKey: .email)
            self.url = try container.decodeIfPresent(String.self, forKey: .url)
            self.idprof1 = try container.decodeIfPresent(String.self, forKey: .idprof1)
            self.idprof2 = try container.decodeIfPresent(String.self, forKey: .idprof2)
            self.idprof3 = try container.decodeIfPresent(String.self, forKey: .idprof3)
            self.idprof4 = try container.decodeIfPresent(String.self, forKey: .idprof4)
            self.idprof5 = try container.decodeIfPresent(String.self, forKey: .idprof5)
            self.tvaIntra = try container.decodeIfPresent(String.self, forKey: .tvaIntra)
			self.capital = try container.decodeIfPresent(MultiType.self, forKey: .capital)?.stringValue
            self.workforce = try container.decodeIfPresent(String.self, forKey: .workforce)
            self.legalEntityType = try container.decodeIfPresent(String.self, forKey: .legalEntityType)
            self.client = try container.decodeIfPresent(String.self, forKey: .client)
            self.supplier = try container.decodeIfPresent(String.self, forKey: .supplier)
            self.clientCode = try container.decodeIfPresent(String.self, forKey: .clientCode)
            self.supplierCode = try container.decodeIfPresent(String.self, forKey: .supplierCode)
            self.parentId = try container.decodeIfPresent(String.self, forKey: .parentId)
            if let dictSocialnetworks = try? container.decode([String: String].self, forKey: .socialnetworks) {
                self.socialnetworks = dictSocialnetworks
            } else {
                self.socialnetworks = nil
            }
            self.address = try container.decodeIfPresent(String.self, forKey: .address)
			self.zip = try container.decodeIfPresent(String.self, forKey: .zip)
			self.city = try container.decodeIfPresent(String.self, forKey: .city)
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
		hasher.combine(name)
		hasher.combine(optional: countryId)
		hasher.combine(optional: countryCode)
		hasher.combine(optional: multicurrencyCode)
		hasher.combine(optional: nameAlias)
		hasher.combine(optional: phone)
		hasher.combine(optional: fax)
		hasher.combine(optional: email)
		hasher.combine(optional: url)
		hasher.combine(optional: idprof1)
		hasher.combine(optional: idprof2)
		hasher.combine(optional: idprof3)
		hasher.combine(optional: idprof4)
		hasher.combine(optional: idprof5)
		hasher.combine(optional: tvaIntra)
		hasher.combine(optional: capital)
		hasher.combine(optional: workforce)
		hasher.combine(optional: legalEntityType)
		hasher.combine(optional: client)
		hasher.combine(optional: supplier)
		hasher.combine(optional: clientCode)
		hasher.combine(optional: supplierCode)
		hasher.combine(optional: parentId)
		hasher.combine(optional: socialnetworks)
		hasher.combine(optional: address)
		hasher.combine(optional: zip)
		hasher.combine(optional: city)
		super.hash(into: &hasher)
    }

    override func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encodeIfNotEmpty(name, forKey: .name)
		try container.encodeIfPresent(countryId, forKey: .countryId)
		try container.encodeIfPresent(countryCode, forKey: .countryCode)
		try container.encodeIfPresent(multicurrencyCode, forKey: .multicurrencyCode)
		try container.encodeIfPresent(nameAlias, forKey: .nameAlias)
		try container.encodeIfPresent(phone, forKey: .phone)
		try container.encodeIfPresent(fax, forKey: .fax)
		try container.encodeIfPresent(email, forKey: .email)
		try container.encodeIfPresent(url, forKey: .url)
		try container.encodeIfPresent(idprof1, forKey: .idprof1)
		try container.encodeIfPresent(idprof2, forKey: .idprof2)
		try container.encodeIfPresent(idprof3, forKey: .idprof3)
		try container.encodeIfPresent(idprof4, forKey: .idprof4)
		try container.encodeIfPresent(idprof5, forKey: .idprof5)
		try container.encodeIfPresent(tvaIntra, forKey: .tvaIntra)
		try container.encodeIfPresent(capital, forKey: .capital)
		try container.encodeIfPresent(workforce, forKey: .workforce)
		try container.encodeIfPresent(legalEntityType, forKey: .legalEntityType)
		try container.encodeIfPresent(client, forKey: .client)
		try container.encodeIfPresent(supplier, forKey: .supplier)
		try container.encodeIfPresent(clientCode, forKey: .clientCode)
		try container.encodeIfPresent(supplierCode, forKey: .supplierCode)
		try container.encodeIfPresent(parentId, forKey: .parentId)
		try container.encodeIfPresent(socialnetworks, forKey: .socialnetworks)
		try container.encodeIfPresent(address, forKey: .address)
		try container.encodeIfPresent(zip, forKey: .zip)
		try container.encodeIfPresent(city, forKey: .city)
		try super.encode(to: encoder)
    }

}
