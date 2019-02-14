//
//  HTTP.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/12/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import Alamofire

protocol HTTPProtocol {
    func request(_ url: String, completion: @escaping (Result<Any>) -> Void)
    func request<I: Decodable>(_ urlString: String, completion: @escaping (_ result: Result<I>) -> Void)
}

class HTTP: HTTPProtocol {
    func request(_ url: String, completion: @escaping (Result<Any>) -> Void) {
        Alamofire
            .request(url)
            .responseJSON { (response) in
                completion(response.result)
        }
    }

    func request<I: Decodable>(_ urlString: String, completion: @escaping (Result<I>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        Alamofire
            .request(request as URLRequestConvertible)
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    OperationQueue().addOperation({
                        if let data = response.data {
                            do {
                                let mapped = try JSONDecoder().decode(I.self, from: data)
                                completion(.success(mapped))
                            } catch {
                                completion(.failure(error))
                            }
                        } else {
                            // TODO
//                            completion(.failure(""))
                        }
                    })
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
}
