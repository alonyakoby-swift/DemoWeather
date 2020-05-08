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
    
        var location: Location
    
        func renderContent() -> HourlyCollectionView {
            return .loadFromNib()
        }
        
        func render(in content: HourlyCollectionView) {
            let data = location.hourly.HourlyWeather
            let count = data.count
            print("Counting \(count)")
            
            
            content.bits = data
            content.setup()
        }
        
        func referenceSize(in bounds: CGRect) -> CGSize? {
            return CGSize(width: 62, height: 102)
        }
        
    }


class HourlyCollectionView: UIView, NibLoadable {
    
    @IBOutlet weak var collectionview: UICollectionView!
    var dataSource: HourlyDataSource?
    var bits: [WeatherTimeBit]!
    
    func setup ()  {
        self.dataSource = HourlyDataSource(collectionview, bits)
    }
    
    override func awakeFromNib() {
      
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: 62, height: 100)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionview!.collectionViewLayout = layout


    }

}

class HourlyDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionview: UICollectionView
    var collectionViewData: [WeatherTimeBit]
    
    let reuseID = "hourCell"
    
    init(_ cv: UICollectionView, _ data: [WeatherTimeBit]) {
        
        
        collectionViewData = data
        print("collectionViewData: \(collectionViewData.count)")
        collectionview = cv
        
        super.init()
        collectionview.delegate = self
        collectionview.dataSource = self
        
        
        collectionview.register(UINib(nibName: "HourCell", bundle: nil), forCellWithReuseIdentifier: reuseID)

    }
    

    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24 // collectionViewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath) as! HourCell
        
        let bit = collectionViewData[indexPath.row]
        cell.configure(bit: bit)
            
        return cell
    }
    
    
  
}
