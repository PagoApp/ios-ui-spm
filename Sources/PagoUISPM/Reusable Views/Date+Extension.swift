//
//  Date+Extension.swift
//  Pago
//
//  Created by Gabi Chiosa on 23.02.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation
//import PagoApiClient

public extension Date {
    
    #warning("Should fix this")
    //TODO: Fix this
//    static var locale: String { return CountryManager.shared.languageCode?.iso ?? "ro_RO"}
    static var locale: String { return "ro_RO" }
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
    enum PagoDateFormat {
        case shortDate
        case normal
        case shorterDate
        case shortDateWithYear, dateWithYear
        case dayWithMonth
        case hour24Format
        
        var string : String {
            switch self {
            case .dayWithMonth:
                return "d MMMM"
            case .hour24Format:
                return "HH:mm"
            case .dateWithYear:
                return "dd MM YYYY"
            case .shortDateWithYear:
                return "dd MMM YYYY"
            case .shortDate:
                return "dd MMM"
            case .normal:
                return "dd MMMM"
            case .shorterDate:
                return "d MMM"
            }
        }
    }
    
    var weekdayName: String {
        let calendar = Calendar.current

        guard let weekdayNumber = calendar.dateComponents(Set([.weekday]), from: self).weekday else { return "" }
        let dayIndex = ((weekdayNumber - 1) + (calendar.firstWeekday - 1)) % 7
        return calendar.weekdaySymbols[dayIndex]
    }
    
    func toString(format: PagoDateFormat, locale: String? = Date.locale) -> String {
        return toString(format: format.string, locale: locale)
    }
    
    func toString(format: String, locale: String? = nil) -> String {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let locale = locale {
            dateFormatter.locale = Locale(identifier: locale)
        }
        return dateFormatter.string(from: self)
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
