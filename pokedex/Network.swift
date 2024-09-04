//
//  Network.swift
//  pokedex
//
//  Created by Eduardo Carranza maqueda on 03/09/24.
//

import Foundation

enum NetErrorCode: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case decodingError
    case unableConplete
}

class Network {
    
    static let link = Network()
    static let baseURL = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    
    init (){}
    
    func getData(completed: @escaping (Result<[PokeModel], NetErrorCode>) -> Void ) {
        guard let url = URL(string: Network.baseURL) else {
            completed(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data?.parseData(removeString: "null,") else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodeResponse = try decoder.decode([PokeModel].self, from: data)
                completed(.success(decodeResponse))
            } catch {
                print("Hubo un error con los datos \(error.localizedDescription)")
                completed(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
}

 func translateText(_ text: String, completion: @escaping (String?) -> Void) {
    let apiKey = "YOUR_GOOGLE_API_KEY"
    let urlString = "https://translation.googleapis.com/language/translate/v2?key=\(apiKey)"
    
    guard let url = URL(string: urlString) else {
        completion(nil)
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    let parameters: [String: Any] = [
        "q": text,
        "target": "es"
    ]
    
    request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            completion(nil)
            return
        }
        
        if let translation = try? JSONDecoder().decode(GoogleTranslationResponse.self, from: data) {
            completion(translation.data.translations.first?.translatedText)
        } else {
            completion(nil)
        }
    }
    
    task.resume()
}

struct GoogleTranslationResponse: Codable {
    struct Data: Codable {
        struct Translation: Codable {
            let translatedText: String
        }
        let translations: [Translation]
    }
    let data: Data
}

extension Data {
    func parseData(removeString word: String) -> Data? {
        let dataString = String (data: self, encoding: .utf8)
        let dtaString = dataString?.replacingOccurrences(of: word, with: "")
        
        guard let data = dtaString?.data(using: .utf8) else {return nil}
        return data
    }
}
