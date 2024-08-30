//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import Foundation

class DtoToDomainMapper {
    
    func city(from dto: CityDTO) -> City {
        let languageCode = Locale.current.minimalIdentifier()
        return City(name: dto.localNames?[languageCode] ?? dto.name,
                    latitude: dto.latitude,
                    longitude: dto.longitude,
                    country: dto.country)
    }
}
