//
//  ViewController.swift
//  Contact
//
//  Created by Kazimir on 17.03.23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
  
extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // получаем экземляр ячейки
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)// инициализатор который возвращает ячейку на основе предустановленного стиля
        // конфигурируем ячейку
        var configuration = cell.defaultContentConfiguration()// создаем ячейку без данных
        configuration.text = "Строка \(indexPath.row)"//наполняем ее данными
        cell.contentConfiguration = configuration // наполненная конфигурация передается ячейке
        // возвращаем сконфигурированный экземпляр ячейки
        return cell
    }
}
