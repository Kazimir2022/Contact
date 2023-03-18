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
