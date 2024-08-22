//
//  Extensions.swift
//  weather-forecast-1
//
//  Created by Andre Silva on 20/08/24.
//

import Foundation
import UIKit

extension UIColor {
    static let appPrimaryColor = UIColor(named: "appPrimaryColor")
    static let softGrey = UIColor(named: "softGray")
}

extension UIImage {
    static let backgroundImage = UIImage(named: "background")
    static let sunICon2 = UIImage(named: "sunIcon2")    
    static let sunICon = UIImage(named: "sunIcon")
}

extension UIView {
    func setConstraintsToParent(_ parent: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: parent.topAnchor),
            self.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            
        ])
    }
}
