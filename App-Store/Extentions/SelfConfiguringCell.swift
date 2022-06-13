//
//  SelfConfiguringCell.swift
//  App-Store
//
//  Created by Omar Ahmed on 13/06/2022.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseIdentifier : String {get}
    func configure(with app: App)
}
