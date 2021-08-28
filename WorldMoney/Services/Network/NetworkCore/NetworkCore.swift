//
//  NetworkCore.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 22.08.2021.
//

import Alamofire
import RxAlamofire
import RxSwift
import Foundation

public class NetworkCore {
    enum EncodingType {
        case http
        case json
    }

    
    private let apiBase: String
    private let session: Session
    
    public init(
        apiBase: String,
        session: Session
    ) {
        self.apiBase = apiBase
        self.session = session
        
    }
    
    func request(
        method: Alamofire.HTTPMethod,
        path: String,
        parameters: [String: Any]? = nil,
        encodingType: EncodingType = .http
    ) -> Observable<(HTTPURLResponse, Any)> {
        
        let encoding: ParameterEncoding
        
        switch encodingType {
        case .http:
            encoding = URLEncoding.default
        case .json:
            encoding = JSONEncoding.default
        }
        
        return session.rx.responseJSON(
            method,
            path,
            parameters: parameters,
            encoding: encoding
        )
        
    }
}
