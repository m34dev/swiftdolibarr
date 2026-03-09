//
//  CustomLogger.swift
//  SwiftDolibarr
//
//  Created by William Mead on 21/04/2025.
//

import OSLog

extension Logger {

    // MARK: - Properties

	private static let subsystem = "com.m34d.swiftdolibarr"

    // MARK: - Enums

    enum LoggerCategories: String {
        case api
        case user
        case viewCycle
    }

    // MARK: - Type methods

	internal static func logWithoutSignal(
		_ message: String,
		level: OSLogType = .info,
		category: LoggerCategories,
		subsystem: String = subsystem
	) {
		Logger(
			subsystem: subsystem,
			category: category.rawValue
		).log(level: level, "\(message, privacy: .public)")
    }

    internal static func logErrorWithoutSignal(
		_ error: Error,
		context: String,
		level: OSLogType = .error,
		category: LoggerCategories,
		subsystem: String = subsystem
	) {
		Logger(
			subsystem: subsystem,
			category: category.rawValue
		).log(level: level, "\(context): \(error.localizedDescription, privacy: .public)")
    }

    internal static func logWithSignal(
		_ message: String,
		parameters: [String: String] = [:],
		level: OSLogType = .info,
		category: LoggerCategories,
		subsystem: String = subsystem
	) {
		Logger(
			subsystem: subsystem,
			category: category.rawValue
		).log(level: level, "\(message, privacy: .private)")
    }

    internal static func logErrorWithSignal(
		_ error: Error,
		context: String,
		parameters: [String: String] = [:],
		level: OSLogType = .error,
		category: LoggerCategories,
		subsystem: String = subsystem
	) {
		Logger(
			subsystem: subsystem,
			category: category.rawValue
		).log(level: level, "\(context): \(error.localizedDescription, privacy: .private)")
    }

	internal static func logDecodingError(
		_ decodingError: DecodingError,
		decodeContext: String,
		subsystem: String = subsystem
	) {
		switch decodingError {
		case .keyNotFound(let key, let context):
			Logger.logWithSignal("Key: \(key) not found: \(context.debugDescription)", category: .api, subsystem: subsystem)
			Logger.logErrorWithSignal(decodingError, context: decodeContext, category: .api, subsystem: subsystem)
		case .valueNotFound(let value, let context):
			let key = context.codingPath.last?.stringValue ?? "Unknown key"
			Logger.logWithSignal(
				"Value: \(value) not found for key: \(key): \(context.debugDescription)",
				category: .api,
				subsystem: subsystem
			)
			Logger.logErrorWithSignal(decodingError, context: decodeContext, category: .api, subsystem: subsystem)
		case .typeMismatch(let type, let context):
			let key = context.codingPath.last?.stringValue ?? "Unknown key"
			Logger.logWithSignal(
				"Type: \(type) mismatch for key: \(key): \(context.debugDescription)",
				category: .api,
				subsystem: subsystem
			)
			Logger.logErrorWithSignal(decodingError, context: decodeContext, category: .api, subsystem: subsystem)
		case .dataCorrupted(let context):
			Logger.logWithSignal("Data corrupted: \(context.debugDescription)", category: .api, subsystem: subsystem)
			Logger.logErrorWithSignal(decodingError, context: decodeContext, category: .api, subsystem: subsystem)
		@unknown default:
			Logger.logErrorWithSignal(decodingError, context: decodeContext, category: .api, subsystem: subsystem)
		}
	}

}
