//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import UIKit

extension CityWeatherViewController {
    
    final class ContentView: UIView {
        
        // MARK: - Properties
        
        private let temperatureLabel = TemperatureLabel()
        private let cityLabel = UILabel()
        private let conditionsLabel = UILabel()
        private let sunriseLabel = UILabel()
        private let sunriseHourLabel = UILabel()
        private let sunsetLabel = UILabel()
        private let sunsetHourLabel = UILabel()
        private let alertView = UIView()
        private let alertLabel = UILabel()
        private let spacer = UIView()
        
        // MARK: - Initializers
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupComponents()
            setupLayout()
        }
        
        required init?(coder: NSCoder) { nil }
        
        // MARK: - API
        
        func set(_ weather: CityWeather) {
            let temperature = Int(weather.temperature.rounded())
            temperatureLabel.set(temperature: weather.temperature)
            cityLabel.text = weather.cityName
            conditionsLabel.text = weather.conditions
            
            sunriseLabel.text = "sunrise".localized
            sunriseHourLabel.text = weather.sunrise
            
            sunsetLabel.text = "sunset".localized
            sunsetHourLabel.text = weather.sunset
            
            if let alert = weather.alerts.first {
                alertLabel.text = "\(alert.sender)\n\n\(alert.event)\n\n\(alert.conditions)"
                alertView.isHidden = false
            }
        }
        
        // MARK: - Methods
        
        private func setupComponents() {
            backgroundColor = .white
            
            temperatureLabel.font = .systemFont(ofSize: 40, weight: .bold)
            cityLabel.font = .systemFont(ofSize: 28, weight: .semibold)
            conditionsLabel.font = .systemFont(ofSize: 24, weight: .regular)
            sunriseLabel.font = .systemFont(ofSize: 16, weight: .regular)
            sunriseHourLabel.font = .systemFont(ofSize: 14, weight: .regular)
            sunsetLabel.font = .systemFont(ofSize: 16, weight: .regular)
            sunsetHourLabel.font = .systemFont(ofSize: 14, weight: .regular)
            
            alertView.layer.cornerRadius = 10
            alertView.backgroundColor = .red.withAlphaComponent(0.3)
            alertView.isHidden = true
            
            alertLabel.textColor = .red
            alertLabel.numberOfLines = 0
            alertLabel.font = .systemFont(ofSize: 12, weight: .regular)
        }
        
        private func setupLayout() {
            let stackView = UIStackView(arrangedSubviews: [temperatureLabel, cityLabel, conditionsLabel])
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.distribution = .fill
            stackView.spacing = 8
            
            addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ])
            
            let sunriseContainer = UIStackView(arrangedSubviews: [sunriseLabel, sunriseHourLabel])
            sunriseContainer.axis = .vertical
            sunriseContainer.alignment = .center
            sunriseContainer.distribution = .fill
            sunriseContainer.spacing = 4
            
            let sunsetContainer = UIStackView(arrangedSubviews: [sunsetLabel, sunsetHourLabel])
            sunsetContainer.axis = .vertical
            sunsetContainer.alignment = .center
            sunsetContainer.distribution = .fill
            sunsetContainer.spacing = 4
            
            let sunContainer = UIStackView(arrangedSubviews: [sunriseContainer, sunsetContainer])
            sunContainer.axis = .horizontal
            sunContainer.spacing = 24
            sunContainer.distribution = .fill
            
            stackView.setCustomSpacing(20, after: conditionsLabel)
            stackView.addArrangedSubview(sunContainer)
            
            stackView.setCustomSpacing(20, after: sunContainer)
            stackView.addArrangedSubview(alertView)
            
            alertLabel.translatesAutoresizingMaskIntoConstraints = false
            alertView.translatesAutoresizingMaskIntoConstraints = false
            alertView.addSubview(alertLabel)
            NSLayoutConstraint.activate([
                alertView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.8),
                alertLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 8),
                alertLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 8),
                alertLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -8),
                alertLabel.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -8)
            ])
            
            spacer.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
            spacer.setContentHuggingPriority(.defaultLow, for: .vertical)
            stackView.addArrangedSubview(spacer)
        }
    }
}
