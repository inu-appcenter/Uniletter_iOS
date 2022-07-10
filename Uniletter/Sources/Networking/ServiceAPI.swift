//
//  ServiceAPI.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import Alamofire
import UIKit

enum StatusCode {
    case success
    case fail
    case server
}

// MARK: 네트워킹 통합
private func networking<T: Decodable>(urlStr: String, method: HTTPMethod, data: Data?, model: T.Type, completion: @escaping(Result<T, AFError>, StatusCode) -> Void) {
    var statusCode: StatusCode = .fail
    guard let url = URL(string: Address.base.url + urlStr) else {
        print("URL을 찾을 수 없습니다.")
        return
    }
    
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = data
    request.method = method
    
    AF.request(request)
        .validate(statusCode: 200..<500)
        .responseDecodable(of: model.self) { response in
            switch response.response?.statusCode {
            case 200: statusCode = .success
            case 500: statusCode = .server
            default: break
            }
            
            switch response.result {
            case .success(let result):
                completion(.success(result), statusCode)
            case .failure(let error):
                completion(.failure(error), statusCode)
            }
        }
}

private func uploadNetworking<T: Decodable>(urlStr: String, method: HTTPMethod, data: Data?, model: T.Type, completion: @escaping(Result<T, AFError>, StatusCode) -> Void) {
    
    var statusCode: StatusCode = .fail
    guard let url = URL(string: Address.base.url + urlStr) else {
        print("URL을 찾을 수 없습니다.")
        return
    }
    
    AF.upload(multipartFormData: { multipartFormData in
        multipartFormData.append(data!, withName: "file", fileName: "test.jpg", mimeType: "image/jpg")
    }, to: url).responseDecodable(of: model.self) { response in
        switch response.response?.statusCode {
        case 200: statusCode = .success
        case 500: statusCode = .server
        default: break
        }
        
        switch response.result {
        case .success(let result):
            completion(.success(result), statusCode)
        case .failure(let error):
            completion(.failure(error), statusCode)
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
            model: [Event].self) { result, _ in
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
            model: Event.self) { result, _ in
                switch result {
                case .success(let events):
                    completion(events)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    static func oAuthLogin(_ params: [String: String], completion: @escaping(LoginInfo) -> Void) {
        guard let data = try? JSONSerialization.data(
            withJSONObject: params, options: .prettyPrinted) else {
            return
        }
        
        networking(
            urlStr: Address.loginOauth.url,
            method: .post,
            data: data,
            model: LoginInfo.self) { result, statusCode in
                switch result {
                case .success(let info):
                    if statusCode == .success {
                        completion(info)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    static func rememberedLogin(_ params: [String: Any], completion: @escaping(LoginInfo) -> Void) {
        guard let data = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) else {
            return
        }
        
        networking(
            urlStr: Address.loginRemembered.url,
            method: .post,
            data: data,
            model: LoginInfo.self) { result, statusCode in
                switch result {
                case .success(let info):
                    if statusCode == .success {
                        completion(info)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    static func getMeInfo(completion: @escaping(Me) -> Void) {
        networking(
            urlStr: Address.me.url,
            method: .get,
            data: nil,
            model: Me.self) { result, _ in
                switch result {
                case .success(let Me):
                    completion(Me)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    
    static func getMyComment(completion: @escaping([myComment]) -> Void) {
        
        networking(
            urlStr: Address.mycomments.url,
            method: .get,
            data: nil,
            model: [myComment].self) { result, _ in
                switch result {
                case .success(let myComments):
                    completion(myComments)
                case .failure(let error):
                    print(error)
                }
            }
    }
    static func patchMeInfo(data: [String: Any]) {
    
        guard let data = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) else { return }
        networking(
            urlStr: Address.me.url,
            method: .patch,
            data: data, model: Me.self) { result, _ in
                switch result {
                case .success(let Me):
                    print("성공")
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    static func uploadMeImage(image: UIImage, completion: @escaping(Images) -> Void) {
        
        let imageData = image.jpegData(compressionQuality: 1)!
        
        uploadNetworking(
            urlStr: Address.images.url,
            method: .post,
            data: imageData,
            model: Images.self) { result, _ in
                switch result {
                case .success(let Images):
                    completion(Images)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    static func createComment(data: [String: Any]) {

        guard let data = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) else { return }

        networking(
            urlStr: Address.comments.url,
            method: .post,
            data: data,
            model: Comment.self) { result, _ in
                switch result {
                case .success(let Comments):
                    print(Comments)
                case .failure(let error):
                    print(error)
                }
            }

    }
 
}
