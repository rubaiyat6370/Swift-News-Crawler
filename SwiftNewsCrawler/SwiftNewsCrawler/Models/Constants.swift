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
    //iPhone 8
    static let idealHeightIphone: CGFloat = 667.0
    static let idealWidthIphone: CGFloat = 375.0

    //iPad Pro 11-inch
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

/*

For example,  if I set 50 as height of a view, for iPhone 8, it is 50, for iPhone Pro Max, the height is 50 * HeightConstant = 50 * (Height of iPhone Pro Max / Height of iPhone8) = 67.17.

 */
