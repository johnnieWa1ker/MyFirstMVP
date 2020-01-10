//
//  DetailViewController.swift
//  MVP Test Project
//
//  Created by Johnnie Walker on 10.01.2020.
//  Copyright © 2020 Johnnie Walker. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var userDetailLabel: UILabel!
    
    // Объявляем презентер, который будет инжектирован извне - из ModuleBulder
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // При загрузке view, данные уже должны быть на экране
        presenter.setUser()
    }
}

extension DetailViewController: DetailViewProtocol {
    func setUser(user: User?) {
        self.userDetailLabel.text = user?.name
    }
}
