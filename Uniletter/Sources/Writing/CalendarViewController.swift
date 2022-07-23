//
//  CalendarViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/23.
//

import UIKit
import FSCalendar

final class CalendarViewController: UIViewController {
    
    // MARK: - Property
    let calendarView = CalendarView()
    let writingManager = WritingManager.shared
    var delegate: DateSetDelegate?
    var style: Style!
    var selectedDate: Date!
    
    // MARK: - Life cycle
    override func loadView() {
        view = calendarView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }
    
    // MARK: - Setup
    func setViewController() {
        calendarView.titleLabel.text = style == .start
        ? "모집 시작일" : "모집 마감일"
        
        formatYearDate(Date())
        calendarView.calendar.delegate = self
        calendarView.calendar.dataSource = self
        
        calendarView.leftButton.addTarget(
            self,
            action: #selector(didTapLeftButton(_:)),
            for: .touchUpInside)
        calendarView.rightButton.addTarget(
            self,
            action: #selector(didTapRightButton(_:)),
            for: .touchUpInside)
        calendarView.cancleButton.addTarget(
            self,
            action: #selector(didTapCancleButton(_:)),
            for: .touchUpInside)
        calendarView.okButton.addTarget(
            self,
            action: #selector(didTapOKButton(_:)),
            for: .touchUpInside)
    }
    
    // MARK: - Funcs
    func formatYearDate(_ date: Date) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "YYYY MMMM"
        
        let result = formatter.string(from: date)
        
        calendarView.yearMonthLabel.text = result
    }
    
    func moveCurruntPage(_ moveUp: Bool) {
        var currentPage = calendarView.calendar.currentPage
        var dateComponents = DateComponents()
        
        dateComponents.month = moveUp ? 1 : -1
        currentPage = Calendar.current.date(
            byAdding: dateComponents,
            to: currentPage)!
        
        calendarView.calendar.setCurrentPage(currentPage, animated: true)
    }
    
    func compareDates(_ date: Date) -> Bool {
        let first = dateToString(date)
        let second = dateToString(Date())
        
        return subDateString(first) == subDateString(second)
        ? true : false
    }
    
    // MARK: - Actions
    @objc func didTapLeftButton(_ sender: UIButton) {
        moveCurruntPage(false)
    }
    
    @objc func didTapRightButton(_ sender: UIButton) {
        moveCurruntPage(true)
    }
    
    @objc func didTapCancleButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func didTapOKButton(_ sender: UIButton) {
        delegate?.setDate(date: dateToString(selectedDate), style: style)
        
        style == .start
        ? writingManager.setStartDate(dateToString(selectedDate))
        : writingManager.setEndDate(dateToString(selectedDate))
        
        dismiss(animated: true)
    }
}

extension CalendarViewController: FSCalendarDelegate,
                                  FSCalendarDataSource,
                                  FSCalendarDelegateAppearance {
    func calendar(
        _ calendar: FSCalendar,
        didSelect date: Date,
        at monthPosition: FSCalendarMonthPosition) {
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
        at monthPosition: FSCalendarMonthPosition) {
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
