//
//  HourlyWeather.swift
//  iMobilityDemo
//
//  Created by Alon on 06.05.20.
//  Copyright © 2020 iMobilityDemo. All rights reserved.
//

import Foundation

struct HourlyWeather: Decodable, Equatable {
    static func == (lhs: HourlyWeather, rhs: HourlyWeather) -> Bool {
        lhs.HourlyWeather == rhs.HourlyWeather
    }
    
    
    var HourlyWeather: [WeatherTimeBit]
    
}
