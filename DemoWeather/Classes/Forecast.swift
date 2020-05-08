//
//  Forecast.swift
//  iMobilityDemo
//
//  Created by Alon on 06.05.20.
//  Copyright © 2020 iMobilityDemo. All rights reserved.
//

import Foundation

struct Forecast: Decodable, Equatable {

    
    var weather: Weather
    var dt: String
    var sunrise: String
    var sunset: String
    var pressure: Double
    var humidity: Double
    var dew_point: Double
    var wind_speed: Double
    var wind_deg: Double
    var temperature: TemperatureForecast
    var feelsLike: FeelsLikeForecast


    static func == (lhs: Forecast, rhs: Forecast) -> Bool {
        
        lhs.weather == rhs.weather &&
        lhs.dt == rhs.dt &&
        lhs.sunrise == rhs.sunrise &&
        lhs.sunset == rhs.sunset &&
        lhs.pressure == rhs.pressure &&
        lhs.humidity == rhs.humidity &&
        lhs.dew_point == rhs.dew_point &&
        lhs.wind_speed == rhs.wind_speed &&
        lhs.wind_deg == rhs.wind_deg &&
        lhs.temperature == rhs.temperature &&
        lhs.feelsLike == rhs.feelsLike
        
    }
}

struct TemperatureForecast: Decodable, Equatable {
    var day: Double
    var min: Double
    var max: Double
    var night: Double
    var eve: Double
    var morn: Double
}

struct FeelsLikeForecast: Decodable,Equatable {
    var day: Double
    var night: Double
    var eve: Double
    var morn: Double
    
}

