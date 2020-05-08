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
    var vc: UIViewController
    
    func renderContent() -> ForecastCell {
        return .loadFromNib()
    }
    
    func render(in content: ForecastCell) {
        
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 116)
    }
    
}


class ForecastCell: UIView, NibLoadable {
    
    @IBOutlet weak var timezone: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!

    
}
