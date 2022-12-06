//
//  CalendarView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/23.
//

import UIKit
import FSCalendar
import SnapKit
import Then

final class CalendarView: BaseView {

    // MARK: - UI
    
    lazy var calendar = FSCalendar().then {
        // 기본 설정
        $0.locale = Locale(identifier: "en_US")
        $0.placeholderType = .none
        
        // 헤더 뷰 관련
        $0.headerHeight = 0
        $0.appearance.headerMinimumDissolvedAlpha = 0
        
        // 날짜 관련
        $0.appearance.weekdayTextColor = .customColor(.darkGray)
        $0.appearance.weekdayFont = .systemFont(ofSize: 13)
        $0.appearance.titleFont = .systemFont(ofSize: 14, weight: .medium)
        $0.appearance.selectionColor = .customColor(.blueGreen)
        
        // Today 관련
        $0.appearance.todayColor = .clear
        $0.appearance.titleTodayColor = .black
        
        // 요일 색상 관련
        $0.calendarWeekdayView.weekdayLabels[0].textColor = #colorLiteral(red: 0.9921568627, green: 0.231372549, blue: 0.1921568627, alpha: 1)
        $0.calendarWeekdayView.weekdayLabels[6].textColor = #colorLiteral(red: 0.2666666667, green: 0.4274509804, blue: 1, alpha: 1)
    }
    
    private lazy var subView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }
    
    private lazy var topView = UIView().then {
        $0.backgroundColor = .customColor(.blueGreen)
    }
    
    lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textAlignment = .center
        $0.textColor = .white
    }
    
    lazy var yearMonthLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.textAlignment = .center
        $0.textColor = .white
    }
    
    lazy var leftButton = UIButton().then {
        $0.setImage(UIImage(named: "chevronLeft"), for: .normal)
    }
    
    lazy var rightButton = UIButton().then {
        $0.setImage(UIImage(named: "chevronRight"), for: .normal)
    }
    
    lazy var cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.customColor(.lightGray), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    lazy var okButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.customColor(.blueGreen), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    override func configureView() {
        backgroundColor = .black.withAlphaComponent(0.3)
    }
    
    override func configureUI() {
        [
            titleLabel,
            yearMonthLabel,
            leftButton,
            rightButton,
        ]
            .forEach { topView.addSubview($0) }
        
        [
            topView,
            calendar,
            cancelButton,
            okButton,
        ]
            .forEach { subView.addSubview($0) }
        
        addSubview(subView)
    }
    
    override func configureLayout() {
        subView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(406)
        }
        
        topView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(94)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        yearMonthLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-18)
            $0.centerX.equalToSuperview()
        }
        
        leftButton.snp.makeConstraints {
            $0.centerY.equalTo(yearMonthLabel)
            $0.left.equalToSuperview().offset(26)
        }
        
        rightButton.snp.makeConstraints {
            $0.centerY.equalTo(yearMonthLabel)
            $0.right.equalToSuperview().offset(-26)
        }
        
        calendar.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(20)
            $0.bottom.equalTo(cancelButton.snp.top)
            $0.left.right.equalToSuperview().inset(14)
        }
        
        cancelButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-16)
            $0.right.equalTo(okButton.snp.left).offset(-20)
        }
        
        okButton.snp.makeConstraints {
            $0.centerY.equalTo(cancelButton)
            $0.right.equalToSuperview().offset(-20)
        }
    }
    
}
