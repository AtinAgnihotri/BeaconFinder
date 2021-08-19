//
//  LocationState.swift
//  BeaconFinder
//
//  Created by Atin Agnihotri on 19/08/21.
//

import Foundation
import UIKit

struct LocationState: Equatable {
    var name: String
    var color: UIColor {
        switch name {
            case "Far":
                return .blue
            case "Near":
                return .orange
            case "Right Here":
                return .red
            default:
                return .gray
        }
    }
}

extension LocationState: ExpressibleByStringLiteral {
    init(stringLiteral: String) {
        name = stringLiteral
    }
}

enum LocationStates: LocationState {
    case unknown = "Unknown"
    case far = "Far"
    case near = "Near"
    case rightHere = "Right Here"
}
