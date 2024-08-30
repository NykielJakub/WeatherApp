//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import Foundation

class DtoToDomainMapper {
    
    // MARK: - Properties
    
    private var hourDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    // MARK: - Methods
    
    func city(from dto: CityDTO) -> City {
        let languageCode = Locale.current.minimalIdentifier()
        return City(name: dto.localNames?[languageCode] ?? dto.name,
                    latitude: dto.latitude,
                    longitude: dto.longitude,
                    country: dto.country)
    }
    
    func cityWeather(from dto: CityWeatherDTO, cityName: String) -> CityWeather {
        return CityWeather(cityName: cityName, 
                           sunrise: hourDateFormatter.string(from: dto.current.sunrise),
                           sunset: hourDateFormatter.string(from: dto.current.sunset),
                           temperature: dto.current.temperature,
                           conditions: dto.current.weather.first?.conditions ?? "",
                           alerts: dto.alerts?.compactMap { alert(from: $0) } ?? [])
    }
    
    func alert(from dto: AlertDTO) -> WeatherAlert {
        WeatherAlert(sender: dto.sender, event: dto.event, conditions: dto.conditions)
    }
}
