//
//  DolibarrContact.swift
//  SwiftDolibarr
//
//  Created by William Mead on 16/12/2024.
//

import Foundation
import OSLog

@Observable final class DolibarrContact: CommonBusinessObject, DolibarrPeopleObject, Locatable {

	// MARK: - Properties

	// Required

	var lastname: String

	// Optional

	var countryId: String?
	var countryCode: String?
	var email: String?
	var firstname: String?
	var titleCode: String?
	var address: String?
	var zip: String?
	var city: String?
	var poste: String?
	var socid: String?
	var socialnetworks: [String: String]?
	var phonePro: String?
	var phonePerso: String?
	var phoneMobile: String?
	var fax: String?
	var birthday: Int?

	// Computed

	override var status: DolibarrObjectStatus {
		guard let status = DolibarrObjectStatus.thirdPartiesContacts.first(where: { $0.code == statusCode }) else { return .unknown }
		return status
	}

	var name: String {
		guard let firstname = firstname, !firstname.isEmpty else { return lastname }
		return "\(firstname) \(lastname)"
	}

	// MARK: - Enums

	enum Errors: String, Error {
		case readContacts = "Unable to read contacts"
		case readContact = "Unable to read contact"
		case readContactCategories = "Unable to read+ contact categories"
		case createContact = "Unable to create contact"
		case updateContact = "Unable to update contact"
		case deleteContact = "Unable to delete contact"
	}

	enum CodingKeys: String, CodingKey {
		case countryId = "country_id"
		case countryCode = "country_code"
		case email
		case lastname
		case firstname
		case titleCode = "civility_code"
		case address
		case zip
		case city = "town"
		case poste
		case socid
		case socialnetworks
		case phonePro = "phone_pro"
		case phonePerso = "phone_perso"
		case phoneMobile = "phone_mobile"
		case fax
		case birthday
	}

	// MARK: - Inits

	init(
		countryId: String? = nil,
		countryCode: String? = nil,
		email: String? = nil,
		lastname: String = "",
		firstname: String? = nil,
		titleCode: String? = nil,
		address: String? = nil,
		zip: String? = nil,
		city: String? = nil,
		poste: String? = nil,
		socid: String? = nil,
		socialnetworks: [String: String]? = [:],
		phonePro: String? = nil,
		phonePerso: String? = nil,
		phoneMobile: String? = nil,
		fax: String? = nil,
		birthday: Int? = nil,
		id: String = "",
		statusCode: String = "",
		arrayOptions: [String: MultiType]? = nil,
		notePublic: String? = nil,
		notePrivate: String? = nil
	) {
		self.countryId = countryId
		self.countryCode = countryCode
		self.email = email
		self.lastname = lastname
		self.firstname = firstname
		self.titleCode = titleCode
		self.address = address
		self.zip = zip
		self.city = city
		self.poste = poste
		self.socid = socid
		self.socialnetworks = socialnetworks
		self.phonePro = phonePro
		self.phonePerso = phonePerso
		self.phoneMobile = phoneMobile
		self.fax = fax
		self.birthday = birthday
		super.init(id: id, statusCode: statusCode, arrayOptions: arrayOptions, notePublic: notePublic, notePrivate: notePrivate)
	}

	required init(from decoder: any Decoder) throws {
		do {
			Logger.logWithoutSignal("\(Self.self).init.decode", category: .api)
			let container = try decoder.container(keyedBy: CodingKeys.self)
			self.countryId = try container.decodeIfPresent(String.self, forKey: .countryId)
			self.countryCode = try container.decodeIfPresent(String.self, forKey: .countryCode)
			self.email = try? container.decodeIfPresent(String.self, forKey: .email)
			self.lastname = try container.decode(String.self, forKey: .lastname)
			self.firstname = try container.decodeIfPresent(String.self, forKey: .firstname)
			self.titleCode = try container.decodeIfPresent(String.self, forKey: .titleCode)
			self.address = try container.decodeIfPresent(String.self, forKey: .address)
			self.zip = try container.decodeIfPresent(String.self, forKey: .zip)
			self.city = try container.decodeIfPresent(String.self, forKey: .city)
			self.poste = try container.decodeIfPresent(String.self, forKey: .poste)
			self.socid = try container.decodeIfPresent(String.self, forKey: .socid)
			if let dictSocialnetworks = try? container.decode([String: String].self, forKey: .socialnetworks) {
				self.socialnetworks = dictSocialnetworks
			} else {
				self.socialnetworks = nil
			}
			self.phonePro = try container.decodeIfPresent(String.self, forKey: .phonePro)
			self.phonePerso = try container.decodeIfPresent(String.self, forKey: .phonePerso)
			self.phoneMobile = try container.decodeIfPresent(String.self, forKey: .phoneMobile)
			self.fax = try container.decodeIfPresent(String.self, forKey: .fax)
			if let birthday = try? container.decodeIfPresent(Int.self, forKey: .birthday) {
				self.birthday = birthday
			} else {
				self.birthday = nil
			}
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
		hasher.combine(lastname)
		hasher.combine(optional: countryId)
		hasher.combine(optional: countryCode)
		hasher.combine(optional: email)
		hasher.combine(optional: firstname)
		hasher.combine(optional: titleCode)
		hasher.combine(optional: address)
		hasher.combine(optional: zip)
		hasher.combine(optional: city)
		hasher.combine(optional: poste)
		hasher.combine(optional: socid)
		hasher.combine(optional: socialnetworks)
		hasher.combine(optional: phonePro)
		hasher.combine(optional: phonePerso)
		hasher.combine(optional: phoneMobile)
		hasher.combine(optional: fax)
		hasher.combine(optional: birthday)
		super.hash(into: &hasher)
	}

	override func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encodeIfNotEmpty(lastname, forKey: .lastname)
		try container.encodeIfPresent(countryId, forKey: .countryId)
		try container.encodeIfPresent(countryCode, forKey: .countryCode)
		try container.encodeIfPresent(email, forKey: .email)
		try container.encodeIfPresent(firstname, forKey: .firstname)
		try container.encodeIfPresent(titleCode, forKey: .titleCode)
		try container.encodeIfPresent(address, forKey: .address)
		try container.encodeIfPresent(zip, forKey: .zip)
		try container.encodeIfPresent(city, forKey: .city)
		try container.encodeIfPresent(poste, forKey: .poste)
		try container.encodeIfPresent(socid, forKey: .socid)
		try container.encodeIfPresent(phonePro, forKey: .phonePro)
		try container.encodeIfPresent(phonePerso, forKey: .phonePerso)
		try container.encodeIfPresent(phoneMobile, forKey: .phoneMobile)
		try container.encodeIfPresent(fax, forKey: .fax)
		try container.encodeIfPresent(socialnetworks, forKey: .socialnetworks)
		try container.encodeIfPresent(birthday, forKey: .birthday)
		try super.encode(to: encoder)
	}

}
