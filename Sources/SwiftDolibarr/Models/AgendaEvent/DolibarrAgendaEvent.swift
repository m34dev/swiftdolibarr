//
//  DolibarrAgendaEvent.swift
//  SwiftDolibarr
//
//  Created by William Mead on 17/06/2025.
//

import Foundation
import OSLog

@Observable final class DolibarrAgendaEvent: CommonBusinessObject {

    // MARK: - Properties

	// Required

	var ref: String
	var label: String
	var progress: String
	var fullDayEvent: String
	// var visibility: String // TODO: Not yet implemented in Dolibarr

	// Optional

    var type_id: String?
    var type: String?
    var type_code: String?
    var code: String?
    var datec: Int?
    var datem: Int?
    var datep: Int?
    var datef: Int?
    var authorid: String?
    var usermodid: String?
    var location: String?
    var socid: String?
    var priority: String?
    var userassigned: [String:DolibarrAgendaEventUserAssigned]?
    var userownerid: String?
    var elementid: String?
    var elementtype: String?

	// Computed

	override var status: DolibarrObjectStatus {
		if let progressValue = Int(progress) {
			switch progressValue {
			case -1:
				return .agendaEventNA
			case 0:
				return .agendaEventToDo
			case 1...99:
				return .agendaEventInProgress
			case 100:
				return .agendaEventFinished
			default:
				return .unknown
			}
		} else {
			return .unknown
		}
	}

    // MARK: - Enums

    enum CodingKeys: String, CodingKey {
        case ref
        case label
        case progress = "percentage"
        case fullDayEvent = "fulldayevent"
        // case visibility // TODO: Not yet implemented in Dolibarr
        case type_id
        case type
        case type_code
        case code
        case datec
        case datem
        case datep
        case datef
        case authorid
        case usermodid
        case location
        case socid
        case priority
        case userassigned
        case userownerid
        case elementid
        case elementtype
    }

    // MARK: - Inits

    init(
        ref: String = "",
        label: String = "",
        progress: String = "",
        fullDayEvent: String = "",
        // visibility: String = "", // TODO: Not yet implemented in Dolibarr
        type_id: String? = nil,
        type: String? = nil,
        type_code: String? = nil,
        code: String? = nil,
        datec: Int? = nil,
        datem: Int? = nil,
        datep: Int? = nil,
        datef: Int? = nil,
        authorid: String? = nil,
        usermodid: String? = nil,
        location: String? = nil,
        socid: String? = nil,
        priority: String? = nil,
        userassigned: [String:DolibarrAgendaEventUserAssigned]? = nil,
        userownerid: String? = nil,
        elementid: String? = nil,
        elementtype: String? = nil,
        id: String = "",
        statusCode: String = "",
        arrayOptions: [String: MultiType]? = nil,
        notePublic: String? = nil,
        notePrivate: String? = nil
    ) {
        self.ref = ref
        self.label = label
        self.progress = progress
        self.fullDayEvent = fullDayEvent
        // self.visibility = visibility // TODO: Not yet implemented in Dolibarr
        self.type_id = type_id
        self.type = type
        self.type_code = type_code
        self.code = code
        self.datec = datec
        self.datem = datem
        self.datep = datep
        self.datef = datef
        self.authorid = authorid
        self.usermodid = usermodid
        self.location = location
        self.socid = socid
        self.priority = priority
        self.userassigned = userassigned
        self.userownerid = userownerid
        self.elementid = elementid
        self.elementtype = elementtype
		super.init(id: id, statusCode: statusCode, arrayOptions: arrayOptions, notePublic: notePublic, notePrivate: notePrivate)
    }

    required init(from decoder: any Decoder) throws {
        do {
            Logger.logWithoutSignal("\(Self.self).init.decode", category: .api)
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.ref = try container.decode(String.self, forKey: .ref)
            self.label = try container.decode(String.self, forKey: .label)
            self.progress = try container.decode(String.self, forKey: .progress)
            self.fullDayEvent = try container.decode(String.self, forKey: .fullDayEvent)
            // self.visibility = try container.decode(String.self, forKey: .visibility) // TODO: Not yet implemented in Dolibarr
            self.type_id = try container.decodeIfPresent(String.self, forKey: .type_id)
            self.type = try container.decodeIfPresent(String.self, forKey: .type)
            self.type_code = try container.decodeIfPresent(String.self, forKey: .type_code)
            self.code = try container.decodeIfPresent(String.self, forKey: .code)
            self.datec = try container.decodeIfPresent(Int.self, forKey: .datec)
            self.datem = try container.decodeIfPresent(Int.self, forKey: .datem)
            self.datep = try container.decode(MultiType.self, forKey: .datep).intValue
            self.datef = try container.decode(MultiType.self, forKey: .datef).intValue
            self.authorid = try container.decodeIfPresent(String.self, forKey: .authorid)
            self.usermodid = try container.decodeIfPresent(String.self, forKey: .usermodid)
            self.location = try container.decodeIfPresent(String.self, forKey: .location)
            self.socid = try container.decodeIfPresent(String.self, forKey: .socid)
            self.priority = try container.decodeIfPresent(String.self, forKey: .priority)
			if let dictUserAssigned = try? container.decode([String: DolibarrAgendaEventUserAssigned].self, forKey: .userassigned) {
				self.userassigned = dictUserAssigned
			} else {
				self.userassigned = nil
			}
            self.userownerid = try container.decodeIfPresent(String.self, forKey: .userownerid)
            self.elementid = try container.decodeIfPresent(String.self, forKey: .elementid)
            self.elementtype = try container.decodeIfPresent(String.self, forKey: .elementtype)
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
		hasher.combine(label)
		hasher.combine(progress)
		hasher.combine(fullDayEvent)
		// hasher.combine(visibility) // TODO: Not yet implemented in Dolibarr
		hasher.combine(optional: type_id)
		hasher.combine(optional: type)
		hasher.combine(optional: type_code)
		hasher.combine(optional: code)
		hasher.combine(optional: datec)
		hasher.combine(optional: datem)
		hasher.combine(optional: datep)
		hasher.combine(optional: datef)
		hasher.combine(optional: authorid)
		hasher.combine(optional: usermodid)
		hasher.combine(optional: location)
		hasher.combine(optional: socid)
		hasher.combine(optional: priority)
		hasher.combine(optional: userassigned)
		hasher.combine(optional: userownerid)
		hasher.combine(optional: elementid)
		hasher.combine(optional: elementtype)
		super.hash(into: &hasher)
    }

    override func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encodeIfNotEmpty(ref, forKey: .ref)
		try container.encodeIfNotEmpty(label, forKey: .label)
		try container.encodeIfNotEmpty(progress, forKey: .progress)
		try container.encodeIfNotEmpty(fullDayEvent, forKey: .fullDayEvent)
		// try container.encodeIfNotEmpty(visibility, forKey: .visibility) // TODO: Not yet implemented in Dolibarr
		try container.encodeIfPresentAndNotEmpty(type_id, forKey: .type_id)
		try container.encodeIfPresentAndNotEmpty(type, forKey: .type)
		try container.encodeIfPresentAndNotEmpty(type_code, forKey: .type_code)
		try container.encodeIfPresentAndNotEmpty(code, forKey: .code)
		try container.encodeIfPresentAndNotZero(datec, forKey: .datec)
		try container.encodeIfPresentAndNotZero(datem, forKey: .datem)
		try container.encodeIfPresentAndNotZero(datep, forKey: .datep)
		try container.encodeIfPresentAndNotZero(datef, forKey: .datef)
		try container.encodeIfPresentAndNotEmpty(authorid, forKey: .authorid)
		try container.encodeIfPresentAndNotEmpty(usermodid, forKey: .usermodid)
		try container.encodeIfPresent(location, forKey: .location)
		try container.encodeIfPresent(socid, forKey: .socid)
		try container.encodeIfPresentAndNotEmpty(priority, forKey: .priority)
		try container.encodeIfPresent(userassigned, forKey: .userassigned)
		try container.encodeIfPresentAndNotEmpty(userownerid, forKey: .userownerid)
		try container.encodeIfPresent(elementid, forKey: .elementid)
		try container.encodeIfPresent(elementtype, forKey: .elementtype)
		try super.encode(to: encoder)
    }

}
