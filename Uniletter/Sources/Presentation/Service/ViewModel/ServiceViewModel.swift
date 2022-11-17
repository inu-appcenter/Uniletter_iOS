//
//  ServiceViewModel.swift
//  Uniletter
//
//  Created by 임현규 on 2022/11/10.
//

import Foundation
import UIKit

enum Service: CaseIterable {
    case first
    case second
    case third
    case fourth
    case fifth
    case sixth
    case seventh
    case eighth
    case ninth
    case tenth
    case eleventh
    case twelfth
    case thirteenth
    case fourteenth
    
    var title: String {
        switch self {
        case .first:
            return "제1조(목적)"
        case .second:
            return "제2조(정의)"
        case .third:
            return "제3조(약관 등의 명시와 설명 및 개정)"
        case .fourth:
            return "제4조(서비스의 제공)"
        case .fifth:
            return "제5조(서비스 이용계약의 성립)"
        case .sixth:
            return "제6조(개인정보의 관리 및 보호)"
        case .seventh:
            return "제7조(서비스 이용계약의 종료)"
        case .eighth:
            return "제8조(회원에 대한 통지)"
        case .ninth:
            return "제9조(저작권의 귀속)"
        case .tenth:
            return "제10조(게시물의 삭제 및 접근 차단)"
        case .eleventh:
            return "제11조(금지행위)"
        case .twelfth:
            return "제12조(서비스 제공의 중단 및 서비스 이용계약의 해지)"
        case .thirteenth:
            return "제13조(재판권 및 준거법)"
        case .fourteenth:
            return "제14조(기타)"
        }
    }
    
    var body: String {
        switch self {
        case .first:
            return "이 약관은 인천대학교 앱센터(이하 “회사”라고 합니다.)가 온라인으로 제공하는 디지털콘텐츠(이하 “콘텐츠“라고 한다) 및 제반서비스의 이용과 관련하여 회사와 이용자와의 권리, 의무 및 책임사항 등을 규정함을 목적으로 합니다"
     
        case .second:
            return "1. 이 약관에서 사용하는 용어의 정의는 다음과 같습니다.\n- ”서비스”란, 회사가 제공하는 모든 서비스 및 기능을 말합니다.\n- ”이용자”란, 이 약관에 따라 서비스를 이용하는 회원 및 비회원을 말합니다.\n- ”회원”이란, 서비스에 회원 등록을 하고 서비스를 이용하는 자를 말합니다.\n- ”비회원”이란, 서비스에 회원 등록을 하지 않고 서비스를 이용하는 자를 말합니다.\n- ”게시물”이란, 서비스에 게재된 문자, 사진, 영상, 하이퍼 링크 등을 말합니다.\n- “커뮤니티”란, 게시물을 게시할 수 있는 공간을 말합니다.\n- “계정”이란, 이용 계약을 통해 생성된 회원의 고유 아이디와 이에 수반하는 정보를 말합니다.\n- “서비스 내부 알림 수단”이란, 팝업, 알림, 내 정보 메뉴 등을 말합니다.\n- “관련 법”이란, 정보통신만 이용촉진 및 정보보호 등에 관한 법률, 전기통신사업법, 개인정보보호법 등 관련 있는 국내 법령을 말합니다.\n- ”아이디(ID)”라 함은 ”회원”의 식별과 서비스이용을 위하여 ”회원”이 정하고 ”회사”가 승인하는 문자 또는 숫자의 조합을 말합니다.\n- ”비밀번호(PASSWORD)”라 함은 ”회원”이 부여받은 ”아이디”와 일치되는 ”회원”임을 확인하고 비밀보호를 위해 ”회원” 자신이 정한 문자 또는 숫자의 조합을 말합니다.\n2. 제 1항에서 정의되지 않은 이 약관 내 용어의 의미는 일반적인 이용 관행에 의합니다."
        case .third:
            return "1. 회사는 이 약관을 서비스 초기화면, 회원가입 화면 및 “내 정보” 메뉴 등에 게시하거나 기타의 방법으로 회원에게 공지합니다.\n2. 회사는 필요하다고 인정되는 경우, 온라인 디지털콘텐츠산업 발전법, 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제에 관한 법률 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.\n3. 회사가 약관을 개정할 경우, 적용일자 및 개정사유를 명시하여 현행약관과 함께 서비스초기화면에 그 적용일자 7일 전부터 서비스 내부 알림 수단으로 개별 공지합니다.\n4. 이용자는 개정약관의 적용에 동의하지 않는 경우, 제 7조 (서비스 이용 계약의 종료)에 따른 회원 탈퇴 방법으로 거부 의사를 표시할 수 있습니다. 단, 회사가 약관 개정 시 “개정 약관의 적용 일자까지 회원이 거부 의사를 표시하지 아니할 경우 약관의 개정에 동의한 것으로 간주한다”는 내용을 고지하였음에도 불구하고 회원이 약관 개정에 대한 거부 의사를 표시하지 아니하면, 회사는 적용 일자부로 개정 약관에 동의한 것으로 간주합니다.\n5. 이용자는 약관 일부분만을 동의 또는 거부할 수 없습니다.\n6. 회사는 제 1항부터 제 4항까지를 준수하였음에도 불구하고 회원이 약관 개정 사실을 알지 못함으로써 발생한 피해에 대해 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습니다."
        case .fourth:
            return "1. 회사는 다음 서비스를 제공합니다.\n- 게시물을 통한 대학, 문화, 활동, 취업 정보 제공 서비스\n- 기타 회사가 정하는 서비스\n2. 유니레터는 소셜 로그인(구글, 애플 로그인)을 통해 회원으로써 커뮤니티를 이용할 수 있는 서비스 입니다. 소셜 로그인을 하지 않은 이용자 및 불특정 다수의 일반 이용자는 일부 기능에 접근할 수 없습니다.\n3. 회사는 운영상, 기술상의 필요에 따라 제공하고 있는 서비스를 변경할 수 있습니다.\n4. 회사는 이용자의 개인정보 및 서비스 이용 기록에 따라 서비스 이용에 차이를 둘 수 있습니다.\n5. 회사는 설비의 보수, 교체, 점검 또는 기간통신사업자의 서비스 중지, 인터넷 장애 등의 사유로 인해 일시적으로 서비스 제공이 어려울 경우, 통보 없이 일시적으로 서비스 제공을 중단할 수 있습니다.\n6. 회사는 천재지변, 전쟁 등 불가항력적인 사유로 인해 서비스를 더 이상 제공하기 어려울 경우, 통보 없이 서비스 제공을 영구적으로 중단할 수 있습니다.\n7. 회사는 제 4항부터 제 6항까지 및 다음 내용으로 인해 발생한 피해에 대해 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습니다.\n- 모든 서비스, 게시물, 이용 기록의 진본성, 무결성, 신뢰성, 이용 가능성의 보장\n- 서비스 이용 중 타인과 상호 간에 합의한 내용\n- 게시물, 하이퍼 링크 등 외부로 연결된 서비스와 같이 회사가 제공하지 않은 서비스에서 발생한 피해\n- 회사가 관련 법령에 따라 요구되는 보호 조치를 이행하였음에도 불구하고, 네트워크의 안정성을 해치는 행위 또는 악성 프로그램 등에 의하여 발생하는 예기치 못한 이용자의 피해\n- 이용자의 귀책 사유 또는 회사의 귀책 사유가 아닌 사유로 발생한 이용자의 피해"
            
        case .fifth:
            return "1. 회사와 회원의 서비스 이용계약은 서비스를 이용하고자 하는 자(이하 “가입 신청자”라고 합니다)가 서비스 내부의 회원가입 양식에 따라 필요한 회원 정보를 기입하고, 이 약관, 개인 정보 수집 및 이용 동의, 커뮤니티 이용 규칙 등에 명시적인 동의를 한 후, 신청한 회원가입 의사 표시(이하 “이용 신청”이라 합니다)를 회사가 승낙함으로써 해결됩니다.\n2. 제1항의 승낙은 신청순서에 따라 순차적으로 처리되며, 회원가 입의 성립 시기는 회사의 회원가입이 완료되었음을 알리는 승 낙의 통지가 회원에게 도달하거나, 이에 준하는 권한이 회원에 게 부여되는 시점으로 합니다.\n3. 회사는 부정사용방지 및 본인확인을 위해 회원에게 소셜 인증을 요청할 수 있습니다.\n4. 회사는 가입 신청자의 이용신청에 있어 다음 각 호에 해당하는 경우, 이용신청을 영구적으로 승낙하지 않거나 유보할 수 있습 니다.\n• 회사가 정한 이용신청 요건에 충족되지 않을 경우\n• 제12조(금지행위)에 해당하는 행위를 하거나 해당하는 행 위를 했던 이력이 있을 경우\n• 회사의 기술 및 설비 상 서비스를 제공할 수 없는 경우\n• 기타 회사가 합리적인 판단에 의하여 필요하다고 인정하는 경우\n5. 회사는 제3항부터 제5항까지로 인해 발생한 피해에 대해 회사 의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지않습 니다."
        case .sixth:
            return "1. 회사는 관계 법령이 정하는 바에 따라 회원의 개인정보를 보호 하기 위해 노력합니다. 개인정보의 보호 및 이용에 관해서는 관 련 법령 및 회사의 개인정보 처리방침을 따릅니다.\n2. 회원은 개인정보에 변동이 있을 경우, 즉시 ”내 정보” 메뉴 및 문 의 창구를 이용하여 정보를 최신화해야 합니다.\n3. 회원의 모든 개인정보의 관리책임은 본인에게 있으므로, 타인에게 양도 및 대여할 수 없으며 유출되지 않도록 관리해야 합니다. 만약 본인의 계정을 타인이 사용하고 있음을 인지했을 경우, 즉시 문의 창구로 알려야 하고, 안내가 있는 경우 이에 따라야 합니다.\n4. 회사는 회원이 제2항과 제3항을 이행하지 않아 발생한 피해에 대해, 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지않습니다."
        case .seventh:
            return "1. 회원은 언제든지 본인의 계정으로 로그인한 뒤 서비스 내부의 ”탈퇴하기” 버튼을 누르는 방법으로 탈퇴를 요청할 수 있으며, 그외 문의 창구 등을 통한 탈퇴 요청은 처리되지 않습니다. 회사는 해당 요청을 확인한 후 탈퇴를 처리합니다.\n2. 탈퇴 처리가 완료 되면, 회원이 작성한 게시글과 댓글 등은 모두 삭제됩니다.\n3. 회사는 회원이 제12조(금지행위)에 해당하는 행위를 하거나 해 당하는 행위를 했던 이력이 있을 경우, 제13조(서비스 제공의 중단 및 서비스 이용계약의 해지)에 따라 서비스 제공을 중단하 거나 서비스 이용계약을 해지할 수 있습니다.\n4. 회사는 제1항부터 제4항까지로 인해 발생한 피해에 대해 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습 니다."
        case .eighth:
            return "1. 회사가 회원에 대한 통지가 필요한 경우, 서비스 내부 알림 수단을 이용할 수 있습니다.\n2. 회사가 회원에게 ”30일 이내에 의사를 표시하지 아니할 경우 동의한 것으로 간주한다”는 내용을 고지하였음에도 불구하고 회원이 의사를 표시하지 아니하면, 회사는 통지 내용에 동의한 것으로 간주합니다."
        case .ninth:
            return "1. 회사는 유용하고 편리한 서비스를 제공하기 위해, 2022년부터 서비스 및 서비스 내부의 기능(커뮤니티)의 체계를 직접 설계 및 운영하고 있는 데이터베이스 제작자에 해당합니다. 회사는 저작권법에 따라 데이터베이스 제작자는 복제권 및 전송권 을 포함한 데이터베이스 전부에 대한 권리를 가지고 있으며, 이 는 법률에 따라 보호를 받는 대상입니다. 그러므로 이용자는 데 이터베이스 제작자인 회사의 승인 없이 데이터베이스의 전부 또는 일부를 복제•배포 방송 또는 전송할 수 없습니다.\n2. 회사가 작성한 게시물에 대한 권리는 회사에 귀속되며, 회원이 작성한 게시물에 대한 권리는 회원에게 귀속됩니다.\n3. 회원이 서비스에 게시물을 작성하는 경우 해당 게시물은 서비 스에 노출될 수 있고 필요한 범위 내에서 사용, 저장, 복제, 수정, 공중송신, 전시, 배포 등의 방식으로 해당 게시물을 이용할 수 있도록 허락하는 전 세계적인 라이선스를 회사에 제공하게 됩 니다. 이 경우, 회사는 저작권법을 준수하며 회원은 언제든지 문 의 창구 및 서비스 내부의 관리 기능이 제공되는 경우에는 해당 관리 기능을 이용하여 가능한 범위에 한해 해당 게시물에 대한 삭제, 수정, 비공개 등의 조치를 취할 수 있습니다.\n4. 회사는 제3항 이외의 방법으로 회원의 게시물을 이용할 경우, 해당 회원으로부터 개별적이고 명시적인 동의를 받아야 합니다."
        case .tenth:
            return "1. 누구든지 게시물로 인해 사생활 침해나 명예훼손 등 권리가 침 해된 경우 회사에 해당 게시물의 삭제 또는 반박내용의 게재를 요청할 수 있습니다. 이 때 회사는 해당 게시물을 삭제할 수 있 으며, 만약 권리 침해 여부가 불분명하거나 당사자 간 다툼이 예 상될 경우에는 해당 게시물에 대한 접근을 30일간 임시적으로 차단하는 조치를 취할 수 있습니다.\n2. 회사가 제1항에 따라 회원의 게시물을 삭제하거나 접근을 임시 적으로 차단하는 경우, 해당 게시물이 작성된 커뮤니티에 필요 한 조치를 한 사실을 명시하고, 불가능한 사유가 없을 경우 이를 요청한 자와 해당 게시물을 작성한 회원에게 그 사실을 통지합니다."
        case .eleventh:
            return "\n1. 이용자는 다음과 같은 행위를 해서는 안됩니다.\n- 성적 도의관념에 반하는 행위\n- 정보통신망 이용촉진 및 정보보호 등에 관한 법률에 따 른 유해정보 유통 행위\n- 전기통신사업법에 따른 불법촬영물등 유통 행위\n- 청소년보호법에 따른 청소년유해매체물 유통 행위\n- 방송통신심의위원회의 정보통신에 관한 심의규정에 따른 심의기준의 성적 도의관념에 반하는 행위\n- 커뮤니티 이용규칙 금지행위에 따른 불건전 만남, 유흥, 성매매등 내용 유통 행위\n- 이 약관이 적용되는 서비스 및 기능과 동일하거나 유사한 서비스 및 기능에 대한 직•간접적 홍보 행위\n- 인천대학교와 관련 없는 서비스, 브랜드, 사이트, 애플리케이션, 사업체, 단체 등 을 알리거나 가입, 방문을 유도하기 위한 직.간접적 홍 보행위\n- 계정 판매 및 공유, 대리 게시, 서포터즈 등을 통해 학교에 다발적으로 게시되는 동일한 주제에 대한 직 간접적 홍보 행위\n- 비상업적 목적의 인천대학교와 관련된 게시글 등 커뮤니티 이용규칙 금지행위에 따른 홍보 및 판매 행위\n- 개인정보 또는 계정 기만, 침해, 공유 행위\n- 개인정보를 허위, 누락, 오기, 도용하여 작성하는 행위\n- 타인의 개인정보 및 계정을 수집, 저장, 공개, 이용하는 행위\n- 자신과 타인의 개인정보를 제3자에게 공개, 양도, 승계 하는 행위\n- 다중 계정을 생성 및 이용하는 행위\n- 자신의 계정을 이용하여 타인의 요청을 이행하는 행위\n- 시스템 부정행위\n- 프로그램, 스크립트, 봇을 이용한 서비스 접근 등 사람 이 아닌 컴퓨팅 시스템을 통한 서비스 접근 행위\n- API 직접 호출, 유저 에이전트 조작, 패킷 캡처, 비정상 적인 반복 조회 및 요청 등 허가하지 않은 방식의 서비 스이용 행위\n- 회사의 모든 재산에 대한 침해 행위\n- 업무 방해 행위\n- 서비스 관리자 또는 이에 준하는 자격을 허가 없이 취 득하여 권한을 행사하거나, 사칭하여 허위의 정보를 발 설하는 행위\n- 회사 및 타인의 명예를 훼손하거나 기타 업무를 방해하 는 행위\n- 서비스 내부 정보 일체를 허가 없이 이용, 변조, 삭제 및 외부로 유출하는 행위\n- 기타 현행법에 어긋나거나 부적절하다고 판단되는 행위\n2. 이용자는 제1항에 기재된 내용 외에 이 약관과 커뮤니티 이용규칙에서 규정한 내용에 반하는 행위를 해서는 안됩니다.\n3. 이용자가 제1항에 해당하는 행위를 할 경우, 회사는 이 약관 제 13조(서비스 제공의 중단 및 서비스 이용계약의 해지)에 따라 서비스 제공을 중단하거나 서비스 이용계약을 해지할 수 있습니다."
        case .twelfth:
            return "1. 이용자가 이 약관 및 커뮤니티 이용규칙에서 이 조항 적용이 명 시된 금지행위 및 이에 준하는 행위를 할 경우, 회사는 서비스 보호를 위해 다음과 같은 조치를 최대 영구적으로 취할 수 있습니다.\n- 회원의 서비스 이용 권한, 자격, 혜택 제한 및 회수\n- 회원과 체결된 이용계약의 해지\n- 회원의 커뮤니티, 게시물, 닉네임, 프로필 사진, 이용 기록을 삭제, 중단, 수정, 변경\n- 그외 서비스의 정상적인 운영을 위해 회사가 필요하다고 판단되는 조치\n2. 회사는 서비스 제공 중단 및 서비스 이용계약 해지 시, 서비스 내부 알림 수단을 통하여 그 사실을 사유와 함께 개별 통지합니다. 회원은 해당 통지를 받은 날로부터 7일 이내에 문의 창구로 이의를 제기할 수 있습니다.\n3. 회사는 이용자의 귀책 사유로 인한 서비스 제공 중단 및 서비스 이용계약의 해지로 인해 발생한 피해에 대해 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습니다."
            
        case .thirteenth:
            return "1. 회사와 이용자 간에 발생한 분쟁에 관한 소송은 민사소송법상의 관할 법원에 제소합니다\n2. 회사와 이용자 간에 제기된 소송에는 대한민국 법을 준거법으로 합니다."
        case .fourteenth:
            return "1. 이 약관에도 불구하고, 회사와 이용자가 이 약관의 내용과 다르게 합의한 사항이 있는 경우에는 해당 내용을 우선으로 합니다\n2. 회사는 필요한 경우 약관의 하위 규정을 정할 수 있으며, 이 약 관과 하위 규정이 상충하는 경우에는 이 약관의 내용이 우선 적용됩니다.\n3. 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 관련법 또는 관례에 따릅니다."
        }
    }
}

class ServiceViewModel {
    
    var service: [Service] = Service.allCases
    
    var numOfCell: Int {
        return service.count
    }
    
    func titileOfCell(index: Int) -> String {
        return service[index].title
    }
    
    func bodyOfCell(index: Int) -> String {
        return service[index].body
    }
    
    func sizeOfCell(index: Int, width: CGFloat) -> CGFloat {
                
        let titleLabel = UILabel()
        titleLabel.frame.size.width = width - 40
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.text = service[index].title
        titleLabel.sizeToFit()

        let bodyLabel = UILabel()
        bodyLabel.frame.size.width = width - 40
        bodyLabel.numberOfLines = 0
        bodyLabel.text = service[index].body
        bodyLabel.font = .systemFont(ofSize: 16)
        bodyLabel.sizeToFit()
        
        return CGFloat(titleLabel.frame.size.height + bodyLabel.frame.size.height + 40)
    }
}
