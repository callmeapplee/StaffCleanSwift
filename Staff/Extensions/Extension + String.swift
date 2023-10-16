//
//  String.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 08/10/23.
//

import Foundation
import UIKit
extension String {
    func localized() -> String {
        NSLocalizedString(self, tableName: "Localizable", bundle: .main,value: self, comment: self)
    }
}
