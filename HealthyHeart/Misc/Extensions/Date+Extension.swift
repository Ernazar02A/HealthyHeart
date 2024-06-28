//
//  Date+Extension.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import UIKit

extension Date {
    
    enum Format: String {
        case shortDate
        case dottedShortDate
        case dashedDate
        case slashedDate
        case hourAndMinuteTime
        case fullTime
        case fullDate
        case fullDateAndTime
        case fullDottedDateAndTime
        case dottedFullDate
        case fullDateFormatted
        case fullDateWithSeconds
        
        var string: String {
            switch self {
            case .shortDate:
                return "d MMMM"
            case .dottedShortDate:
                return "dd.MM.yy"
            case .dashedDate:
                return "yyyy-MM-dd"
            case .slashedDate:
                return "dd/MM/yy"
            case .hourAndMinuteTime:
                return "HH:mm"
            case .fullTime:
                return "HH:mm:ss"
            case .fullDate:
                return "dd MMMM yyyy"
            case .fullDateAndTime:
                return "dd MMMM yyyy, HH:mm"
            case .fullDottedDateAndTime:
                return "dd.MM.yyyy HH:mm:ss"
            case .dottedFullDate:
                return "dd.MM.yyyy"
            case .fullDateFormatted:
                return "yyyy-MM-dd'T'HH:mm:ss"
            case .fullDateWithSeconds:
                return "yyyy-MM-dd'T'HH:mm:ss.SSS"
            }
        }
    }
    
    private static let dateFormatter = DateFormatter()
    
    private var userDefaultsService: IUserDefaultsService {
        return Dependency.resolve(IUserDefaultsService.self)
    }
    
    private var locale: Locale {
        //guard let language = userDefaultsService.getValue(for: .language) else { return Locale.current }
        //let identifier = (language == .english ? .russian : language).localizableKey
        //return Locale(identifier: identifier)
        return Locale(identifier: "ru_RU")
    }
   
    /// Date in `dd.MM.yy` format
    ///
    ///
    ///     let date = Date()
    ///     print(date.dottedShortDateString) /// prints 25.04.23
    ///
    ///
    var dottedShortDateString: String {
        Date.dateFormatter.dateFormat = Format.dottedShortDate.string
        Date.dateFormatter.locale = locale
        return Date.dateFormatter.string(from: self)
    }
    
    /// Date in `yyyy-MM-dd` format
    ///
    ///
    ///     let date = Date()
    ///     print(date.dashedDateString) /// prints 2023-04-25
    ///
    ///
    var dashedDateString: String {
        Date.dateFormatter.dateFormat = Format.dashedDate.string
        Date.dateFormatter.locale = locale
        return Date.dateFormatter.string(from: self)
    }
    
    /// Date in `dd/MM/yy` format
    ///
    ///
    ///     let date = Date()
    ///     print(date.slashedDateString) /// prints 25/04/23
    ///
    ///
    var slashedDateString: String {
        Date.dateFormatter.dateFormat = Format.slashedDate.string
        Date.dateFormatter.locale = locale
        return Date.dateFormatter.string(from: self)
    }
    
    /// Date in `HH:mm` format
    ///
    ///
    ///     let date = Date()
    ///     print(date.hourAndMinuteTimeString) /// prints 14:24
    ///
    ///
    var hourAndMinuteTimeString: String {
        Date.dateFormatter.dateFormat = Format.hourAndMinuteTime.string
        Date.dateFormatter.locale = locale
        return Date.dateFormatter.string(from: self)
    }
    
    /// Date in `HH:mm:ss` format
    ///
    ///
    ///     let date = Date()
    ///     print(date.fullTimeString) /// prints 14:24:12
    ///
    ///
    var fullTimeString: String {
        Date.dateFormatter.dateFormat = Format.fullTime.string
        Date.dateFormatter.locale = locale
        return Date.dateFormatter.string(from: self)
    }
    
    /// Date in `dd MMMM yyyy` format
    ///
    ///
    ///     let date = Date()
    ///     print(date.fullDateString) /// prints 25 May 2023
    ///
    ///
    var fullDateString: String {
        Date.dateFormatter.dateFormat = Format.fullDate.string
        Date.dateFormatter.locale = locale
        return Date.dateFormatter.string(from: self)
    }
    
    /// Date in `dd MMMM yyyy, HH:mm` format
    ///
    ///
    ///     let date = Date()
    ///     print(date.fullDateAndTimeString) /// prints 25 May 2023, 14:25
    ///
    ///
    var fullDateAndTimeString: String {
        Date.dateFormatter.dateFormat = Format.fullDateAndTime.string
        Date.dateFormatter.locale = locale
        return Date.dateFormatter.string(from: self)
    }
    
    /// Date in `dd.MM.yyyy HH:mm:ss` format
    ///
    ///
    ///     let date = Date()
    ///     print(date.fullDateAndTimeString) /// prints 25.05.2023 14:25:32
    ///
    ///
    var fullDottedDateAndTimeString: String {
        Date.dateFormatter.dateFormat = Format.fullDottedDateAndTime.string
        Date.dateFormatter.locale = locale
        return Date.dateFormatter.string(from: self)
    }
    
    /// Date in `dd.MM.yyyy` format
    ///
    ///
    ///     let date = Date()
    ///     print(date.dottedFullDateString) /// prints 25.04.2023
    ///
    ///
    var dottedFullDateString: String {
        Date.dateFormatter.dateFormat = Format.dottedFullDate.string
        Date.dateFormatter.locale = locale
        return Date.dateFormatter.string(from: self)
    }
    
    /// Date in `yyyy-MM-dd'T'HH:mm:ssZ` format
    ///
    ///
    ///     let date = Date()
    ///     print(date.fullDateFormattedString) /// prints 2023-05-25'T'23:12:00
    ///
    ///
    var fullDateFormattedString: String {
        Date.dateFormatter.dateFormat = Format.fullDateFormatted.string
        Date.dateFormatter.locale = locale
        return Date.dateFormatter.string(from: self)
    }
    
    var shortDateFormattedString: String {
        Date.dateFormatter.locale = locale
        Date.dateFormatter.dateFormat = Format.shortDate.string
        return Date.dateFormatter.string(from: self)
    }
    
    var fullDateWithSecondsString: String {
        Date.dateFormatter.locale = locale
        Date.dateFormatter.dateFormat = Format.fullDateWithSeconds.string
        return Date.dateFormatter.string(from: self)
    }
}

public enum DateFormat: String {
    /// Formatter digit format, e.g. `20.02.2020`.
    case ddMMyyyy = "dd.MM.yyyy"
    
    /// Formatter digit format, e.g. `20.02.2020 00:00:00`.
    case ddMMyyyyHHmmSS = "dd.MM.yyyy HH:mm:ss"
   
    case ddMMyyyy_HHmm = "dd.MM.yyyy, HH:mm"
    
    /// Formatter digit format, e.g. `20-02-2020 00:00:00`.
    case yyyy_MM_dd_HHmmSS = "yyyy-MM-dd HH:mm:ss"
    
    /// Formatter digit format, e.g. `20.02.20`.
    case ddMMyy = "dd.MM.yy"
    
    /// Formatter digit format, e.g. `20 июня, 11:20`.
    case ddMMMHHmm = "dd MMMM, HH:mm"
    
    /// Formatter digit format, e.g. `20 February 202020`.
    case d_MMMM_yyyy = "d MMMM yyyy"
    
    /// Formatter digit format, e.g. `20 February`.
    case d_MMMM = "d MMMM"
    
    /// Formatter digit format, e.g. `20 Feb.`.
    case d_MMM = "d MMM"
    
    /// Formatter digit format, e.g. `2020-02-20`.
    case YYYY_MM_DD = "yyyy-MM-dd"
    
    /// Formatter digit format, e.g. `2020-02`.
    case YYYY_MM = "yyyy-MM"
  
    /// Formatter digit format, e.g. `20:02`.
    case hh_MM = "HH:mm"
    
    /// Formatter digit format, e.g. `05 minute`.
    case mm = "mm"
    
    /// Formatter digit format, e.g. `20:02:49`.
    case hh_MM_ss = "HH:mm:ss"
    
    /// Formatter for ISO8601 format e.g. `2020-04-21T07:53:40.343Z`
    case yyyy_MM_ddTHHmmssSSSZZZZZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    
    /// Formatter digit format, e.g.  ''`20:02:49 +4:00.`
    case hh_MM_ss_Z = "HH:mm:ss Z"
    
    /// Formatter digit format, e.g.  ''`20:00 AM.`
    case h_mm_a = "h:mm a"
    
    /// Formatter digit format, e.g. `20/02/2023`.
    case ddMMyyyyBackslash = "dd/MM/yyyy"
    
    /// Formatter digit format, e.g. `20.02.2020 (00:00:00)`.
    case ddMMyyyyHHmmSSbrackets = "dd.MM.yyyy (HH:mm:ss)"
    
    case yyyyMMddTHHmmssSSS = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    
}

public extension Date {
    
    static var now: Date { return Date() }
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
    func noon(using calendar: Calendar = .current) -> Date {
        calendar.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    func day(using calendar: Calendar = .current) -> Int {
        calendar.component(.day, from: self)
    }
    
    func removeMonth(using calendar: Calendar = .current) -> Date {
        calendar.date(byAdding: DateComponents(month: -1), to: self)!
    }
    
    func add(days: Int, using calendar: Calendar = .current) -> Date {
        calendar.date(byAdding: DateComponents(day: days), to: self)!
    }
    
    func monthSymbol(using calendar: Calendar = .current) -> String {
        calendar.monthSymbols[calendar.component(.month, from: self)-1]
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    func toString(dateFormat: DateFormat = .hh_MM) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = dateFormat.rawValue
        dateFormatter.amSymbol = ""
        dateFormatter.pmSymbol = ""
        return dateFormatter.string(from: self)
    }
    
    func startOfDay(in calendar: Calendar = .current) -> Date {
        return calendar.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }

    func endOfDay(in calendar: Calendar = .current) -> Date {
        return calendar.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
    }
    
    func calculateDaysDifference(to endDate: Date?) -> Int {
        guard let endDate else { return 0 }
        let days = Calendar.current.dateComponents([.day], from: self, to: endDate).day
        return days ?? 0
    }
    
    var seconds: Int {
        return Int(self.timeIntervalSince(Date()))
    }
}

extension TimeInterval {
    func asMinutes() -> Double { return self / (60.0) }
    func asHours()   -> Double { return self / (60.0 * 60.0) }
    func asDays()    -> Double { return self / (60.0 * 60.0 * 24.0) }
    func asWeeks()   -> Double { return self / (60.0 * 60.0 * 24.0 * 7.0) }
    func asMonths()  -> Double { return self / (60.0 * 60.0 * 24.0 * 30.4369) }
    func asYears()   -> Double { return self / (60.0 * 60.0 * 24.0 * 365.2422) }
}
