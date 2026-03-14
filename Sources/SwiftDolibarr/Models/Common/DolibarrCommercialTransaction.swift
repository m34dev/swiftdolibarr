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
//  DolibarrCommercialTransaction.swift
//  SwiftDolibarr
//
//  Created by William Mead on 08/02/2026.
//

import Foundation

public protocol DolibarrCommercialTransaction {

	// Properties

	/// Associated third party ID
	var thirdPartyId: String { get set }

	/// Commercial transaction status code
	var statusCode: String { get set }

	/// Commercial transaction reference
	var ref: String { get set }

	/// Total amount excluding tax
	var totalExclTax: String { get set }

	/// Total tax amount
	var totalTax: String { get set }

	/// Total amount including tax
	var totalInclTax: String { get set }

}
