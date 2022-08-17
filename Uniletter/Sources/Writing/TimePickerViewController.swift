//
//  TimePickerViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/23.
//

import UIKit

class TimePickerViewController: UIViewController {
    
    // MARK: - Property
    let timePickerView = TimePickerView()
    let writingManager = WritingManager.shared
    var style: Style!
    var delegate: TimeSetDelegate?
    let hours = [Int](1...12)
    let minutes = [Int](0...11).map { $0 * 5 }
    let timeUnits = ["AM", "PM"]
    var hour = 6
    var minute = 0
    var timeUnit = "PM"
    var isPM: Bool?
    
    // MARK: - Life cycle
    override func loadView() {
        view = timePickerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }
    
    // MARK: - Setup
    func setViewController() {
        timePickerView.titleLabel.text = style == .start
        ? "시작시간 선택" : "마감시간 선택"
        
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
            timeUnit = isPM ? "PM" : "AM"
        }
        
        timePickerView.pickerView.selectRow(
            timeUnit == "PM" ? 1 : 0,
            inComponent: 2,
            animated: false)
        
        timePickerView.cancleButton.addTarget(
            self,
            action: #selector(didTapCancleButton(_:)),
            for: .touchUpInside)
        timePickerView.okButton.addTarget(
            self,
            action: #selector(didTapOKButton(_:)),
            for: .touchUpInside)
        
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
                didSelectRow: self.timeUnit == "PM" ? 1 : 0,
                inComponent: 2)
        }
        
    }
    
    // MARK: - Funcs
    func formatNumbers(_ num: Int) -> String {
        return String(format: "%02d", num)
    }
    
    // MARK: - Actions
    @objc func didTapCancleButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func didTapOKButton(_ sender: UIButton) {
        let time = "\(formatNumbers(hour)):\(formatNumbers(minute))"
        
        delegate?.setTime(time: "\(time) \(timeUnit)", style: style)
        
        if style == .start {
            writingManager.startTime = "\(time):00"
        } else {
            writingManager.endTime = "\(time):00"
        }
        
        dismiss(animated: true)
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
        print("didSelectRow -> component: \(component), row: \(row)")
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
        
        let label: UILabel = {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 56, height: 30))
            label.font = .systemFont(ofSize: 30)
            label.layer.cornerRadius = 10
            label.textColor = UIColor.customColor(.darkGray)
            
            switch component {
            case 0:
                label.text = String(hours[row % hours.count])
                label.textAlignment = .right
            case 1:
                label.text = String(minutes[row % minutes.count])
                label.textAlignment = .center
            case 2:
                label.text = timeUnits[row]
                label.textAlignment = .left
            default: break
            }
            
            return label
        }()
        
        return label
    }
    
}
