//
//  weatherTimeBit.swift
//  Weatherapp
//
//  Created by Alon on 04.05.20.
//  Copyright © 2020 Weatherapp. All rights reserved.
//

import Foundation

class WeatherTimeBit: Decodable, Equatable {
    
    
    var timezone: String
    var dt: Date
    var sunrise: Date
    var sunset: Date
    var temp: Double
    var feels_like: Double
    var pressure: Double
    var humidity: Double
    var dew_point: Double
    var uvi: Double
    var wind_deg: Double
    var clouds: Int
    var wind_speed: Int
    var weather: Weather
    
    init(timezone: String, dt: Double, sunrise: Double, sunset: Double, temp: Double, feels_like: Double, pressure: Double, humidity: Double, dew_point: Double, uvi: Double, clouds: Int, wind_speed: Int, wind_deg: Double, weather: Weather) {
        
        let w = WeatherService()
        self.timezone = timezone
        self.dt = w.unixConvert(unix: dt)
        self.sunrise = w.unixConvert(unix: sunrise)
        self.sunset = w.unixConvert(unix: sunset)
        self.temp = temp
        self.feels_like = feels_like
        self.pressure = pressure
        self.humidity = humidity
        self.dew_point = dew_point
        self.uvi = uvi
        self.wind_deg = wind_deg
        self.clouds = clouds
        self.wind_speed = wind_speed
        self.weather = weather

    }
    static func == (lhs: WeatherTimeBit, rhs: WeatherTimeBit) -> Bool {
        lhs.timezone == rhs.timezone &&
        lhs.dt == rhs.dt &&
        lhs.sunrise == rhs.sunrise &&
        lhs.sunset == rhs.sunset &&
        lhs.temp == rhs.temp &&
        lhs.feels_like == rhs.feels_like &&
        lhs.pressure == rhs.pressure &&
        lhs.humidity == rhs.humidity &&
        lhs.dew_point == rhs.dew_point &&
        lhs.uvi == rhs.uvi &&
        lhs.wind_deg == rhs.wind_deg &&
        lhs.clouds == rhs.clouds &&
        lhs.wind_speed == rhs.wind_speed &&
        lhs.weather == rhs.weather
        
        
        
        
    }

}

