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
//  DolibarrBusinessObject.swift
//  SwiftDolibarr
//
//  Created by William Mead on 24/12/2024.
//

import Foundation

public protocol DolibarrBusinessObject: Hashable, DolibarrObject {

    // Properties

    /// Business object status code
    var statusCode: String { get set }

    /// Business object extra fields
    var arrayOptions: [String: MultiType]? { get set }

    /// Business object public note
    var notePublic: String? { get set }

    /// Business object private note
    var notePrivate: String? { get set }

    // Computed properties

    /// Associated business object status type
    var status: DolibarrObjectStatus { get }

}
