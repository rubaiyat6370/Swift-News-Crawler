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
    static let idealHeightIphone: CGFloat = 667.0
    static let idealWidthIphone: CGFloat = 375.0
    static let idealHeightIpad: CGFloat = 1194.0
    static let idealWidthIpad: CGFloat = 834.0

    static let heightConstant: CGFloat = {
        if AppUtils.deviceType == "iPhone" {
            return AppUtils.deviceHeight / Constants.idealHeightIphone
        } else {
            return AppUtils.deviceHeight / Constants.idealHeightIpad
        }
    }()

    static let widthConstant: CGFloat = {
        if AppUtils.deviceType == "iPhone" {
            return AppUtils.deviceWidth / Constants.idealWidthIphone
        } else {
            return AppUtils.deviceWidth / Constants.idealWidthIpad
        }
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
