//
//  Extension.swift
//  AR_ Magic
//
//  Created by Imke Beekmans on 23/04/2018.
//  Copyright © 2018 Imke Beekmans. All rights reserved.
//  Code from the videos of the Rebeloper

import UIKit

enum UIUserInterfaceIdiom: Int {
    case undefined
    case phone
    case pad
}

struct ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.width
    static let maxLength = max(ScreenSize.width, ScreenSize.height)
    static let minLength = min(ScreenSize.width, ScreenSize.height)
}

struct DeviceType {
    static let isiPhone4OrLess = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength < 568.0
    static let isiPhone5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength < 568.0
    static let isiPhone6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength < 667.0
    static let isiPhone6Plus =  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength < 736.0
    static let isiPhoneX = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength < 568.0
    static let isiPad = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength < 568.0
    static let isiPadPro = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength < 568.0
}
