//
//  CityCell.swift
//  Weatherapp
//
//  Created by Alon on 05.05.20.
//  Copyright © 2020 Weatherapp. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {

    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var location: Location?

    
    
    func configure (bit: WeatherTimeBit) {
        let temperature = "\(bit.temp)°C"
        print(temperature)
        nameLabel.text = bit.timezone
        imageView?.loadWeatherIcon(icon: bit.weather.icon ?? "")

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

