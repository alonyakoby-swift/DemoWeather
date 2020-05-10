//
//  CitiesController.swift
//  DemoWeather
//
//  Created by Alon on 07.05.20.
//  Copyright © 2020 Weatherapp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Carbon

class CitiesController: UIViewController {

    let disposeBag = DisposeBag()
    private var viewModel: CitiesViewModel!
    
    static func instantiate(viewModel: CitiesViewModel) -> CitiesController {
        let vc = CitiesController()
        vc.viewModel = viewModel
        return vc
        
    }
    
    @IBOutlet weak var tableview: UITableView!
    var cellid = "cityCell"
    private var locations: [Location] = [ ]
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        let nib = UINib(nibName: "CityCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: cellid)
        tableview.rowHeight = 100
        
        self.title = "Cities"
        self.tableview.delegate = self
        viewModel.fetchWeather()
            .observeOn(MainScheduler.instance)
            .bind(to: tableview.rx.items(cellIdentifier: cellid)) { index, vm, cell in
            
                    
            print("llll: \(self.locations.count)")
            self.locations = self.viewModel.locations

                
            let ccell = cell as! CityCell
            let bit = vm.location.weatherTimeBit
            ccell.location = vm.location
            ccell.configure(bit: bit)
            ccell.tempLabel.text = vm.displayTemp

        }.disposed(by: disposeBag)
        self.tableview.reloadData()

    }

}

extension CitiesController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! CityCell

        let location: Location = currentCell.location!
        print(location.name)
        

        let header = ViewNode(DetailHeaderComponent(location: location))
        let hourlyColletion = ViewNode(HourlyCollectionViewComponent(location: location))

        let section1 = Section(id: 0, header: header, footer: hourlyColletion)
        let section2 = makeForecast(forecasts: location.sevenForcase)
        
        let vc = CarbonController.initVC(sections: [section1, section2])
        vc.view.backgroundColor = .black
        vc.location = location

        
        self.navigationController?.pushViewController(vc, animated: true)

    }
    func makeForecast(forecasts: [Forecast]) -> Section {
                var array = forecasts
                var nodes: [CellNode] = []
                array.remove(at: 0)
                array.forEach { (i) in
                    let service = WeatherService()
                    guard let dt = Double(i.dt) else  { return }
                    let date = service.unixConvert(unix: dt)
                    
                    let node = CellNode(ForecastCellComponent(day: date.toString(format: "EE"),
                    date: date.toString(format: "dd.MM.yyyy"), min: "/\(String(i.temperature.min.rounded().forTrailingZero()).convertToCelcius())", max: String(i.temperature.max.rounded().forTrailingZero()).convertToCelcius(), desc: i.weather.description, icon: i.weather.icon))
                    
                    nodes.append(node)

        }
            
        let section = Section(id: 1, header: ViewNode(ForcastHeaderComponent()) , cells: nodes)
        return section
    }

}

