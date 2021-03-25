//
//  ApiProvider.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 17/03/2021.
//

import UIKit
import Moya
import RxSwift
import ObjectMapper
import Alamofire
import Resolver

fileprivate class DefaultAlamofireManager: Alamofire.Session {
    static let sharedManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 30 // as seconds, you can set your request timeout
        configuration.timeoutIntervalForResource = 30 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return Session(configuration: configuration)
    }()
}

class ApiProvider<Target> where Target: Moya.TargetType {
    fileprivate let provider: MoyaProvider<Target>
    
    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider<Target>.neverStub,
         session: Session = DefaultAlamofireManager.sharedManager,
         plugins: [PluginType] = [],
         trackInflights: Bool = false) {
        
        self.provider = MoyaProvider(endpointClosure: endpointClosure,
                                     requestClosure: requestClosure,
                                     stubClosure: stubClosure,
                                     session: session,
                                     plugins: plugins,
                                     trackInflights: trackInflights)
    }
    
    private func baseRequest(_ token: Target) -> Single<Moya.Response> {
        return provider.rx.request(token)
                .filterSuccessfulStatusCodes()
                .subscribeOn(ConcurrentDispatchQueueScheduler(queue: DispatchQueue(label: "com.queue.apiprovider")))
    }

    func requestObject<Model: BaseMappable>(_ target: Target, type: Model.Type) -> Single<Model> {
        return baseRequest(target).mapObject(Model.self)
    }
            
    func requestObjectData<Model: BaseMappable>(_ target: Target, type: Model.Type, keyPath: String = "") -> Single<Model> {
        return baseRequest(target)
            .mapObject(Model.self, atKeyPath: keyPath)
    }
    
    func requestArrayData<Model: BaseMappable>(_ target: Target, type: Model.Type, keyPath: String = "") -> Single<[Model]> {
        return baseRequest(target)
            .mapArray(Model.self, atKeyPath: keyPath)
    }
}

