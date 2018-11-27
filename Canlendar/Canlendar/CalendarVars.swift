//
//  CalendarVars.swift
//  Canlendar
//
//  Created by Ruicheng Peng on 11/27/18.
//  Copyright © 2018 Ruicheng Peng. All rights reserved.
//

import Foundation

let date = Date()
let calendar = Calendar.current

let day = calendar.component(.day, from: date)
let weekday = calendar.component(.weekday, from: date)
var month = calendar.component(.month, from: date) - 1
var year = calendar.component(.year, from: date)
