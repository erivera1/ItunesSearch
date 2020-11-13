//
//  DateExtension.swift
//  Spectra
//
//  Created by Eliric Rivera on 22/01/2019.
//  Copyright © 2019 Eliric Rivera. All rights reserved.
//

import Foundation

private let mongoDateFormatter = DateFormatter(format: "yyyy-MM-dd HH:mm:ss +zzzz")//"yyyy-MM-dd'T'HH:mm:ss.SSSZ")

extension Date {
    
    static func mongoDate(_ string: String) -> Date? {
        print(string)
        mongoDateFormatter.locale = Locale.current
        return mongoDateFormatter.date(from: string)
    }
    
    func intervalString(since date: Date?) -> String? {
        let now = NSLocalizedString("now", comment: "")
        let sMinute = NSLocalizedString("minute ago", comment: "")
        let sMinutes = NSLocalizedString("minutes ago", comment: "")
        let sHour = NSLocalizedString("hour ago", comment: "")
        let sHours = NSLocalizedString("hours ago", comment: "")
        let sDay = NSLocalizedString("day ago", comment: "")
        let sDays = NSLocalizedString("days ago", comment: "")
        let sLongTime = NSLocalizedString("long", comment: "")
        guard let date = date else { return nil }
        let interval = timeIntervalSince(date)
        let minute: TimeInterval = 60
        let hour: TimeInterval = minute * 60
        let day: TimeInterval = hour * 24
        if interval < 1 {
            return now
        }else if(Int(interval/minute) < 2){
            return "1 \(sMinute)"
        }else if interval > 1 && interval < (minute * 2) {
            return "\(Int(interval/minute)) \(sMinute)"
        } else if interval < hour {
            return "\(Int(interval/minute)) \(sMinutes)"
        } else if interval < (hour * 2) {
            return "\(Int(interval/hour)) \(sHour)"
        } else if interval < day {
            return "\(Int(interval/hour)) \(sHours)"
        } else if interval < (day * 2) {
            return "\(Int(interval/day)) \(sDay)"
        } else if interval > (day * 2) && interval < (day * 31){
            return "\(Int(interval/day)) \(sDays)"
        }else {
            return sLongTime
        }
    }
    //FIRE IN MINUTES
    func addedBy(minutes:Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
    
}

public extension DateFormatter {
    
    convenience init(format: String) {
        self.init()
        dateFormat = format
    }
    
    convenience init(dateStyle: Style = .none, timeStyle: Style = .none) {
        self.init()
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
    }
    
}
