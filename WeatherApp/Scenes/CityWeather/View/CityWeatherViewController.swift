//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import Combine
import UIKit

final class CityWeatherViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = ContentView()
    private let viewModel: CityWeatherViewModel
    
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Initializers
    
    init(viewModel: CityWeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bindViewModelWithView()
        
        viewModel.fetchData()
    }
    
    // MARK: - Private
    
    private func bindViewModelWithView() {
        viewModel.cityWeather
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] weather in self?.contentView.set(weather) })
            .store(in: &subscriptions)
    }
}
