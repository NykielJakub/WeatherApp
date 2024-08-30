//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import UIKit

final class TemperatureLabel: UILabel {

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel()
    }
    
    // MARK: - API
    
    func set(temperature: Double) {
        updateColor(for: temperature)
        text = "\(temperature)°C"
    }

    // MARK: - Setup

    private func setupLabel() {
        self.font = .systemFont(ofSize: 16) // Domyślny rozmiar czcionki
        self.textAlignment = .center
    }

    // MARK: - Private

    private func updateColor(for temperature: Double) {
        let color: UIColor
        switch temperature {
        case let temp where temp < 10:
            color = .blue
        case 10...20:
            color = .black
        default:
            color = .red
        }
        self.textColor = color
    }
}
