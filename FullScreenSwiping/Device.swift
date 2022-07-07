//
//  DeviceLayout.swift
//  1v1Me
//
//  Created by Q on 2021-08-04.
//  Copyright © 2021 1v1MeApp. All rights reserved.
//

import UIKit
import DeviceCheck

#if DEBUG
var Device = DeviceInfo() // Mutable to allow for testing.
#else
let Device = DeviceInfo()
#endif

struct DeviceInfo {
    // MARK: - Device Layout
    var screenSize: () -> CGSize = {
        UIScreen.main.bounds.size
    }
    
    var bounds: () -> CGRect = {
        UIScreen.main.bounds
    }
}
