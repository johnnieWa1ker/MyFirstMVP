//
//  ModuleBuilder.swift
//  MVP Test Project
//
//  Created by Johnnie Walker on 27.12.2019.
//  Copyright © 2019 Johnnie Walker. All rights reserved.
//

import UIKit

// Пока не понимаю необходимость применения протокола тут
protocol Builder {
    static func createModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createModule() -> UIViewController {
        
        // Берем экземпляр сетевого слоя, который будет подготавливать данные для view
        let networkService = NetworkService()
        
        // Берем view которая будет "собираться"
        let view = MainViewController()
        
        // Берем презентер который будет отвечать за логику во view
        let presenter = Presenter(view: view, networkservise: networkService)
        
        // Связываем view и презентер
        view.presenter = presenter
        
        // Результат - готовая для отрисовки view
        return view
    }
}

