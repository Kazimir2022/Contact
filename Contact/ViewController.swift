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
        var cell:UITableViewCell
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") {
            print("используем старую ячейку для строки с индексом \(indexPath.row)")
            cell = reuseCell
            
        } else {
            
            print("Создаем новую ячейку для строки с индексом \(indexPath.row)")
            cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        }
           
        configure(cell: &cell, for: indexPath)
        return cell
        
    }
   
}
extension ViewController{
    private func configure(cell: inout UITableViewCell, for indexPath:IndexPath){
        var configuration = cell.defaultContentConfiguration()
        configuration.text = "строка \(indexPath.row)"
        cell.contentConfiguration = configuration
    }
}
