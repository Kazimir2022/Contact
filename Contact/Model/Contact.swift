//
//  Contact.swift
//  Contact
//
//  Created by Kazimir on 18.03.23.
//

import Foundation
protocol ContactProtocol {
    /// Имя
    var title: String { get set }
    /// Номер телефона
    var phone: String { get set }
    
}

struct Contact: ContactProtocol {
    var title: String
    var phone: String
    
}
protocol ContactStorageProtocol {
    // Загрузка списка контактов
    func load() -> [ContactProtocol]
    // Обновление списка контактов
    func save(contacts: [ContactProtocol])
    
}

class ContactStorage: ContactStorageProtocol  {
        // Ссылка на хранилище
        private var storage = UserDefaults.standard
    // Ключ, по которому будет происходить сохранение хранилища
    private var storageKey = "contacts"
    
    // Перечисление с ключами для записи в User Defaults
    private enum ContactKey: String {
        case title
        case phone    }
    
    func load() -> [ContactProtocol] {
        var resultContacts: [ContactProtocol] = []//
        // получаем значение типа [[String:String]] т.к. в массиве хранится [[Any:Any]]
        let contactsFromStorage = storage.array(forKey: storageKey) as? [[String:String]] ?? []
        
       /// преобразуется к массиву контактов [Contacts]
    
        
        for contact in contactsFromStorage {//[string:string]
            guard let title = contact[ContactKey.title.rawValue],// получаем значения каждого словаря
                    let phone = contact[ContactKey.phone.rawValue] else {
                continue// иначе пропускаем итерацию
            }
            
            resultContacts.append(Contact(title: title, phone: phone))//добаляем значенения во вновь созданный массив контактов
            
        }
        return resultContacts // возвращаем 
        }
    
    func save(contacts: [ContactProtocol]) {// получаем массив экземпляров из вьюконтроллера
            var arrayForStorage: [[String:String]] = []//пустой массив  словарей
        contacts.forEach { contact in // перебираем каждый элемент полученного массива
            var newElementForStorage: Dictionary<String,String> = [:]// и создаем столько же  пустых словарей
            newElementForStorage[ContactKey.title.rawValue] = contact.title // этому пустому словарю задаем ключ в виде строки из перечисления, и присваиваем значение в виде строки из нашего экземпляра обекта который прилетел из вьюконтролера
                newElementForStorage[ContactKey.phone.rawValue] = contact.phone
            arrayForStorage.append(newElementForStorage)// и каждый словарь добавляем в массив словарей
            }
        storage.set(arrayForStorage, forKey: storageKey) // записываем наш массив словарей в UserDefaults.standard
        }
    }
