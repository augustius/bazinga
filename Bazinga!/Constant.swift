//
//  Constant.swift
//  Bazinga!
//
//  Created by augustius cokroe on 12/10/2017.
//  Copyright © 2017 augustius cokroe. All rights reserved.
//

import UIKit
import Foundation

let userDefaults = UserDefaults.standard
let application = UIApplication.shared
let notification = NotificationCenter.default
let appDelegate: AppDelegate? = application.delegate as? AppDelegate
let currentTimestamp: Double = NSDate().timeIntervalSince1970
