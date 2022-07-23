//
//  TimePickerViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/23.
//

import UIKit
import SwiftUI

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
        
        timePickerView.cancleButton.addTarget(
            self,
            action: #selector(didTapCancleButton(_:)),
            for: .touchUpInside)
        timePickerView.okButton.addTarget(
            self,
            action: #selector(didTapOKButton(_:)),
            for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc func didTapCancleButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func didTapOKButton(_ sender: UIButton) {
        let time: String = {
            if timeUnit == "PM" {
                hour += 12
                if hour == 24 {
                    hour = 0
                }
            }
            
            return "\(hour):\(minute) \(timeUnit)"
        }()

        delegate?.setTime(time: time, style: style)
        
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
    -> Int {
        switch component {
        case 0: return hours.count * 10000
        case 1: return minutes.count * 10000
        case 2: return timeUnit.count
        default: break
        }
        
        return 0
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int) {
            switch component {
            case 0: hour = hours[row % hours.count]
            case 1: minute = minutes[row % minutes.count]
            case 2: timeUnit = timeUnits[row]
            default: break
            }
            
            pickerView.reloadComponent(component)
        }
    
    func pickerView(
        _ pickerView: UIPickerView,
        rowHeightForComponent component: Int)
    -> CGFloat {
        return 42
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        viewForRow row: Int,
        forComponent component: Int,
        reusing view: UIView?)
    -> UIView {
        pickerView.subviews.forEach {
            $0.backgroundColor = .clear
        }
        
        let label: UILabel = {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 56, height: 30))
            label.font = .systemFont(ofSize: 30)
            label.layer.cornerRadius = 10
            
            switch component {
            case 0:
                label.text = String(hours[row % hours.count])
                label.textAlignment = .right
            case 1:
                label.text = String(minutes[row % minutes.count])
                label.textAlignment = .center
            case 2:
                label.text = String(timeUnits[row])
            default: break
            }
            
            return label
        }()
        
        if pickerView.selectedRow(inComponent: component) == row {
            label.textColor = .white
        } else {
            label.textColor = UIColor.customColor(.darkGray)
        }
        
        return label
    }
    
}
