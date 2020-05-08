//
//  WeatherService.swift
//  DemoWeather
//
//  Created by Alon on 07.05.20.
//  Copyright © 2020 Weatherapp. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire
import SwiftyJSON
import Kingfisher

struct HardCoded {
     var name:String
     var lat: String
     var lon: String
 }

extension UIImageView {
    
        func loadWeatherIcon(icon: String) {
            DispatchQueue.main.async {
                // Handle Images
                let BASE_URL_STR = "http://openweathermap.org/img/wn/\(icon).png"
                print(BASE_URL_STR)
                let IMAGE_HOST_URL = URL(string: BASE_URL_STR)
                let placeholder = UIImage(named: "placeholder")
                self.kf.indicatorType = .activity
                self.contentMode = .scaleAspectFill
                self.kf.setImage(with: IMAGE_HOST_URL, placeholder: placeholder)
            }
        }
    
}

class WeatherService {
    
     let hardCodedCities: [HardCoded] = [HardCoded(name: "Berlin", lat: "52", lon: "30"),
                                HardCoded(name: "Vienna", lat: "48.2", lon: "16.3"),
                                 HardCoded(name: "Barcelona", lat: "41", lon: "23"),
                                 HardCoded(name: "New York", lat: "40.7", lon: "74"),
                                 HardCoded(name: "Amsterdam", lat: "52", lon: "22"),
                                 HardCoded(name: "Jerusalem", lat: "31.7", lon: "35.2"),
                                 HardCoded(name: "Hong Kong", lat: "22.3", lon: "114.2"),
                                 HardCoded(name: "Tokyo", lat: "35.6", lon: "139.7"),
                                 HardCoded(name: "Beijing", lat: "39", lon: "55"),
                                 HardCoded(name: "Moscow", lat: "55.7", lon: "37.6"),
                                 HardCoded(name: "Rome", lat: "42", lon: "12.4")]

     
     
    
     public func unixConvert(unix: Double) -> Date {
         return Date(timeIntervalSince1970: unix)
     }
    
    fileprivate let API_KEY = "765cd33a31e489966b97f3788935e416"
    fileprivate let API_Onecall_URL = "https://api.openweathermap.org/data/2.5/onecall"
    fileprivate let API_Weather_URL = "api.openweathermap.org/data/2.5/weather"

    
    func fetchWeatherOneShot(cities: [HardCoded]) -> Observable<[Location]> {
        // API Connection
        var locations: [Location] = []
        return Observable.create { obersver -> Disposable in
            
            cities.forEach { (city) in
                
                let headers = HTTPHeaders([HTTPHeader(name: "Content-Type", value: "application/json")])
                let API_URL = self.API_Onecall_URL + "?lat=\(city.lat)&lon=\(city.lon)&appid=\(self.API_KEY)&units=metric"
                print(API_URL)

                
                let afRequest = AF.request(API_URL, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
                    
                    switch response.result {
                        case .success(let data):
                            let json = JSON(data)
                            let tz = json["timezone"].stringValue
                            guard let location = self.parseLocation(city: city, json: json) else {
                                print("Error Getting Location")
                                return
                        }
                        
                        print("\(location.name) seems fine. With weather of \(location.weatherTimeBit.weather.description)")
                        print(locations.count)
                            locations.append(location)
                            obersver.onNext(locations)

                            
                        case .failure(let error):
                            obersver.onError(error as Error)
                            print("Request failed with error: \(String(describing: error.failureReason))")
                    }

                    
                })
                
                afRequest.resume()

            }
            
            return Disposables.create {
                
            }
        }
        
    }
    
      func parseLocation(city: HardCoded, json: JSON) -> Location? {
                guard let weathertimeBit = parseCurrent(timezone: city.name, json: json["current"]) else { return nil }
                guard let hourly = parseHourly(timezone: city.name, json: json["hourly"]) else { return nil}
                guard let sevenForcase = parse7Day(json: json["daily"]) else { return nil }

                let location = Location(name: city.name,
                                        lat: city.lat,
                                        lon: city.lon,
                                        weatherTimeBit: weathertimeBit,
                                        hourly: hourly ,
                                        sevenForcase: sevenForcase)

                print("City: \(city.name), Currently its \(weathertimeBit.weather.description) = but you can expect at \(sevenForcase[2].dt) it will be \(sevenForcase[2].feelsLike.morn) tomorrow morning.")

                
                return location


            }

        func parseWeather(json: JSON) -> Weather? {
            let id = json[0]["id"].stringValue
            let main = json[0]["main"].stringValue
            let description = json[0]["description"].stringValue
            let icon = json[0]["icon"].stringValue
            return Weather(id: id, main: main, description: description, icon: icon )
        }

        func parseCurrent(timezone: String, json: JSON) -> WeatherTimeBit? {

            let dt = json["dt"].doubleValue
            let sunrise = json["sunrise"].doubleValue
            let sunset = json["sunset"].doubleValue
            let temp = json["temp"].doubleValue
            let feels_like = json["feels_like"].doubleValue
            let pressure = json["pressure"].doubleValue
            let humidity = json["humidity"].doubleValue
            let dew_point = json["dew_point"].doubleValue
            let uvi = json["uvi"].doubleValue
            let clouds = json["clouds"].intValue
            let wind_speed = json["wind_speed"].intValue
            let wind_deg = json["wind_deg"].doubleValue

            let w = parseWeather(json: json["weather"])
            guard let weather = w else { return nil }

            let weatherTimeBit = WeatherTimeBit(timezone: timezone, dt: dt, sunrise: sunrise, sunset: sunset, temp: temp, feels_like: feels_like, pressure: pressure, humidity: humidity, dew_point: dew_point, uvi: uvi, clouds: clouds, wind_speed: wind_speed, wind_deg: wind_deg, weather: weather)

            return weatherTimeBit

        }

        func parseHourly(timezone: String, json: JSON) -> HourlyWeather? {

            var hourlyarray: [WeatherTimeBit] = []

            if let jsonData = json.array {
                jsonData.forEach { (i) in
                    let hweather = parseCurrent(timezone: timezone, json: i)
                    guard let weather = hweather else { return }
    //                print("At \(weather.dt) it will be \(weather.temp).")
                    hourlyarray.append(weather)
                }
            }

            let hourly = HourlyWeather(HourlyWeather: hourlyarray)

            return hourly

        }

        func parse7Day(json: JSON) -> [Forecast]? {
            var farray: [Forecast] = []

            if let jarray = json.array {
                jarray.forEach { (f) in
                    guard let forcast = parseForcastObject(json: f) else { return }
                    farray.append(forcast)
                    print(forcast.temperature.max)
                }
            }


            return farray
        }

        func parseForcastObject(json: JSON) -> Forecast? {

            let dt = json["dt"].stringValue
            let sunrise = json["sunrise"].stringValue
            let sunset = json["sunset"].stringValue
            let pressure = json["pressure"].doubleValue
            let humidity = json["humidity"].doubleValue
            let dew_point = json["dew_point"].doubleValue
            let wind_speed = json["wind_speed"].doubleValue
            let wind_deg = json["wind_deg"].doubleValue

            let m = "There was an error with parsing "
            guard let temperature = parseTemperatureForecast(json: json["temp"]) else { print("\(m) Temp"); return nil }
            guard let feelsLike = parseFeelsLikeForecast(json: json["feels_like"]) else { print("\(m) Feel"); return nil }
            guard let weather = parseWeather(json: json["weather"] ) else { print("\(m) weather"); return nil }

            let forcast = Forecast(weather: weather,
                                   dt: dt,
                                   sunrise: sunrise,
                                   sunset: sunset,
                                   pressure: pressure,
                                   humidity: humidity,
                                   dew_point: dew_point,
                                   wind_speed: wind_speed,
                                   wind_deg: wind_deg,
                                   temperature: temperature,
                                   feelsLike: feelsLike)

            return forcast

        }

        func parseTemperatureForecast(json: JSON) -> TemperatureForecast? {

            let day = json["day"].doubleValue
            let min = json["min"].doubleValue
            let max = json["max"].doubleValue
            let night = json["night"].doubleValue
            let eve = json["eve"].doubleValue
            let morn = json["morn"].doubleValue

            let temp = TemperatureForecast(day: day,
                                           min: min,
                                           max: max,
                                           night: night,
                                           eve: eve,
                                           morn: morn)

            return temp
        }

        func parseFeelsLikeForecast(json: JSON) -> FeelsLikeForecast? {
            let day = json["day"].doubleValue
            let night = json["night"].doubleValue
            let eve = json["eve"].doubleValue
            let morn = json["morn"].doubleValue

            let feel = FeelsLikeForecast(day: day,
                                         night: night,
                                         eve: eve,
                                         morn: morn)
             return feel
        }
    
}
