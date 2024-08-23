//
//  Repository.swift
//  weather-forecast-1
//
//  Created by Andre Silva on 22/08/24.
//

import Foundation

class Repository {
    func getCity() -> City {
        return City(
            name: "Aparecida de Goiânia",
            lat: "-16.8230691",
            lon: "-49.2687242"
        )
    }
}
