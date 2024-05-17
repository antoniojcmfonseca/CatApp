//
//  UIDevice+CatApp.swift
//  CatApp
//
//  Created by António Fonseca on 17/05/2024.
//

import Foundation
import UIKit

extension UIDevice {
    
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
