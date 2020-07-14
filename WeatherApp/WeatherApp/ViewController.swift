//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ivan Akulov on 24/08/16.
//  Copyright © 2016 Ivan Akulov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var pressureLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var appearentTemperatureLabel: UILabel!
  @IBOutlet weak var refreshButton: UIButton!
  
  @IBAction func refreshButtonTapped(_ sender: UIButton) {
    
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let icon = WeatherIconManager.showerRain.image 
    let currentWeather = CurrentWeather(temperature: 22.0, appearentTemperature: 24.0, humidity: 30, pressure: 120, icon: icon)
    updateUIWith(currentWeather: currentWeather)
    
    }
  
    func updateUIWith(currentWeather: CurrentWeather) {
        self.imageView.image = currentWeather.icon
        self.temperatureLabel.text = currentWeather.temperatureString
        self.appearentTemperatureLabel.text = currentWeather.appearentTemperatureString
        self.pressureLabel.text = currentWeather.pressureString
        self.humidityLabel.text = currentWeather.humidityString
    }
  
  
}


