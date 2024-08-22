//
//  API.swift
//  weather-forecast-1
//
//  Created by Andre Silva on 20/08/24.
//

import Foundation
import UIKit

struct City {
    let name: String
    let lat: String
    let lon: String
}


class Service {
    private let baseURL: String = "https://api.openweathermap.org/data/3.0/onecall"    
    private let session: URLSession = URLSession.shared

    func fecthData(city: City, _ completion: @escaping (ForecastResponse?) -> Void) {
        let url = "\(baseURL)?lat=\(city.lat)&lon=\(city.lon)&appid=\(apiKey)"
        
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
            
            completion(nil)
            
        }
        
        task.resume()
            
    }
}

func cityName() -> String {
    return "Aparecida de Goiânia"
}

func temperatureValue() -> String {
    let currentHour = Calendar.current.component(.hour, from: Date())
    return "\(currentHour)ºC"
}

func weatherImage() -> UIImage {
    let currentHour = Calendar.current.component(.hour, from: Date())
    
    if(currentHour >= 18) {
        return UIImage.moonIcon
    } else {
        return UIImage.sunICon!
    }
}
