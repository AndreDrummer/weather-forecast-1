//
//  API.swift
//  weather-forecast-1
//
//  Created by Andre Silva on 20/08/24.
//

import Foundation
import UIKit

class Service {
    private let baseURL: String = "https://api.openweathermap.org/data/3.0/onecall"
    private let session: URLSession = URLSession.shared
    
    /// Uncomment the following line and provide a valid OpenWeather API key.
    // private let apiKey: String = "<YOUR-API-KEY>"

    func fecthData(place: Place, _ completion: @escaping (ForecastResponse?) -> Void) {
        let url = "\(baseURL)?lat=\(place.latLng.lat)&lon=\(place.latLng.lng)&appid=\(apiKey)&units=metric"
        
        guard let requestURL = URL(string: url) else { return }
        
        let task = session.dataTask(with: requestURL) { data, response, error in
            
            guard let data else {
                completion(nil)
                return
            }
            
            do {
                let forecastResponse = try JSONDecoder().decode(ForecastResponse.self, from: data)
                completion(forecastResponse)
            } catch {
                print(String(data: data, encoding: .utf8) ?? "")
                completion(nil)
            }            
        }
        
        task.resume()
            
    }
}
