//
//  Constants.swift
//  SwiftNewsCrawler
//
//  Created by Rubaiyat Jahan Mumu on 2020-02-06.
//  Copyright © 2020 Rubaiyat Jahan Mumu. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    static let idealHeight: CGFloat = 667.0
    static let idealWidth: CGFloat = 375.0
    static let heightConstant: CGFloat = {
        UIScreen.main.bounds.height / Constants.idealHeight
    }()

    static let widthConstant: CGFloat = {
        UIScreen.main.bounds.width / Constants.idealWidth
    }()
}

class HeightConstraint: NSLayoutConstraint {
    override var constant: CGFloat {
        set {
            super.constant = newValue
        }
        get {
            return super.constant * Constants.heightConstant
        }
    }
}

class WidthConstraint: NSLayoutConstraint {
    override var constant: CGFloat {
        set {
            super.constant = newValue
        }
        get {
            return super.constant * Constants.widthConstant
        }
    }
}
