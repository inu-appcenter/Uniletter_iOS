//
//  ServiceAPI.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import Alamofire

// MARK: 네트워킹 통합
private func networking<T: Decodable>(urlStr: String, method: HTTPMethod, data: Data?, model: T.Type, completion: @escaping(Result<T, AFError>) -> Void) {
    guard let url = URL(string: Address.base.url + urlStr) else {
        print("URL을 찾을 수 없습니다.")
        return
    }
    var request = URLRequest(url: url)
    request.httpBody = data
    request.method = method
    
    AF.request(request)
        .validate(statusCode: 200..<500)
        .validate(contentType: ["application/json"])
        .responseDecodable(of: model.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
}

// MARK: - API
class API {
    static func getEvents(completion: @escaping([Event]) -> Void) {
        networking(
            urlStr: Address.events.url,
            method: .get,
            data: nil,
            model: [Event].self) { result in
                switch result {
                case .success(let events):
                    completion(events)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    static func getEventOne(_ id: Int, completion: @escaping(Event) ->Void) {
        networking(
            urlStr: Address.events.url + "/\(id)",
            method: .get,
            data: nil,
            model: Event.self) { result in
                switch result {
                case .success(let events):
                    completion(events)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
