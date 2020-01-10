//
//  MainViewController.swift
//  MVP Test Project
//
//  Created by Johnnie Walker on 27.12.2019.
//  Copyright © 2019 Johnnie Walker. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: Presenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let user = presenter.users?[indexPath.row]
        cell.textLabel?.text  = user?.name
        return cell
    }
    
    
}

// Так как презентер требует конкретный тип объекта себе "на вход", то что бы связаться с этим view, нужно, что бы view соответствовала этому типу. Реализация возможна как через использование расширений, так и при объявлении класса
extension MainViewController: MainViewProtocol {

    // Функции из MainViewProtocol предназначены как бы для вывода данных во view
    func success() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
