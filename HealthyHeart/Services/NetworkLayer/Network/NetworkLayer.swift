//
//  NetworkLayer.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import Moya
import Alamofire

final class NetworkProvider<Target: TargetType>: MoyaProvider<Target> {
    
    private let locker = Locker()
    
    override init(
        endpointClosure: @escaping EndpointClosure = NetworkProvider.defaultEndpointMapping,
        requestClosure: @escaping RequestClosure = NetworkProvider.defaultRequestMap,
        stubClosure: @escaping StubClosure = NetworkProvider.neverStub,
        callbackQueue: DispatchQueue? = nil,
        session: Session = NetworkProvider.defaultAlamofireSession(),
        plugins: [PluginType] = [],
        trackInflights: Bool = false
    ) {
        super.init(
            endpointClosure: endpointClosure,
            requestClosure: requestClosure,
            stubClosure: stubClosure,
            callbackQueue: callbackQueue,
            session: session,
            plugins: plugins,
            trackInflights: trackInflights
        )
    }
    
    func request<SuccessModel: Codable>(
        target: Target,
        successModel: SuccessModel.Type = SuccessModel.self,
        isRetryable: Bool = true,
        completion: @escaping (Result<SuccessModel, Error>) -> Void
    ) {
        request(target: target, isRetryable: isRetryable, successModel: successModel, completion: completion)
    }
    
    private func request<SuccessModel: Codable>(
        target: Target,
        isRetryable: Bool,
        successModel: SuccessModel.Type,
        completion: @escaping (Result<SuccessModel, Error>) -> ()
    ) {
        let successStatusCodes = [200, 201, 202, 203, 204]
//        locker.lock()
        request(target) { [weak self] result in
            guard let self else { return }
//            locker.unlock()
            switch result {
            case .success(let response):
                if successStatusCodes.contains(response.statusCode) {
                    do {
                        let data = try self.parseModel(modelType: successModel, from: response.data)
                        completion(.success(data))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    if response.statusCode == 401 {
                        handleUnauthorizedStatus(
                            target: target,
                            isRetryable: isRetryable
                        ) {
                            self.request(target: target, isRetryable: isRetryable, successModel: successModel, completion: completion)
                        } retryRequest: {
                            self.request(target: target, isRetryable: false, successModel: successModel, completion: completion)
                        } showUnAuthorized: {
                            completion(.failure(NSError.unknownServerError(response.statusCode)))
                        }
                    } else {
                        completion(.failure(NSError.unknownServerError(response.statusCode)))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func parseModel<Model: Codable>(modelType: Model.Type, from data: Data) throws -> Model {
        do {
            return try JSONDecoder().decode(modelType, from: data)
        } catch {
            throw NSError.decodeError("\(error)")
        }
    }
    
    private func handleUnauthorizedStatus(
        target: Target,
        isRetryable: Bool,
        saveRequest: @escaping () -> (),
        retryRequest: @escaping () -> (),
        showUnAuthorized: @escaping () -> ()
    ) {
        if isRetryable {
            if TokenService.shared.nowIsUpdatingToken {
                TokenService.shared.saveRequest(saveRequest)
            } else if let token = target.token {
                TokenService.shared.refreshToken(with: token) { result in
                    switch result {
                    case .success:
                        print("✅✅✅ Token is refereshed ✅✅✅")
                        retryRequest()
                        TokenService.shared.executeAllSavedRequests()
                    case .failure:
                        showUnAuthorized()
                        TokenService.shared.removeAllRequest()
                        Alamofire.Session.default.cancelAllRequests()
                    }
                }
            }
        } else {
            showUnAuthorized()
        }
    }
    
    fileprivate static func defaultRequestMap(for endpoint: Endpoint, closure: MoyaProvider.RequestResultClosure) {
        do {
            var urlRequest = try endpoint.urlRequest()
            urlRequest.timeoutInterval = 150
            closure(.success(urlRequest))
        } catch MoyaError.requestMapping(let url) {
            closure(.failure(MoyaError.requestMapping(url)))
        } catch MoyaError.parameterEncoding(let error) {
            closure(.failure(MoyaError.parameterEncoding(error)))
        } catch {
            closure(.failure(MoyaError.underlying(error, nil)))
        }
    }
}

private extension TargetType {
    var token: String? {
        guard let token = headers?["Authorization"] else { return nil }
        let startIndex = token.index(token.startIndex, offsetBy: "Bearer ".count)
        return String(token[startIndex...])
    }
}

private extension NSError {
    static var unknownServerError: (Int) -> NSError = { code in
        return NSError(domain: "Что-то пошло не так", code: code)
    }
    
    static var decodeError: (String) -> NSError = { text in
        return NSError(domain: "Что то не то с твоей структурой", code: 200, userInfo: ["decode": text])
    }
}

private extension Response {
    func log() {
        print(String(repeating: "\n", count: 2))
        print(String(repeating: "-", count: 20))
        print("✅", statusCode)
        print(request?.url?.absoluteString ?? "")
        print(data.prettyPrintedJSONString)
        print(String(repeating: "-", count: 20))
        print(String(repeating: "\n", count: 2))
    }
}

private extension Data {
    var prettyPrintedJSONString: NSString {
        guard
            let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedJSON = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        else { return "❌ Couldn't parse data" }
        return prettyPrintedJSON
    }
}


