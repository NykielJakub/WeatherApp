//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import UIKit

extension SearchCityViewController {
    
    final class ContentView: UIView {
        
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
        }
        
        private func setupLayout() {}
    }
}
