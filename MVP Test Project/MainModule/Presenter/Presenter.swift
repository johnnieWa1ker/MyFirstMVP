//
//  Presentor.swift
//  MVP Test Project
//
//  Created by Johnnie Walker on 25.12.2019.
//  Copyright © 2019 Johnnie Walker. All rights reserved.
//

import Foundation

/// Этому протоколу должен соответствовать экземпляр view
/// При  программировании логики следует  предусмотреть  все  методы, обрабатываемые в связанной view
protocol MainViewProtocol: class {
    
    // Эти методы будут вызваны во view
    // TODO: QUESTION
    // как именно происходит инжектирование данных из презентера?
    func success()
    func failure(error: Error)
}

// Протокол презентера указывает с каким view и networkService следует работать презентеру
protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, networkservise: NetworkServiceProtocol)
    
    func getUsers()
    var users: [User]? { get set }
}

class Presenter: MainViewPresenterProtocol {
    
    // Презентер формирует сильную ссылку на view. Что бы избежать утечек памяти, следует сделать слабую ссылку на view
    weak var view: MainViewProtocol?
    var users: [User]?
    let networkservise: NetworkServiceProtocol!
    
    required init(view: MainViewProtocol, networkservise: NetworkServiceProtocol) {
        self.view = view
        self.networkservise = networkservise
        getUsers()
    }
    
    func getUsers() {
        
        // Презентер обращается к сервисному слою, что бы тот "дернул" метод getUser и вернул данные
        networkservise.getUser { [weak self] result in
            guard let self = self else { return }
            
            // Работа с сетью должна происходить асинхронно
            DispatchQueue.main.async {
                
                // В зависимости от результата 
                switch result {
                case .success(let users):
                    self.users = users
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}
