//
//  NetworkService.swift
//  QuotesApp


import Foundation

final class NetworkService {
    
    func fetchJoke(completion: @escaping (Result<QuoteJSON, Error>) -> Void) {
        //url
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else { return }
        //request
        let request = URLRequest(url: url)
        //session
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, responce, error in
            //error
            if let error = error {
                completion(.failure(error))
            }
            
            if let response = responce as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    guard let data = data else {
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let quoteJSON = try decoder.decode(QuoteJSON.self, from: data)
                        completion(.success(quoteJSON))
                    } catch {
                        print(error, "JSON")
                    }
                case 404:
                    print("- error")
                default:
                    break
                }
            }
        }
        dataTask.resume()
    }
}
