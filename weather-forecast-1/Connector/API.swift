//
//  API.swift
//  weather-forecast-1
//
//  Created by Andre Silva on 20/08/24.
//

import Foundation
import UIKit

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
