//
//  WeatherInCityViewController.swift
//  WeatherApp
//
//  Created by David Rico on 13/02/2016.
//  Copyright © 2016 David Rico. All rights reserved.
//

import UIKit

protocol WeatherInCityView: class {
    var presenter: WeatherInCityPresenter { get set }
    
    var today: String { get set }
    var todayTemp: String { get set }
    
    func cityViewReloadWeekDaysForecast()
}

class WeatherInCityViewController: UIViewController, WeatherInCityView, UITableViewDataSource {
    
    var presenter: WeatherInCityPresenter
    let city: String
    
    @IBOutlet weak var weekTableView: UITableView!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var todayTempLabel: UILabel!
    
    
    init(city: String, presenter: WeatherInCityPresenter) {
        self.city = city
        self.presenter = presenter
        
        self.today = ""
        self.todayTemp = ""
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Viewlifecycle related methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uiBarButton = UIBarButtonItem(title: "Refresh",
            style: .Plain, target: self, action: "refreshButtonDidTap")
        navigationItem.setRightBarButtonItem(uiBarButton, animated: false)
        
        presenter.UI = self
        
        weekTableView.dataSource = self
        weekTableView.registerNib(UINib(nibName: "WeatherDayCell", bundle: nil), forCellReuseIdentifier: "WeatherDayCell")
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.loadWeather()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        todayLabel = nil
        todayTempLabel = nil
        weekTableView = nil
    }
    
    //MARK: Refresh Bar button related methods
    
    func refreshButtonDidTap() {
        presenter.loadWeather()
    }
    
    //MARK: WeatherInCityView related methods
    
    var today: String {
        didSet {
            todayLabel.text = today
        }
    }
    
    var todayTemp: String {
        didSet {
            todayTempLabel.text = todayTemp
        }
    }
    
    func cityViewReloadWeekDaysForecast() {
        weekTableView.reloadData()
    }
    
    //MARK: UITableViewDataSource related methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.weekDaysToDisplay()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let weatherCell = tableView.dequeueReusableCellWithIdentifier("WeatherDayCell") as! WeatherDayCell
        
        presenter.presentWeekDayView(weatherCell, atIndex: indexPath.row)
        
        return weatherCell
    }
}
