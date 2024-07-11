//
//  NetworkManager.swift
//  HushCo
//
//  Created by Danilo Gervasoni on 27/06/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let urlString = "http://localhost:3002/users"
    
    func fetchUsers(completion: @escaping ([User]?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to fetch users:", error)
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(users)
            } catch let jsonError {
                print("Failed to decode JSON:", jsonError)
                completion(nil)
            }
        }.resume()
    }
}


