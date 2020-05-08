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

    var location: Location?
    @IBOutlet weak var tableview: UITableView!
    
    let renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        renderer.target = tableview
        tableview.tableFooterView = UIView()
        tableview.backgroundView?.backgroundColor = .orange
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(location?.lat)
        guard let location = location else { print("No location passed."); return }
        let header = ViewNode(DetailHeaderComponent(location: location))
        renderer.render(Section(id: 0, header: header))
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
