//
//  NetworkService.swift
//  MVP Test Project
//
//  Created by Johnnie Walker on 10.01.2020.
//  Copyright © 2020 Johnnie Walker. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    
    // Из-за того, что происходит работа с сетью, требуется сбегающее замыкание
    func getUser(completion: @escaping (Result<[User]?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getUser(completion: @escaping (Result<[User]?, Error>) -> Void) {
        
        // Формируем объект с типом URL, что позволит обращаться к адресу. Если такого URL не существует - ничего не происходит
        let urlString = "https://jsonplaceholder.typicode.com/users"
        guard let url = URL(string: urlString) else {return}
        
        // Синглтон URLSession, который будет работать с запросом к url
        URLSession.shared.dataTask(with: url) {data, _, error in
            
            // Обработка ошибки
            if let error = error {
                completion(.failure(error))
                return
            }
            
            //
            do {
                let obj = try JSONDecoder().decode([User].self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
            } .resume()
    }
}
