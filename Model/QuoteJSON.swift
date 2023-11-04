//
//  QuoteJSON.swift
//  QuotesApp


import Foundation

struct QuoteJSON: Decodable {
    let value: String
    let categories: [String?]
}


