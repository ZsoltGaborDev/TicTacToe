//
//  Card.swift
//  TicTacToe
//
//  Created by zsolt on 01/07/2019.
//  Copyright © 2018 Olga Volkova OC. All rights reserved.
//

import Foundation

enum Card {
    case cross, zero // nil -> blank
    
    func title() -> String {
        var title: String
        switch self {
        case .cross: title = "X"
        case .zero: title = "O"
        }
        return title
    }
}
