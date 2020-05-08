//
//  Weather.swift
//  Weatherapp
//
//  Created by Alon on 05.05.20.
//  Copyright © 2020 Weatherapp. All rights reserved.
//

import Foundation
import UIKit

class Weather: Decodable, Equatable {
    

    var id: String
    var main: String
    var description: String
    var icon: String
    
    init(id: String, main: String, description: String, icon: String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
        
    }
    
    static func == (lhs: Weather, rhs: Weather) -> Bool {
        lhs.id == rhs.id &&
        lhs.main == rhs.main &&
        lhs.description == rhs.description &&
        lhs.icon == rhs.icon
        
        
    }

}

