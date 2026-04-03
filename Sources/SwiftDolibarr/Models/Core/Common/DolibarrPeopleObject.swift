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
//  DolibarrPeopleObject.swift
//  SwiftDolibarr
//
//  Created by William Mead on 02/05/2025.
//

import Foundation

/// A protocol for Dolibarr objects that represent people.
///
/// Provides common person-related properties such as ``name``,
/// ``email``, and ``socialnetworks``.
///
/// - SeeAlso: ``DolibarrThirdParty``
/// - SeeAlso: ``DolibarrContact``
public protocol DolibarrPeopleObject: Hashable {

    /// Person name
    var name: String { get }

    /// Person email address
    var email: String? { get set }

	/// Person social networks
	var socialnetworks: [String: String]? { get set }

}
