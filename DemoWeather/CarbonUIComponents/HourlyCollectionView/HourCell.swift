//
//  HourCell.swift
//  DemoWeather
//
//  Created by Alon on 07.05.20.
//  Copyright © 2020 Weatherapp. All rights reserved.
//

import UIKit

class HourCell: UICollectionViewCell {

    @IBOutlet weak var hour: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var main: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(bit: WeatherTimeBit) {
        let hour = bit.dt.toString(format: "HH")
        self.hour.text = "\(hour)h"
        self.icon.loadWeatherIcon(icon: bit.weather.icon)
        self.main.text = bit.weather.main
        self.temp.text = bit.temp.rounded().forTrailingZero().convertToCelcius()
        
    }

}
