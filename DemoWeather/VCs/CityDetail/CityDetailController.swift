//
//  CityDetailController.swift
//  DemoWeather
//
//  Created by Alon on 07.05.20.
//  Copyright © 2020 Weatherapp. All rights reserved.
//

import UIKit
import Carbon


class CityDetailController: UIViewController {

     var location: Location!
    @IBOutlet weak var tableview: UITableView!
    
    let renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )

    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        renderer.target = tableview
        tableview.tableFooterView = UIView()
        tableview.backgroundView?.backgroundColor = .orange
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.title = location.name
        print(location?.lat)
        guard let location = location else { print("No location passed."); return }
        
        let header = ViewNode(DetailHeaderComponent(location: location))
        let hourlyColletion = ViewNode(HourlyCollectionViewComponent(location: location))
        let w = WeatherService()
//        let date = w.unixConvert(unix: dt!)
//        self.date.text = date.toString(format: "mm.dd")
//        self.day.text = "\(date.toString(format: "EEEE"))"
//
//        self.min.text = String(forcast.temperature.min)
//        self.max.text = String(forcast.temperature.max)
//        self.icon.loadWeatherIcon(icon: forcast.weather.icon)
//        self.desc.text = forcast.weather.description

        
        
        let section = ViewNode(ForecastCellComponent(day: <#T##String#>, date: <#T##String#>, min: <#T##String#>, max: <#T##String#>, desc: <#T##String#>, icon: <#T##String#>))
//        print(location.hourly.HourlyWeather.count)
        renderer.render(
            Section(id: 0, header: header),
            Section(id: 1, header: hourlyColletion)
        )
    }
    
    func

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
