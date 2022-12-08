//
//  TimePickerViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/23.
//

import UIKit
import Then

class TimePickerViewController: BaseViewController {
    
    // MARK: - Property
    
    private let timePickerView = TimePickerView()
    private let writingManager = WritingManager.shared
    private let hours = [Int](1...12)
    private let minutes = [Int](0...11).map { $0 * 5 }
    private let timeUnits = ["오전", "오후"]
    var style: Style!
    var delegate: TimeSetDelegate?
    var hour = 6
    var minute = 0
    var timeUnit = "오후"
    var isPM: Bool?
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = timePickerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerView()
    }
    
    // MARK: - Configure
    
    override func configureViewController() {
        timePickerView.titleLabel.text = style == .start
        ? "시작시간 선택" : "마감시간 선택"
        
        timePickerView.cancleButton.addTarget(
            self,
            action: #selector(didTapCancleButton),
            for: .touchUpInside)
        timePickerView.okButton.addTarget(
            self,
            action: #selector(didTapOKButton),
            for: .touchUpInside)
    }
    
    private func configurePickerView() {
        timePickerView.pickerView.delegate = self
        timePickerView.pickerView.dataSource = self
        timePickerView.pickerView.selectRow(
            503 + hour,
            inComponent: 0,
            animated: false)
        timePickerView.pickerView.selectRow(
            504 + (minute / 5),
            inComponent: 1,
            animated: false)
        
        if let isPM = isPM {
            timeUnit = isPM ? "오후" : "오전"
            timePickerView.pickerView.selectRow(
                isPM ? 1 : 0,
                inComponent: 2,
                animated: false)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.pickerView(
                self.timePickerView.pickerView,
                didSelectRow: 503 + self.hour,
                inComponent: 0)
            self.pickerView(
                self.timePickerView.pickerView,
                didSelectRow: 504 + (self.minute / 5),
                inComponent: 1)
            self.pickerView(
                self.timePickerView.pickerView,
                didSelectRow: self.timeUnit == "오후" ? 1 : 0,
                inComponent: 2)
        }
    }
    
    // MARK: - Func
    
    private func formatTime() -> String {
        return "\(hour.formatNumbers()):\(minute.formatNumbers())"
    }
    
    // MARK: - Action
    
    @objc private func didTapCancleButton() {
        self.dismiss(animated: true)
    }
    
    @objc private func didTapOKButton() {
        delegate?.setTime(
            time: formatTime() + " " + timeUnit,
            style: style)
        
        hour = timeUnit == "오후" && hour != 12 ? hour + 12 : hour
        hour = timeUnit == "오전" && hour == 12 ? 0 : hour
        
        if style == .start {
            writingManager.startTime = formatTime() + ":00"
        } else {
            writingManager.endTime = formatTime() + ":00"
        }
        
        self.dismiss(animated: true)
    }
    
}

// MARK: - PickerView

extension TimePickerViewController: UIPickerViewDelegate,
                                    UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int)
    -> Int
    {
        switch component {
        case 0: return hours.count * 1000
        case 1: return minutes.count * 1000
        case 2: return timeUnits.count
        default: return 0
        }
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int)
    {
        switch component {
        case 0: hour = hours[row % hours.count]
        case 1: minute = minutes[row % minutes.count]
        case 2: timeUnit = timeUnits[row]
        default: break
        }
        
        let select = pickerView.view(forRow: row, forComponent: component) as? UILabel
        select?.textColor = .white
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        rowHeightForComponent component: Int)
    -> CGFloat
    {
        return 42
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        viewForRow row: Int,
        forComponent component: Int,
        reusing view: UIView?)
    -> UIView
    {
        pickerView.subviews.forEach {
            $0.backgroundColor = .clear
        }
        return UILabel(frame: CGRect(x: 0, y: 0, width: 56, height: 30)).then {
            $0.font = .systemFont(ofSize: 30)
            $0.layer.cornerRadius = 10
            $0.textColor = .customColor(.darkGray)
            
            switch component {
            case 0:
                $0.text = String(hours[row % hours.count])
                $0.textAlignment = .right
            case 1:
                $0.text = String(minutes[row % minutes.count])
                $0.textAlignment = .center
            case 2:
                $0.text = timeUnits[row]
                $0.textAlignment = .left
            default: break
            }
        }
    }
    
}
