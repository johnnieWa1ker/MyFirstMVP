//
//  ModuleBuilder.swift
//  MVP Test Project
//
//  Created by Johnnie Walker on 27.12.2019.
//  Copyright © 2019 Johnnie Walker. All rights reserved.
//

import UIKit

// MARK: Пока не понимаю необходимость применения протокола тут
protocol Builder {
    static func createMainModule() -> UIViewController
    
    static func createDetailModule(user: User) -> UIViewController
}

class ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let networkService = NetworkService() // Берем экземпляр сетевого слоя, который будет подготавливать данные для view
        let view = MainViewController() // Берем view которая будет "собираться"
        let presenter = MainPresenter(view: view, networkService: networkService) // Создаем презентер который будет отвечать за логику во view
        view.presenter = presenter // Связываем созданный презентер, и говорим, что он является управляющим для этой view
        return view // Результат - готовая для отрисовки view
    }
    
    static func createDetailModule(user: User) -> UIViewController {
        let networkService = NetworkService()
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, networkService: networkService, user: user)
        view.presenter = presenter
        return view
    }
}

