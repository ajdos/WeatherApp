//
//  APIWeatherManager.swift
//  WeatherApp
//
//  Created by Айдин Абдурахманов on 14.07.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import Foundation



enum ForecastType: FinalURLPoints {
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org")!
    }
    var path: String {
        switch self {
        case .Current(let apiKey, let city):
            return "/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        }
    }
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)
        return URLRequest(url: url!)
    }
    case Current(apiKey: String, city: String)
}

final class APIWeatherManager: APIManager {
    var sessionConfiguration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: self.sessionConfiguration)
    }()
    let apiKey: String
    
    init(sessionConfiguration: URLSessionConfiguration, apiKey: String) {
        self.sessionConfiguration = sessionConfiguration
        self.apiKey = apiKey
    }
    convenience init(apiKey: String) {
        self.init(sessionConfiguration: URLSessionConfiguration.default, apiKey: apiKey)
    }
//    func fetchCurrentWeatherWith(city: String, completionHandler: (APIResult<CurrentWeather>) -> Void) {
//        let request = ForecastType.Current(apiKey: self.apiKey, city: city).request
//        
//        fetch(request: request, parse: { (json) -> CurrentWeather? in
//            if let dictionary = json["main"]
//            
//            
//        }, completionHandler: <#T##(APIResult<T>) -> Void#>)
//    }
}
