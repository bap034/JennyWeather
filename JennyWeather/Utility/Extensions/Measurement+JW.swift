//
//  Measurement+JW.swift
//  JennyWeather
//
//  Created by Brett Petersen on 4/25/23.
//  Copyright © 2023 Brett Petersen. All rights reserved.
//

import Foundation

extension Measurement {
    static var defaultFormatter: MeasurementFormatter {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .medium
        formatter.numberFormatter.maximumFractionDigits = 0
        formatter.locale = Locale.current
        return formatter
    }
}
