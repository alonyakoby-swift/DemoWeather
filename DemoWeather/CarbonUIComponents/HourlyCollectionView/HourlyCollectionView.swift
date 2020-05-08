//
//  HourlyCollectionView.swift
//  DemoWeather
//
//  Created by Alon on 07.05.20.
//  Copyright © 2020 Weatherapp. All rights reserved.
//

import Foundation
import Carbon

struct HourlyCollectionViewComponent: Component, Equatable {
    
        func renderContent() -> HourlyCollectionView {
            return .loadFromNib()
        }
        
        func render(in content: HourlyCollectionView) {
        }
        
        func referenceSize(in bounds: CGRect) -> CGSize? {
            return CGSize(width: bounds.width, height: 130)
        }
        
    }


class HourlyCollectionView: UIView, NibLoadable {
    @IBOutlet weak var collectionview: UICollectionView!
    var dataSource: HourlyDataSource!
}

class HourlyDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionview: UICollectionView
    var collectionViewData: [HourlyWeather]
    
    let reuseID = "hourCell"
    
    init(_ cv: UICollectionView, _ data: [HourlyWeather]) {
        
        
        collectionViewData = data
        print(collectionViewData.count)
        collectionview = cv
        
        super.init()
        collectionview.delegate = self
        collectionview.dataSource = self
        
        
        collectionview.register(UINib(nibName: "HourCell", bundle: nil), forCellWithReuseIdentifier: reuseID)

    }

    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath) as! HourCell
                
        return cell
    }
    
    
  
}
