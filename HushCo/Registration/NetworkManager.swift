//
//  NetworkManager.swift
//  HushCo
//
//  Created by Danilo Gervasoni on 27/06/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "http://localhost:3002/users"
    
    private init() {}
    
    func registerUser(_ user: User, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(user)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data returned"])))
                return
            }
            
            do {
                let decodedUser = try JSONDecoder().decode(User.self, from: data)
                completion(.success(decodedUser))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

