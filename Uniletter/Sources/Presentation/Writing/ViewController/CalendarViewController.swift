//
//  CalendarViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/23.
//

import UIKit
import FSCalendar

final class CalendarViewController: BaseViewController {
    
    // MARK: - Property
    
    private let calendarView = CalendarView()
    private let writingManager = WritingManager.shared
    var delegate: DateSetDelegate?
    var style: Style!
    var selectedDate: Date!
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = calendarView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCalendar()
    }
    
    // MARK: - Configure
    
    override func configureViewController() {
        calendarView.titleLabel.text = style == .start ? "모집 시작일" : "모집 마감일"
        
        calendarView.leftButton.addTarget(
            self,
            action: #selector(didTapLeftButton),
            for: .touchUpInside)
        calendarView.rightButton.addTarget(
            self,
            action: #selector(didTapRightButton),
            for: .touchUpInside)
        calendarView.cancelButton.addTarget(
            self,
            action: #selector(didTapCancleButton),
            for: .touchUpInside)
        calendarView.okButton.addTarget(
            self,
            action: #selector(didTapOKButton),
            for: .touchUpInside)
    }
    
    private func configureCalendar() {
        formatYearDate(Date())
        calendarView.calendar.delegate = self
        calendarView.calendar.dataSource = self
    }
    
    // MARK: - Func
    
    private func formatYearDate(_ date: Date) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "YYYY MMMM"
        
        let result = formatter.string(from: date)
        
        calendarView.yearMonthLabel.text = result
    }
    
    private func moveCurruntPage(_ moveUp: Bool) {
        var currentPage = calendarView.calendar.currentPage
        var dateComponents = DateComponents()
        
        dateComponents.month = moveUp ? 1 : -1
        currentPage = Calendar.current.date(
            byAdding: dateComponents,
            to: currentPage)!
        
        calendarView.calendar.setCurrentPage(currentPage, animated: true)
    }
    
   private func compareDates(_ date: Date) -> Bool {
        let first = CustomFormatter.dateToString(date)
        let second = CustomFormatter.dateToString(Date())
        
        return CustomFormatter.subDateString(first) == CustomFormatter.subDateString(second)
    }
    
    // MARK: - Action
    
    @objc private func didTapLeftButton() {
        moveCurruntPage(false)
    }
    
    @objc private func didTapRightButton() {
        moveCurruntPage(true)
    }
    
    @objc private func didTapCancleButton() {
        self.dismiss(animated: true)
    }
    
    @objc private func didTapOKButton() {
        let dateStr = CustomFormatter.dateToString(selectedDate)
        delegate?.setDate(date: CustomFormatter.dateToString(selectedDate), style: style)
        
        if style == .start {
            writingManager.startDate = dateStr
        } else {
            writingManager.endDate = dateStr
        }
        
        self.dismiss(animated: true)
    }
    
}

// MARK: - FSCalendar

extension CalendarViewController: FSCalendarDelegate,
                                  FSCalendarDataSource,
                                  FSCalendarDelegateAppearance {
    
    func calendar(
        _ calendar: FSCalendar,
        didSelect date: Date,
        at monthPosition: FSCalendarMonthPosition)
    {
        selectedDate = date
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        formatYearDate(calendar.currentPage)
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return compareDates(date) ? 1 : 0
    }
    
    func calendar(
        _ calendar: FSCalendar,
        willDisplay cell: FSCalendarCell,
        for date: Date,
        at monthPosition: FSCalendarMonthPosition)
    {
        cell.eventIndicator.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    }
    
    func calendar(
        _ calendar: FSCalendar,
        appearance: FSCalendarAppearance,
        eventOffsetFor date: Date)
    -> CGPoint {
        return CGPoint(x: 9, y: -29)
    }
    
    func calendar(
        _ calendar: FSCalendar,
        appearance: FSCalendarAppearance,
        eventDefaultColorsFor date: Date)
    -> [UIColor]? {
        return [UIColor.red]
    }
    
    func calendar(
        _ calendar: FSCalendar,
        appearance: FSCalendarAppearance,
        eventSelectionColorsFor date: Date)
    -> [UIColor]? {
        return [UIColor.red]
    }
    
}
