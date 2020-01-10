//
//  DetailViewPresenter.swift
//  MVP Test Project
//
//  Created by Johnnie Walker on 10.01.2020.
//  Copyright © 2020 Johnnie Walker. All rights reserved.
//

import Foundation

protocol DetailViewProtocol: class{
    func setUser(user: User?)
}

protocol DetailViewPresenterProtocol: class {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, user: User?)
    func setUser()
}

class DetailPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol!
    var user: User?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, user: User?) {
        self.view = view
        self.networkService = networkService
        self.user = user
    }
    
    func setUser() {
        self.view?.setUser(user: user)
    }
    
    
}
