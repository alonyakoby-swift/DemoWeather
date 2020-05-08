//
//  CityVM.swift
//  DemoWeather
//
//  Created by Alon on 07.05.20.
//  Copyright © 2020 Weatherapp. All rights reserved.
//

import Foundation

class cityVM {
    

    
    let location: Location

    var displayTemp: String {
        return location.weatherTimeBit.temp.rounded().forTrailingZero().convertToCelcius()
        
    }
    
    init(location: Location) {
        self.location = location
    }
}

extension Double {
    func forTrailingZero() -> String {
        return String(format: "%g", self)
    }
}

extension String {
    
    func convertToCelcius() -> String {
        let text = self + "°C"
        return text

    }
}
