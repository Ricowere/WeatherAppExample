//
//  WeatherDayCell.swift
//  WeatherApp
//
//  Created by David Rico on 13/02/2016.
//  Copyright © 2016 David Rico. All rights reserved.
//

import UIKit

protocol WeatherWeekdayTempView: class {
    var dayWeek: String {get set}
    var minTemp: String {get set}
    var maxTemp: String {get set}
    var currentTemp: String {get set}
}


class WeatherDayCell: UITableViewCell, WeatherWeekdayTempView {

    @IBOutlet weak var dayWeekLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    var dayWeek: String = "" {
        didSet {
            dayWeekLabel.text = dayWeek
        }
    }
    
    var minTemp: String = "" {
        didSet {
            minTempLabel.text = minTemp
        }
    }
    
    var maxTemp: String = "" {
        didSet {
            maxTempLabel.text = maxTemp
        }
        
    }
    
    var currentTemp: String = "" {
        didSet {
            currentTempLabel.text = currentTemp
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
