//
//  APIManager.swift
//  WeatherApp
//
//  Created by Айдин Абдурахманов on 13.07.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import Foundation
typealias JSONTask = URLSessionDataTask
typealias JSONCompletionHandler = ([String:AnyObject]?, HTTPURLResponse?, Error?) -> Void

protocol FinalURLPoints {
    var baseURL: URL { get }
    var path: String { get }
    var request: URLRequest { get }
    
}

enum APIResult<T> {
    case Success(T)
    case Failure(Error)
}



protocol APIManager {
    var sessionConfiguration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    func JSONTaskWithRequest(request: URLRequest, completionHandler: @escaping JSONCompletionHandler) -> JSONTask
    func fetch<T>(request: URLRequest, parse: @escaping ([String:AnyObject]) -> T?, completionHandler: @escaping (APIResult<T>) -> Void)
    }





// Реализация требований протокола APIManager
extension APIManager {
    func JSONTaskWithRequest(request: URLRequest, completionHandler: @escaping (JSONCompletionHandler)) -> JSONTask {
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let HTTPResponse = response as? HTTPURLResponse else {
                let userInfo = [
                    NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")
                ]
                let error = NSError(domain: NetworkingErrorDomain, code: MissingHTTPResponseError, userInfo: userInfo)
                completionHandler(nil, nil, error)
                return
            }
            if data == nil {
                if let error = error {
                    completionHandler(nil, HTTPResponse, error)
                }
            } else {
                switch HTTPResponse.statusCode {
                case 200:
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
                        completionHandler(json, HTTPResponse, nil)
                    } catch let error as NSError {
                        completionHandler(nil, HTTPResponse, error)
                    }
                default:
                    print("We have got response status \(HTTPResponse)")
                }
            }
        }
        return dataTask
    }
    
    
    func fetch<T>(request: URLRequest, parse: @escaping ([String:AnyObject]) -> T?, completionHandler: @escaping (APIResult<T>) -> Void) {
        let dataTask = JSONTaskWithRequest(request: request) { (json, response, error) in
            guard let json = json else {
                if let error = error {
                    completionHandler(.Failure(error))
                }
                return
            }
            if let value = parse(json) {
                completionHandler(.Success(value))
            } else {
                let error = NSError(domain: NetworkingErrorDomain, code: UnexpectedResponse, userInfo: nil)
                completionHandler(.Failure(error))
            }
        }
        dataTask.resume()
    }
    
}
