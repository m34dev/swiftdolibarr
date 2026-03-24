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
//  DolibarrExpenseReportType.swift
//  SwiftDolibarr
//
//  Created by William Mead on 06/12/2025.
//

import Foundation

struct DolibarrExpenseReportType: Identifiable, Hashable, Decodable {

	// MARK: - Properties

	var id: String
	var code: String
	var label: String
	var accountancyCode: String?
	var active: String

	// MARK: - Enums

	enum CodingKeys: String, CodingKey {
		case id
		case code
		case label
		case accountancyCode = "accountancy_code"
		case active
	}

}
