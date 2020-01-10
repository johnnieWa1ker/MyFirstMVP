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
    

    // Объявляем презентер, который будет инжектирован извне - из ModuleBulder
    var presenter: MainPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Регистриуем таблицу при загрузке view. Далее в идентификатор с этим же именем будет загружаться соответствующая информация
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

// View должна соответствовать протоколу UITableViewDataSource, для того, что бы была возможность работы с компоненом "таблица"
extension MainViewController: UITableViewDataSource {
    
    // Функция определяет количество ячеек, которые должна содержать таблица
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.users?.count ?? 0 // Количество ячеет равно количеству записей, полученных из сети
    }
    
    // Определяем содержимое ячеек
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let user = presenter.users?[indexPath.row]
        cell.textLabel?.text  = user?.name // Отображаю только имена пользователей
        return cell
    }
}

//
// MARK: Как работать с делегатами, если на странице несколько таблиц?
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = presenter.users?[indexPath.row]
        let detailViewController = ModuleBuilder.createDetailModule(user: user!)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// "Учим" view работать через презентер
extension MainViewController: MainViewProtocol {

    // При срабатывании функции в презентере, описываем, что требуется сделать во view
    func success() {
        tableView.reloadData()
    }
    
    // При срабатывании функции в презентере, описываем, что требуется сделать во view
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
