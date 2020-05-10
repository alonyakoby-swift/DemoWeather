//
//  CarbonController.swift
//  DemoWeather
//
//  Created by Alon on 09.05.20.
//  Copyright © 2020 Weatherapp. All rights reserved.
//

import UIKit
import Carbon

class CarbonController: UIViewController {
    

    var location: Location?
    var sections: [Section]!
    
    private var tableview: UITableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }

    
    let renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )
        
    static func initVC(sections: [Section]) -> CarbonController {

        let vc = CarbonController()
        vc.sections = sections
        return vc
        
        }



    
    override func viewDidLoad() {
        super.viewDidLoad()
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        setNeedsStatusBarAppearanceUpdate()
        tableview = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
        tableview.backgroundColor =  .clear
        self.view.addSubview(tableview)
        tableview.tableFooterView = UIView()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.title = location?.name
        renderer.target = tableview
        renderer.render(sections)

    }
    


}
