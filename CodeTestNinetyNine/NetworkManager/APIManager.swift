//
//  APIManager.swift
//  CodeTestNinetyNine
//
//  Created by sawpyae on 10/13/22.
//

import Foundation
class APIManager {
    static let sharedInstance = APIManager()

    func dataRequest<T: Decodable>(with url: String, objectType: T.Type, completion: @escaping (Result<T>) -> Void) {

        let dataURL = URL(string: url)!

        let session = URLSession.shared

        let request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)

        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200  {
                do {
                    let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
                    completion(Result.success(decodedObject))
                } catch let error {
                    completion(Result.failure(APPError(result: error.localizedDescription,
                                                       errortype: error.localizedDescription,
                                                       extrainfo: error.localizedDescription)))
                }
            }else{
                if let data = data {
                    do {
                        let decodedObject = try JSONDecoder().decode(APPError.self, from: data)
                        completion(Result.failure(decodedObject))
                    } catch let error {
                        completion(Result.failure(APPError(result: error.localizedDescription,
                                                           errortype: error.localizedDescription,
                                                           extrainfo: error.localizedDescription)))
                    }
                }
            }
        })

        task.resume()
    }
}
