//
//  ServiceAPI.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import Alamofire
import UIKit
import Toast_Swift

/// String값 반환 처리
fileprivate let errorString =
"Response could not be serialized, input data was nil or zero length."

/// 네트워킹 통합 메소드
fileprivate func networking<T: Decodable>(
    urlStr: String,
    method: HTTPMethod,
    data: Data?,
    model: T.Type,
    apiType: Warning,
    completion: @escaping(Result<T, AFError>) -> Void) {
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
                switch response.result {
                case .success(let result):
                    networkingAlert(apiType, true)
                    completion(.success(result))
                case .failure(let error):
                    if error.errorDescription! != errorString {
                        networkingAlert(apiType, false)
                    } else {
                        networkingAlert(apiType, true)
                    }
                    completion(.failure(error))
                }
            }
    }

/// 이미지 업로드 메소드
fileprivate func uploadNetworking<T: Decodable>(
    urlStr: String,
    method: HTTPMethod,
    data: Data?,
    model: T.Type,
    completion: @escaping(Result<T, AFError>) -> Void) {
        guard let url = URL(string: baseURL + urlStr) else {
            print("URL을 찾을 수 없습니다.")
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(
                data!,
                withName: "file",
                fileName: "test.jpg",
                mimeType: "image/jpg")},
                  to: url)
        .responseDecodable(of: model.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
                networkingAlert(.none, false)
            }
        }
    }

/// 네트워킹 결과 알림
fileprivate func networkingAlert(_ type: Warning, _ isSuccessed: Bool) {
    DispatchQueue.main.async {
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let firstWindow = firstScene.windows.first,
              let vc = firstWindow.rootViewController else {
              // vc = 최상단에 있는 ViewController
            return
        }
        
        if type == .blockUser {
           showSuccessToast(vc, type)
        } else if isSuccessed && type != .none && type != .loginRemembered {
            showSuccessToast(vc, type)
        } else if !isSuccessed && type != .loginRemembered {
            switch type {
            case .cancleBlock,
                 .cancleSave,
                 .cancleAlarm,
                 .deleteComment,
                 .deleteEvent,
                 .changeEvent,
                 .createEvent:
                showSuccessToast(vc, type)
            default:
                showFailAlert(vc)
            }
        }
    }
}

/// 성공 메시지
fileprivate func showSuccessToast(_ vc: UIViewController,_ type: Warning) {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height / 1.3
    
    let warningViewWidth = width - 40
    let toastPointX = width / 2
    let toastPointY = type == .writing ? height - 52 : height
    
    let warningView = WarningView(frame: CGRect(
        x: 0,
        y: 0,
        width: warningViewWidth,
        height: 52))
    warningView.warninglabel.text = type.body

    vc.view.showToast(
        warningView,
        duration: 1.5,
        point: CGPoint(x: toastPointX, y: toastPointY))
}

/// 실패 메시지
fileprivate func showFailAlert(_ vc: UIViewController) {
    let alertVC = UIAlertController(
        title: "네트워크 연결 상태가 좋지 않거나 네트워킹에 실패하였습니다.\n다시 시도해주세요.",
        message: nil,
        preferredStyle: .alert)
    let cancleAction = UIAlertAction(title: "확인", style: .default)
    
    alertVC.addAction(cancleAction)
    
    vc.present(alertVC, animated: true)
}

final class API {
    
    // MARK: - 중복 요청 방지 Property
    
    fileprivate static var eventIsCreating: Bool = false
    fileprivate static var commentIsCreating: Bool = false
    fileprivate static var myInfoIsPatching: Bool = false
    
    // MARK: - Login
    
    /// 애플 로그인
    static func appleOAuthLogin(
        _ params: [String: String],
        completion: @escaping(LoginInfo) -> Void)
    {
        guard let data = try? JSONSerialization.data(
            withJSONObject: params, options: .prettyPrinted) else {
            return
        }
        
        networking(
            urlStr: Address.loginOauthApple.url,
            method: .post,
            data: data,
            model: LoginInfo.self,
            apiType: .none) { result in
                switch result {
                case .success(let info):
                    completion(info)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    
    /// 구글 oAuth 로그인
    static func googleOAuthLogin(_ params: [String: String], completion: @escaping(LoginInfo) -> Void) {
        guard let data = try? JSONSerialization.data(
            withJSONObject: params, options: .prettyPrinted) else {
            return
        }
        
        networking(
            urlStr: Address.loginOauthGoogle.url,
            method: .post,
            data: data,
            model: LoginInfo.self,
            apiType: .none) { result in
                switch result {
                case .success(let info):
                    completion(info)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    /// 자동 로그인
    static func rememberedLogin(_ params: [String: Any], completion: @escaping(LoginInfo?) -> Void) {
        guard let data = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) else {
            return
        }
        
        networking(
            urlStr: Address.loginRemembered.url,
            method: .post,
            data: data,
            model: LoginInfo.self,
            apiType: .loginRemembered) { result in
                switch result {
                case .success(let info):
                    completion(info)
                case .failure(let error):
                    print("\(error)\n 자동 로그인 실패 시 나오는 거라서 상관 X")
                    completion(nil)
                }
            }
    }
    
    /// FCM 토큰 등록
    static func postFcmToken(_ params: [String: String], completion: @escaping() -> Void) {
        guard let data = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) else {
            return
        }
        
        networking(
            urlStr: Address.token.url,
            method: .post,
            data: data,
            model: String.self,
            apiType: .none) { result in
                switch result {
                case .success(_):
                    completion()
                case .failure(let error):
                    if error.errorDescription! == errorString {
                        completion()
                    } else {
                        print("FCM에러 \(error)")
                    }
                }
            }
    }
    
    // MARK: - Event
    
    /// 이벤트 전체 받아오기
    static func getEvents(completion: @escaping([Event]) -> Void) {
        networking(
            urlStr: Address.events.url,
            method: .get,
            data: nil,
            model: [Event].self,
            apiType: .none) { result in
                switch result {
                case .success(let events):
                    completion(events)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    /// 이벤트 하나 받아오기
    static func getEventOne(_ id: Int, completion: @escaping(Event) ->Void) {
        networking(
            urlStr: Address.events.url + "/\(id)",
            method: .get,
            data: nil,
            model: Event.self,
            apiType: .none) { result in
                switch result {
                case .success(let events):
                    completion(events)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    /// 이벤트 생성하기
    static func createEvent(_ data: [String : String], completion: @escaping() -> Void) {
        if !eventIsCreating {
            eventIsCreating = true
            
            guard let data = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) else { return }
            
            networking(
                urlStr: Address.events.url,
                method: .post,
                data: data,
                model: Event.self,
                apiType: .createEvent) { result in
                    self.eventIsCreating = false
                    switch result {
                    case .success(_):
                        completion()
                    case .failure(let error):
                        if error.errorDescription! == errorString {
                            print("성공")
                            completion()
                        } else {
                            print(error)
                        }
                    }
                }
        }
        
        
    }
    
    /// 이벤트 삭제하기
    static func deleteEvent(_ id: Int, completion: @escaping() -> Void) {
        networking(
            urlStr: Address.events.url + "/\(id)",
            method: .delete,
            data: nil,
            model: Event.self,
            apiType: .deleteEvent) { result in
                switch result {
                case .success(_):
                    completion()
                case .failure(let error):
                    if error.errorDescription! == errorString {
                        completion()
                    } else {
                        print(error)
                    }
                }
            }
    }
    
    /// 이벤트 수정하기
    static func updateEvent(id: Int, params: [String: String], completion: @escaping () -> Void) {
        guard let data = try? JSONSerialization.data(
            withJSONObject: params, options: .prettyPrinted) else {
            return
        }
        
        networking(
            urlStr: Address.events.url + "/\(id)",
            method: .patch,
            data: data,
            model: String.self,
            apiType: .changeEvent) { result in
                print(result)
                switch result {
                case .success(_):
                    completion()
                case .failure(let error):
                    if error.errorDescription! == errorString {
                        completion()
                    } else {
                        print(error)
                    }
                }
            }
    }
    
    // MARK: - Comments
    
    /// 댓글 전체 받아오기
    static func getComments(_ id: Int, completion: @escaping([Comment]) -> Void) {
        networking(
            urlStr: Address.comments.url + "?eventId=\(id)",
            method: .get,
            data: nil,
            model: [Comment].self,
            apiType: .none) { result in
                switch result {
                case .success(let comments):
                    completion(comments)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    /// 댓글 달기
    static func createComment(data: [String: Any], completion: @escaping () -> Void) {
        if !commentIsCreating {
            commentIsCreating = true
            guard let data = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) else { return }
            
            networking(
                urlStr: Address.comments.url,
                method: .post,
                data: data,
                model: Comment.self,
                apiType: .none) { result in
                    self.commentIsCreating = false
                    switch result {
                    case .success(_):
                        print("성공")
                    case .failure(let error):
                        if error.errorDescription! == errorString {
                            print("성공")
                            completion()
                        } else {
                            print(error)
                        }
                        
                    }
                }
        }
        
        
    }
    
    /// 댓글 삭제하기
    static func deleteComment(_ id: Int, completion: @escaping () -> Void) {
        networking(
            urlStr: Address.comments.url + "/\(id)",
            method: .delete,
            data: nil,
            model: String.self,
            apiType: .deleteComment) { result in
                switch result {
                case .success(_):
                    print("성공")
                case .failure(let error):
                    if error.errorDescription! == errorString {
                        print("성공")
                        completion()
                    } else {
                        print(error)
                    }
                }
            }
    }
    
    // MARK: - Like
    
    /// 행사 좋아요 누르기
    static func likeEvent(_ params: [String: Int], completion: @escaping () -> Void) {
        guard let data = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) else {
            return
        }
        
        networking(
            urlStr: Address.likes.url,
            method: .post,
            data: data,
            model: String.self,
            apiType: .none) { result in
                switch result {
                case .success(_):
                    print("성공")
                case .failure(let error):
                    if error.errorDescription! == errorString {
                        completion()
                    } else {
                        print(error)
                    }
                }
            }
    }
    
    /// 행사 좋아요 삭제하기
    static func deleteLikes(data: [String: Int], completion: @escaping() -> Void) {
        guard let data = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) else { return }
        
        networking(
            urlStr: Address.likes.url,
            method: .delete,
            data: data,
            model: likes.self,
            apiType: .cancleSave) { result in
                switch result {
                case .success(_):
                    print("성공")
                case .failure(let error):
                    if error.errorDescription! == errorString {
                        completion()
                    } else {
                        print(error)
                    }
                }
            }
    }
    
    /// 행사 좋아요 가져오기 (북마크 버튼 눌려진 행사)
    static func getLikes(completion: @escaping([Event]) -> Void) {
        networking(
            urlStr: Address.likes.url,
            method: .get,
            data: nil,
            model: [Event].self,
            apiType: .none) { result in
                switch result {
                case .success(let Events):
                    completion(Events)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    // MARK: - Alarm
    
    /// 행사 알림 등록하기
    static func postAlarm(_ params: [String: Any], completion: @escaping() -> Void) {
        
        guard let data = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) else { return }
        
        networking(
            urlStr: Address.nofifications.url,
            method: .post,
            data: data,
            model: String.self,
            apiType: .none) { result in
                switch result {
                case .success(_):
                    completion()
                case .failure(let error):
                    if error.errorDescription! == errorString {
                        completion()
                    } else {
                        print(error)
                    }
                    
                }
            }
    }
    
    /// 행사 알림 가져오기
    static func getAlarm(completion: @escaping([Noti]) -> Void) {
        networking(
            urlStr: Address.nofifications.url,
            method: .get,
            data: nil,
            model: [Noti].self,
            apiType: .none) { result in
                switch result {
                case .success(let Events):
                    completion(Events)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    /// 행사 알림 삭제하기
    static func deleteAlarm(data: [String: Any], completion: @escaping() -> Void) {
        guard let data = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) else { return }
        
        networking(
            urlStr: Address.nofifications.url,
            method: .delete,
            data: data,
            model: Noti.self,
            apiType: .cancleAlarm) { result in
                switch result {
                case .success(_):
                    print("성공")
                case .failure(let error):
                    if error.errorDescription! == errorString {
                        completion()
                    } else {
                        print(error)
                    }
                }
            }
    }
    
    // MARK: - Block
    
    /// 차단 목록 가져오기
    static func getBlock(completion: @escaping([Block]) -> Void) {
        networking(
            urlStr: Address.block.url,
            method: .get,
            data: nil,
            model: [Block].self,
            apiType: .none) { result in
                switch result {
                case .success(let blocks):
                    completion(blocks)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    /// 차단 해제하기
    static func deleteBlock(data: [String: Int], completion: @escaping() -> Void) {
        guard let data = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) else { return }
        
        networking(
            urlStr: Address.block.url,
            method: .delete,
            data: data,
            model: Block.self,
            apiType: .cancleBlock) { result in
                switch result {
                case .success(_):
                    print("성공")
                    completion()
                case .failure(let error):
                    if error.errorDescription! == errorString {
                        print("성공")
                        completion()
                    } else {
                        print(error)
                    }
                }
            }
    }
    
    /// 차단하기
    static func postBlock(data: [String: Int], completion: @escaping() -> Void) {
        guard let data = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) else { return }
        
        networking(
            urlStr: Address.block.url,
            method: .post,
            data: data,
            model: Block.self,
            apiType: .blockUser) { result in
                switch result {
                case .success(_):
                    completion()
                case .failure(let error):
                    if error.errorDescription! == errorString {
                        completion()
                    } else {
                        print(error)
                    }
                }
            }
    }
    
    // MARK: - My info
    
    /// 내 정보 업데이트
    static func patchMeInfo(data: [String: String?]) {
        
        if !myInfoIsPatching {
            myInfoIsPatching = true
            
            guard let data = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) else { return }
            
            networking(
                urlStr: Address.me.url,
                method: .patch,
                data: data,
                model: Me.self,
                apiType: .none) { result in
                    self.myInfoIsPatching = false
                    switch result {
                    case .success(_):
                        print("성공")
                    case .failure(let error):
                        if error.errorDescription! == errorString {
                            print("성공")
                        } else {
                            print(error)
                        }
                    }
                }
        }
        
    }
    
    /// 내 정보 이미지 업로드
    static func uploadMeImage(image: UIImage, completion: @escaping(Images) -> Void) {
        let imageData = image.jpegData(compressionQuality: 1)!
        
        uploadNetworking(
            urlStr: Address.images.url,
            method: .post,
            data: imageData,
            model: Images.self) { result in
                switch result {
                case .success(let Images):
                    completion(Images)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    /// 내 정보 받아오기
    static func getMeInfo(completion: @escaping(Me) -> Void) {
        networking(
            urlStr: Address.me.url,
            method: .get,
            data: nil,
            model: Me.self,
            apiType: .none) { result in
                switch result {
                case .success(let Me):
                    completion(Me)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    /// 내가 단 댓글 받아오기
    static func getMyComment(completion: @escaping([Comment]) -> Void) {
        networking(
            urlStr: Address.mycomments.url,
            method: .get,
            data: nil,
            model: [Comment].self,
            apiType: .none) { result in
                switch result {
                case .success(let myComments):
                    completion(myComments)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    /// 내가 쓴 행사 받아오기
    static func getMyEvent(completion: @escaping([Event]) -> Void) {
        networking(
            urlStr: Address.myevents.url,
            method: .get,
            data: nil,
            model: [Event].self,
            apiType: .none) { result in
                switch result {
                case .success(let myEvents):
                    completion(myEvents)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    // MARK: - Topic
    
    /// 새 행사 구독 토픽 가져오기
    static func getTopic(completion: @escaping(Topic) -> Void) {
        networking(
            urlStr: Address.topics.url,
            method: .get,
            data: nil,
            model: Topic.self,
            apiType: .none) { result in
                switch result {
                case .success(let topics):
                    completion(topics)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    /// 새 행사 구독 토픽 설정하기
    static func putTopic(data: [String: [Any]]) {
        guard let data = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) else { return }
        
        networking(
            urlStr: Address.topics.url,
            method: .put,
            data: data,
            model: Int.self,
            apiType: .none) { result in
                switch result {
                case .success(_):
                    print("성공")
                case .failure(let error):
                    if error.errorDescription! == errorString {
                        print("성공")
                    } else {
                        print(error)
                    }
                }
            }
    }
    
    // MARK: - Report
    
    /// 게시글 신고하기
    static func reportEvent(eventId: Int, completion: @escaping() -> Void) {
        networking(
            urlStr: Address.reports.url + "/\(eventId)",
            method: .post,
            data: nil,
            model: Report.self,
            apiType: .none) { result in
                switch result {
                case .success(_):
                    completion()
                case .failure(let error):
                    print(error)
                }
            }
    }
}
