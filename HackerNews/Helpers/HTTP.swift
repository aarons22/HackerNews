//
//  HTTP.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/12/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import Alamofire

protocol HTTPProtocol {
    func request<I: Decodable>(_ request: URLRequest, completion: @escaping (_ result: Result<I>) -> Void)
}

class HTTP: HTTPProtocol {
    func request<I: Decodable>(_ request: URLRequest, completion: @escaping (Result<I>) -> Void) {
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
                        }
                    })
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
}
