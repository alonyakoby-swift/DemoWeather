//
//  Forecast.swift
//  iMobilityDemo
//
//  Created by Alon on 06.05.20.
//  Copyright © 2020 iMobilityDemo. All rights reserved.
//

import Foundation

struct Forecast: Decodable {
    
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
}

struct TemperatureForecast: Decodable {
    var day: Double
    var min: Double
    var max: Double
    var night: Double
    var eve: Double
    var morn: Double
}

struct FeelsLikeForecast: Decodable {
    var day: Double
    var night: Double
    var eve: Double
    var morn: Double
    
}

