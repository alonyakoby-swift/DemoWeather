//
//  Location.swift
//  Weatherapp
//
//  Created by Alon on 05.05.20.
//  Copyright © 2020 Weatherapp. All rights reserved.
//

import Foundation

class Location: Decodable {
    
    
    var name: String
    var lat: String
    var lon: String
    var weatherTimeBit: WeatherTimeBit
    var hourly: HourlyWeather
    var sevenForcase: [Forecast]
    
    init(name: String, lat: String, lon: String, weatherTimeBit: WeatherTimeBit, hourly: HourlyWeather ,sevenForcase: [Forecast]) {
        
        self.name = name
        self.lat = lat
        self.lon = lon
        self.weatherTimeBit = weatherTimeBit
        self.hourly = hourly
        self.sevenForcase = sevenForcase
        
    }
}


