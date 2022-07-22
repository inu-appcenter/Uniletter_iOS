//
//  CalendarView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/23.
//

import UIKit
import FSCalendar
import SnapKit

final class CalendarView: UIView {

    // MARK: - UI
    lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        
        // 영어로
        calendar.locale = Locale(identifier: "en_US")
        
        // 헤더 뷰 관련
        calendar.headerHeight = 0
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        
        // 날짜 관련
        calendar.appearance.weekdayTextColor = UIColor.customColor(.darkGray)
        calendar.appearance.weekdayFont = .systemFont(ofSize: 13)
        calendar.appearance.titleFont = .systemFont(ofSize: 14, weight: .medium)
        calendar.appearance.selectionColor = UIColor.customColor(.blueGreen)
        
        // Today 관련
        calendar.appearance.todayColor = .clear
        calendar.appearance.titleTodayColor = .black
        
        calendar.calendarWeekdayView.weekdayLabels[0].textColor = #colorLiteral(red: 0.9921568627, green: 0.231372549, blue: 0.1921568627, alpha: 1)
        calendar.calendarWeekdayView.weekdayLabels[6].textColor = #colorLiteral(red: 0.2666666667, green: 0.4274509804, blue: 1, alpha: 1)
        
        return calendar
    }()
    
    let subView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        
        return view
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.blueGreen)
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        
        return label
    }()
    
    let yearMonthLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        
        return label
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chevronLeft"), for: .normal)
        
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chevronRight"), for: .normal)
        
        return button
    }()
    
    lazy var cancleButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(UIColor.customColor(.lightGray), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        
        return button
    }()
    
    lazy var okButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(UIColor.customColor(.blueGreen), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black.withAlphaComponent(0.3)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setLayout()
    }
    
    // MARK: - Setup
    func addViews() {
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
            cancleButton,
            okButton,
        ]
            .forEach { subView.addSubview($0) }
        
        addSubview(subView)
    }
    
    func setLayout() {
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
            $0.bottom.equalTo(cancleButton.snp.top)
            $0.left.right.equalToSuperview().inset(14)
        }
        
        cancleButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-16)
            $0.right.equalTo(okButton.snp.left).offset(-20)
        }
        
        okButton.snp.makeConstraints {
            $0.centerY.equalTo(cancleButton)
            $0.right.equalToSuperview().offset(-20)
        }
    }
}
