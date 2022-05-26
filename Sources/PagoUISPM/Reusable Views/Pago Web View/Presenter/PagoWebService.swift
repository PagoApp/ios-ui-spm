//
//  PagoWebService.swift
//  Pago
//
//  Created by Gabi Chiosa on 19.10.2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//

import WebKit

open class PagoWebService: Service {

    public func cleanCache() {
        
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
}
