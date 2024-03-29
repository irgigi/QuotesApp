//
//  ToDoService.swift
//  QuotesApp


import Foundation
import RealmSwift

final class ToDoService {
    
    static let sharedConfiguration = ToDoService()
    
    private var realm: Realm?
    private var encryptionKey: Data?
    
    private init() {}
    
    //MARK:  - загрузка ключа и создание конфигурации
    
    private var realmConfiguration: Realm.Configuration {
        
        guard let key = KeyChainManager.shared.loadEncryptionKey() else {
            return Realm.Configuration()
        }
        
        return Realm.Configuration(encryptionKey: key)
    }
    
    
    //MARK:  - генерация ключа
    
    
    private func generateEncryptionKey() -> Data {
        //генерация ключа
        var keyData = Data(count: 64)
        _ = keyData.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in
            SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
        }
        // сохранение ключа в KeyChain
        KeyChainManager.shared.saveEncryptionKey(keyData)
        return keyData
    }
    

    
    //MARK:  - Realm с конфигурацией

    private func openRealm() throws -> Realm {
        if let existingRealm = realm {
            return existingRealm
        } else {
            do {
                let newRealm = try Realm(configuration: realmConfiguration)
                realm = newRealm
                return newRealm
            } catch {
                throw error
            }
        }
    }
    
    //MARK:  - methods
 
    func addQuots(quote: String, category: String) {
        
        do {

            let realm = try openRealm()
            
            do {
                try realm.write {
                    let newQuote = Quote(quote: quote, category: category)
                    realm.add(newQuote)
                    }
            } catch {
                print(">error")
            }
        } catch {
            print("НЕТ ДОСТУПА К ДАННЫМ")
        }
 
    }
    
    func getSortedQuotes(comletion: @escaping ([Quote]) -> Void) {
        do {
            
            let realm = try openRealm()

            let sortQuotes = realm.objects(Quote.self).sorted(byKeyPath: "date", ascending: false)
            comletion(Array(sortQuotes))
            
        } catch {
            print("sort", error)
        }

    }
    
    
    func getCategories(comletion: @escaping ([String]) -> Void) {
        
        do {
            
            let realm = try openRealm()

            let categoryList = Set(realm.objects(Quote.self).compactMap { $0.category })
            let categories = Array(categoryList)
            comletion(categories)
            
        } catch {
            print("category", error)
        }

    }
    
    func oneCategoryList(category: String, completion: @escaping ([Quote]) -> Void) {
        
        do {
            
            let realm = try openRealm()
            
            let list = realm.objects(Quote.self).filter("category == %@", category)
            completion(Array(list))
            
        } catch {
            print("list", error)
        }

    }
}
