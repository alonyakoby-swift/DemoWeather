//
//  ForcastHeader.swift
//  DemoWeather
//
//  Created by Alon on 07.05.20.
//  Copyright © 2020 Weatherapp. All rights reserved.
//


import Foundation
import Carbon

struct ForcastHeaderComponent: Component, Equatable {
    
    func renderContent() -> ForcastHeader {
        return .loadFromNib()
    }
    
    func render(in content: ForcastHeader) {
        
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 49)
    }
    
}


class ForcastHeader: UIView, NibLoadable {
    
    @IBOutlet weak var sectionTitle: UILabel!

    
}
