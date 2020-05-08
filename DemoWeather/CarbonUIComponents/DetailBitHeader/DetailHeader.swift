//
//  DetailHeader.swift
//  DemoWeather
//
//  Created by Alon on 07.05.20.
//  Copyright © 2020 Weatherapp. All rights reserved.
//

import Foundation
import Carbon

struct DetailHeaderComponent: Component, Equatable {
    
    var location : Location
    
    func renderContent() -> DetailHeader {
        return .loadFromNib()
    }
    
    func render(in content: DetailHeader) {
        
//        content.timezone.text = location.name
        content.icon.loadWeatherIcon(icon: location.weatherTimeBit.weather.icon)
        content.temperature.text = location.weatherTimeBit.temp.rounded().forTrailingZero().convertToCelcius()
        content.desc.text = location.weatherTimeBit.weather.description
        content.sunrise.text = location.weatherTimeBit.sunrise.toString(format: "HH:mm")
        content.sunset.text = location.weatherTimeBit.sunset.toString(format: "HH:mm")
        
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 100)
    }
    
}


class DetailHeader: UIView, NibLoadable {
    
    @IBOutlet weak var timezone: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!

    
}
