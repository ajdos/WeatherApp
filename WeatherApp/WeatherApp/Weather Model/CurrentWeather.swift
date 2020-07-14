//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Ivan Akulov on 24/08/16.
//  Copyright © 2016 Ivan Akulov. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
  let temperature: Double
  let appearentTemperature: Double
  let humidity: Double
  let pressure: Double
  let icon: UIImage
}
extension CurrentWeather {
    var temperatureString: String {
        return "\(Int(temperature))˚C"
    }
    var appearentTemperatureString: String {
        return "\(Int(appearentTemperature))˚C"
    }
    var pressureString: String {
        return "\(Int(pressure)) mm"
    }
    var humidityString: String {
        "\(Int(humidity)) %"
    }
}
