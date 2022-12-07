//
//  InfoStackView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/11/24.
//

import UIKit
import MarqueeLabel
import SnapKit

final class InfoStackView: UIStackView {
    
    // MARK: - UI
    
    lazy var categoryLabel = createContentsLabel()
    lazy var startLabel = createContentsLabel()
    lazy var endLabel = createContentsLabel()
    
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
    
    private func createContentsLabel() -> UILabel {
        return UILabel().then {
            $0.font = .systemFont(ofSize: 16)
        }
    }
    
    private func createMarqueeLabel(_ isLink: Bool) -> MarqueeLabel {
        return MarqueeLabel().then {
            $0.font = .systemFont(ofSize: 16)
            $0.speed = .duration(20)
            $0.isUserInteractionEnabled = isLink
        }
    }
    
    private func createStackView(_ subject: Subjects, _ contentsLabel: UILabel) -> UIStackView {
        let subjectLabel = UILabel()
        subjectLabel.changeDetail(subject.title)
        
        let stackView = UIStackView()
        stackView.spacing = 20
        
        [subjectLabel, contentsLabel]
            .forEach { stackView.addArrangedSubview($0) }
        
        subjectLabel.setContentHuggingPriority(.required, for: .horizontal)
        subjectLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return stackView
    }
    
    func validateInfo() {
        contactStackView.isHidden = (contactLabel.text?.isEmpty)!
        linkStackView.isHidden = (linkLabel.text?.isEmpty)!
    }
    
}
