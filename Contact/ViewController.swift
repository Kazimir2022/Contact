//
//  ViewController.swift
//  Contact
//
//  Created by Kazimir on 17.03.23.
//

import UIKit

class ViewController: UIViewController {
    var storage: ContactStorageProtocol!
    private var contacts = [ContactProtocol](){// массив экземпляров
        didSet {
            contacts.sort{ $0.title < $1.title }
            // сохранение контактов в хранилище
            storage.save(contacts: contacts)
         
        }
    }


    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storage = ContactStorage()
        loadContacts()
    }
    private func loadContacts() {
        contacts = storage.load() // загрузка контактов из хранилища
        
    }
    
    @IBAction func showNewContactAlert() {
        
        // создание Alert Controller
              let alertController = UIAlertController(title: "Создайте новый контакт", message: "Введите имя и телефон", preferredStyle: .alert)
        
      
       
              // добавляем первое текстовое поле в Alert Controller
              alertController.addTextField(){ textfield in
                  textfield.placeholder = "Имя"
              }
    
              // добавляем второе текстовое поле в Alert Controller
              alertController.addTextField(){ textfield in
                  textfield.placeholder = "Номер телефона"
              }
          // создаем кнопки
              // кнопка создания контакта
              let createButton = UIAlertAction(title: "Создать", style: .default, handler: { _ in
                  guard let contactName = alertController.textFields?[0].text,
                        let contactPhone = alertController.textFields?[1].text else {
                      return // если не получилось -  выходим из метода
                  }
                  
                  // создаем новый контакт(если значения текстовых полей получены)
                  let contact = Contact(title: contactName, phone: contactPhone)
                  self.contacts.append(contact)
                  self.tableView.reloadData()// заново формируем табличное представление
              })
              
              // кнопка отмены
              let cancelButton = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
              
              // добавляем кнопки в Alert Controller
              alertController.addAction(cancelButton)
              alertController.addAction(createButton)
              
              // отображаем Alert Controller
              self.present(alertController, animated: true, completion: nil)
          }
      
}
  






extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
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
        // имя контакта
        configuration.text = contacts[indexPath.row].title
        // номер телефона контакта
        configuration.secondaryText = contacts[indexPath.row].phone
        cell.contentConfiguration = configuration
    }
}
extension ViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       let actionDelete = UIContextualAction(style: .destructive, title: "Удалить")
        { _,_,_ in
           // удаляем контакт
           self.contacts.remove(at: indexPath.row)
           // заново формируем табличное представление
           tableView.reloadData()
            
        }
        // формируем экземпляр, описывающий доступные действия
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
        
}
