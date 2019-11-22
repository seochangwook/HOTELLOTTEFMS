//
//  QRReadingProtocol.swift
//  HOTELLOTTEFMS
//
//  Created by ldcc on 2019/11/22.
//  Copyright © 2019 ldcc. All rights reserved.
//

import Foundation

public protocol QRReadingDelegate : class{
    func qrReadingReturnValue(data : String)
}
