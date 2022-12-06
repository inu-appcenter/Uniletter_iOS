//
//  InfoStackView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/11/24.
//

import UIKit
import MarqueeLabel
import SnapKit

enum Subjects: String {
    case category = "카테고리"
    case start = "시작일시"
    case end = "마감일시"
    case target = "모집대상"
    case contact = "문의사항"
    case link = "신청링크"
}

final class InfoStackView: UIStackView {
    
    // MARK: - UI
    
    let categoryLabel = DetailContesntsLabel()
    let startLabel = DetailContesntsLabel()
    let endLabel = DetailContesntsLabel()
    
    lazy var targetLabel = createMarqueeLabel(false)
    lazy var contactLabel = createMarqueeLabel(false)
    lazy var linkLabel = createMarqueeLabel(true)
    
    lazy var categoryStackView = createStackView(.category, categoryLabel)
    lazy var startStackView = createStackView(.start, startLabel)
    lazy var endStackView = createStackView(.end, endLabel)
    lazy var targetStackView = createStackView(.target, targetLabel)
    lazy var contactStackView = createStackView(.contact, contactLabel)
    lazy var linkStackView = createStackView(.link, linkLabel)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        spacing = 16
        addViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func addViews() {
        [
            categoryStackView,
            startStackView,
            endStackView,
            targetStackView,
            contactStackView,
            linkStackView
        ]
            .forEach { addArrangedSubview($0) }
    }
    
    // MARK: - Func
    
    private func createMarqueeLabel(_ isLink: Bool) -> MarqueeLabel {
        let label = MarqueeLabel()
        label.font = .systemFont(ofSize: 16)
        label.speed = .duration(20)
        label.isUserInteractionEnabled = isLink
        
        return label
    }
    
    private func createStackView(_ subject: Subjects, _ contentsLabel: UILabel) -> UIStackView {
        let subjectLabel = UILabel()
        subjectLabel.changeDetail(subject.rawValue)
        
        let stackView = UIStackView()
        stackView.spacing = 20
        
        [subjectLabel, contentsLabel]
            .forEach { stackView.addArrangedSubview($0) }
        
        subjectLabel.setContentHuggingPriority(.required, for: .horizontal)
        subjectLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return stackView
    }
    
    func validateInfo() {
        categoryStackView.isHidden = (categoryLabel.text?.isEmpty)!
        contactStackView.isHidden = (contactLabel.text?.isEmpty)!
        linkStackView.isHidden = (linkLabel.text?.isEmpty)!
    }
    
}
