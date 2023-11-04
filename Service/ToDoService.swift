//
//  ToDoService.swift
//  QuotesApp


import Foundation
import RealmSwift

final class ToDoService {
 
    func addQuots(quote: String, category: String) {
        do {
            let realm = try Realm()
            
            do {
                try realm.write {
                    let newQuote = Quote(quote: quote, category: category)
                    realm.add(newQuote)
                    }
            } catch {
                print(">error")
            }
        } catch {
            print(">>error")
        }
 
    }
    
    func getSortedQuotes(comletion: @escaping ([Quote]) -> Void) {
        guard let realm = try? Realm() else { return }
        let sortQuotes = realm.objects(Quote.self).sorted(byKeyPath: "date", ascending: false)
        comletion(Array(sortQuotes))
    }
    
    
    func getCategories(comletion: @escaping ([String]) -> Void) {
        guard let realm = try? Realm() else { return }
        let categoryList = Set(realm.objects(Quote.self).compactMap { $0.category })
        let categories = Array(categoryList)
        comletion(categories)
    }
    
    func oneCategoryList(category: String, completion: @escaping ([Quote]) -> Void) {
        guard let realm = try? Realm() else { return }
        let list = realm.objects(Quote.self).filter("category == %@", category)
        completion(Array(list))
    }
}
