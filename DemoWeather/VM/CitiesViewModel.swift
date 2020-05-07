//
//  CitiesViewModel.swift
//  DemoWeather
//
//  Created by Alon on 07.05.20.
//  Copyright © 2020 Weatherapp. All rights reserved.
//

import Foundation
import RxSwift


final class CitiesViewModel {
    
    var locations: [Location] = []
    let weatherservice = WeatherService()

    func fetchWeather() -> Observable<[cityVM]> {
        self.locations = []
        let hc = weatherservice.hardCodedCities
        
        
        let val = weatherservice.fetchWeatherOneShot(cities: hc).map { $0.map { location in
                return cityVM(location: location)
            }
            
        }

        return val
    
        
    }
}
