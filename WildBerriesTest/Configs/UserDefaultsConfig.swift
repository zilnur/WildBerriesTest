//
//  UserDefaultsConfig.swift
//  WildBerriesTest
//
//  Created by Ильнур Закиров on 02.06.2022.
//

import Foundation

extension UserDefaults {
    
    func contains(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
