//
//  KeyChainManager.swift
//  QuotesApp


import Foundation
import Security

final class KeyChainManager {
    static let shared = KeyChainManager()
    
    private let keyChainKey = "gordeeva.QuotesApp"
    
    private init() {}
    
    func saveEncryptionKey(_ key: Data) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keyChainKey,
            kSecValueData as String: key
        ]
        
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    func loadEncryptionKey() -> Data? {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keyChainKey,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Data {
            return data
        } else {
            return nil
        }
    }
}
