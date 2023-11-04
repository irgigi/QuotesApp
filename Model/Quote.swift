//
//  Quote.swift
//  QuotesApp

import Foundation
import RealmSwift

class Quote: Object {
    @Persisted var quote = ""
    @Persisted var category: String = "no category"
    @Persisted var date = Date()
    
    convenience init(quote: String, category: String) {
        self.init()
        self.quote = quote
        self.category = category
    }
}

