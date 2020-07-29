//
//  Utils.swift
//  UIKit SwiftUI
//
//  Created by Mateus Kamoei on 22/07/20.
//  Copyright © 2020 Kobe. All rights reserved.
//

import Foundation

class Utils {
    
    static func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}
