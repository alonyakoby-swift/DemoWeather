//
//  ForecastCell.swift
//  DemoWeather
//
//  Created by Alon on 07.05.20.
//  Copyright © 2020 Weatherapp. All rights reserved.
//

import Foundation
import Carbon

struct ForecastCellComponent: IdentifiableComponent, Hashable {
    
    
    let day: String
    let date: String
    let min: String
    let max: String
    let desc: String
    let icon: String
    
    func renderContent() -> ForecastCell {
        return .loadFromNib()
    }
    
    func render(in content: ForecastCell) {
        
        content.configure(day: day, date: date, min: min, max: max, desc: desc, icon: icon)
        
        
        
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 94)
    }
    
}


class ForecastCell: UIView, NibLoadable {
    
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var max: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    func configure(day: String,date: String,min: String,max: String,desc: String,icon: String) {
        self.day.text = day
        
        self.min.text = min
        self.max.text = max
        self.icon.loadWeatherIcon(icon: icon)
        self.desc.text = desc
    }

}
