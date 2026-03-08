//
//  DolibarrInterventionLine.swift
//  SwiftDolibarr
//
//  Created by William Mead on 11/12/2024.
//

import Foundation
import OSLog

@Observable final class DolibarrInterventionLine: CommonBusinessObjectLine {

    // MARK: - Properties

	// Required

	var datei: Double
	var duration: String

	// Optional

    var desc: String?

    // MARK: - Enums

    enum CodingKeys: CodingKey {
		case datei
		case duration
        case desc
    }

    // MARK: - Inits

    init(
		datei: Double = Date.now.timeIntervalSince1970,
		duration: String = "3600",
		desc: String? = nil,
		id: String = "",
		rang: String = ""
	) {
		self.datei = datei
		self.duration = duration
        self.desc = desc
		super.init(id: id, rang: rang)
    }

    required init(from decoder: any Decoder) throws {
        do {
            Logger.logWithoutSignal("\(Self.self).init.decode", level: .info, category: .api)
            let container = try decoder.container(keyedBy: CodingKeys.self)
			self.datei = try container.decode(Double.self, forKey: .datei)
			self.duration = try container.decode(String.self, forKey: .duration)
            self.desc = try container.decodeIfPresent(String.self, forKey: .desc)
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
        hasher.combine(datei)
		hasher.combine(duration)
		hasher.combine(optional: desc)
		super.hash(into: &hasher)
    }

    override func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(datei, forKey: .datei)
        try container.encode(duration, forKey: .duration)
		try container.encode(desc, forKey: .desc)
		try super.encode(to: encoder)
    }

}
