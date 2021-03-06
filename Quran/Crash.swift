//
//  Crash.swift
//  Quran
//
//  Created by Mohamed Afifi on 6/10/16.
//  Copyright © 2016 Quran.com. All rights reserved.
//

import Foundation
import Crashlytics

class CrashlyticsKeyBase {
    static let QariId = CrashlyticsKey<Int>(key: "QariId")
    static let QuranPage = CrashlyticsKey<Int>(key: "QuranPage")
    static let PlayingAyah = CrashlyticsKey<AyahNumber>(key: "PlayingAyah")
    static let DownloadingQuran = CrashlyticsKey<Bool>(key: "DownloadingQuran")
}

final class CrashlyticsKey<Type>: CrashlyticsKeyBase {
    let key: String

    private init(key: String) {
        self.key = key
    }
}

struct Crash {

    static func setValue<T>(value: T?, forKey key: CrashlyticsKey<T>) {

        let instance = Crashlytics.sharedInstance()

        guard let value = value else {
            instance.setObjectValue(nil, forKey: key.key)
            return
        }

        if let value = value as? Int32 {
            instance.setIntValue(value, forKey: key.key)
        } else if let value = value as? Int {
            instance.setIntValue(Int32(value), forKey: key.key)
        } else if let value = value as? Float {
            instance.setFloatValue(value, forKey: key.key)
        } else if let value = value as? Bool {
            instance.setBoolValue(value, forKey: key.key)
        } else if let value = value as? CustomStringConvertible {
            instance.setObjectValue(value.description, forKey: key.key)
        } else if let value = value as? AnyObject {
            instance.setObjectValue(value.description, forKey: key.key)
        } else {
            fatalError("Unsupported value type: \(value)")
        }
    }

    static func recordError(error: ErrorType) {
        Crashlytics.sharedInstance().recordError(error as NSError)
    }
}


func CLog(string: String) {
    CLSLogv("%@", getVaList([string]))
}

@noreturn public func fatalError(@autoclosure message: () -> String = "", file: StaticString = #file, line: UInt = #line) {
    CLog("message: \(message()), file:\(file.description), line:\(line)")
    Swift.fatalError(message, file: file, line: line)
}
