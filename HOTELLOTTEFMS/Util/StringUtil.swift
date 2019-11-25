//
//  StringUtil.swift
//  HOTELLOTTEFMS
//
//  Created by ldcc on 2019/11/25.
//  Copyright © 2019 ldcc. All rights reserved.
//

import Foundation

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String{
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}
