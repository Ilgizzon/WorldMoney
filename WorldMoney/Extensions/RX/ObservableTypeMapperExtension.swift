//
//  ObservableTypeMapperExtension.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 28.08.2021.
//

import Foundation
import RxSwift

public extension ObservableType where Element == Any {
    
    func mapToObject<T: Decodable>(
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy
    ) -> Observable<T> {
        
        return flatMap({ value -> Observable<T> in
            let JSONObject = value
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = keyDecodingStrategy
            var jsonData: Data
            var decodedObject: T
            
            do {
                jsonData = try JSONSerialization.data(withJSONObject: JSONObject, options: .prettyPrinted)
                decodedObject = try jsonDecoder.decode(T.self, from: jsonData)
            } catch {
                return Observable<T>.error(error)
            }
            
            return Observable<T>.just(decodedObject)
        })
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
        .observe(on: MainScheduler.instance)
    }
}

public extension ObservableType where Element == (HTTPURLResponse, Any) {
   
    func mapToObject<T: Decodable>(
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
    ) -> Observable<T> {
        flatMap { value -> Observable<T> in
            Observable<Any>.just(value.1)
                .mapToObject(
                    keyDecodingStrategy: keyDecodingStrategy
                )
        }
    }
}
