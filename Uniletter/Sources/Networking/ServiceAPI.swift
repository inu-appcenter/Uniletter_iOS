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

// MARK: - 네트워킹 통합
private func networking<T: Decodable>(urlStr: String, method: HTTPMethod, data: Data?, model: T.Type, completion: @escaping(Result<T, AFError>, StatusCode) -> Void) {
    var statusCode: StatusCode = .fail
    guard let url = URL(string: baseURL + urlStr) else {
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

// 이미지 업로드
private func uploadNetworking<T: Decodable>(urlStr: String, method: HTTPMethod, data: Data?, model: T.Type, completion: @escaping(Result<T, AFError>, StatusCode) -> Void) {
    
    var statusCode: StatusCode = .fail
    guard let url = URL(string: baseURL + urlStr) else {
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
    // 이벤트 전체 받아오기
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
    
    // 이벤트 하나 받아오기
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
    
    // 댓글 전체 받아오기
    static func getComments(_ id: Int, completion: @escaping([Comment]) -> Void) {
        networking(
            urlStr: Address.comments.url + "\(id)",
            method: .get,
            data: nil,
            model: [Comment].self) { result, _ in
                switch result {
                case .success(let comments):
                    completion(comments)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    // 로그인
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
    
    // 자동 로그인
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
    
    // 내 정보 받아오기
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
    
    // 내가 단 댓글 받아오기
    static func getMyComment(completion: @escaping([Comment]) -> Void) {
        networking(
            urlStr: Address.mycomments.url,
            method: .get,
            data: nil,
            model: [Comment].self) { result, _ in
                switch result {
                case .success(let myComments):
                    completion(myComments)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    // 내가 쓴 행사 받아오기
    static func getMyEvent(completion: @escaping([Event]) -> Void) {
        networking(
            urlStr: Address.myevents.url,
            method: .get,
            data: nil,
            model: [Event].self) { result, _ in
                switch result {
                case .success(let myEvents):
                    completion(myEvents)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    // 새 행사 구독 토픽 가져오기
    static func getTopic(completion: @escaping(Topic) -> Void) {
        
        networking(
            urlStr: Address.topics.url,
            method: .get,
            data: nil,
            model: Topic.self) { result, _ in
                switch result {
                case .success(let topics):
                    completion(topics)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    // 새 행사 구독 토픽 설정하기
    static func putTopic(data: [String: [Any]]) {
        
        guard let data = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) else { return }
        
        networking(
            urlStr: Address.topics.url,
            method: .put,
            data: data,
            model: Topic.self) { result, _ in
                switch result {
                case .success(_):
                    print("성공")
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    // 행사 좋아요 가져오기 (북마크 버튼 눌려진 행사)
    static func getLikes(completion: @escaping([Event]) -> Void) {
        
        networking(
            urlStr: Address.likes.url,
            method: .get,
            data: nil,
            model: [Event].self) { result, _ in
                switch result {
                case .success(let Events):
                    completion(Events)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    // 내 정보 업데이트
    static func patchMeInfo(data: [String: Any]) {
        guard let data = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) else { return }
        
        networking(
            urlStr: Address.me.url,
            method: .patch,
            data: data,
            model: Me.self) { result, _ in
                switch result {
                case .success(_):
                    print("성공")
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    // 내 정보 이미지 업로드
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
    
    // 댓글 달기
    static func createComment(data: [String: Any], completion: @escaping () -> Void) {
        guard let data = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) else { return }

        networking(
            urlStr: Address.comments.url,
            method: .post,
            data: data,
            model: Comment.self) { result, _ in
                switch result {
                case .success(_):
                    completion()
                case .failure(let error):
                    print(error)
                }
            }

    }
    
    // 행사 생성
    static func createEvent(data: [String : String], completion: @escaping() -> Void) {
        guard let data = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) else { return }

        networking(
            urlStr: Address.comments.url,
            method: .post,
            data: data,
            model: Event.self) { result, _ in
                switch result {
                case .success(_):
                    completion()
                case .failure(let error):
                    print(error)
                }
            }
    }
    

}
