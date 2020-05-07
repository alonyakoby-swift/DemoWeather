//
//  CityVM.swift
//  DemoWeather
//
//  Created by Alon on 07.05.20.
//  Copyright © 2020 Weatherapp. All rights reserved.
//

import Foundation

class cityVM {
    
    func forTrailingZero(temp: Double) -> String {
        var tempVar = String(format: "%g", temp)
        return tempVar
    }

    
    let location: Location

    var displayTemp: String {
        let temperature =  forTrailingZero(temp: location.weatherTimeBit.temp.rounded())
        return temperature + "°C"
    }
    
    init(location: Location) {
        self.location = location
    }
}
