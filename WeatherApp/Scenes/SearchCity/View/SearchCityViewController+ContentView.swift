//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import UIKit

extension SearchCityViewController {
    
    final class ContentView: UIView {
        
        // MARK: - Properties
        
        private let titleLabel = UILabel()
        
        // MARK: - Initializers
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupComponents()
            setupLayout()
        }
        
        required init?(coder: NSCoder) { nil }
        
        // MARK: - Methods
        
        private func setupComponents() {
            backgroundColor = .white
            titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
            titleLabel.text = "recent_searches".localized
            titleLabel.textColor = .black
        }
        
        private func setupLayout() {
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(titleLabel)
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
                titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            ])
        }
    }
}
