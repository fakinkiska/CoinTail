//
//  AddNewOperationSetFuncs.swift
//  CoinTail
//
//  Created by Eugene on 24.10.22.
//

import UIKit
import EasyPeasy


extension AddNewOperationVC {
    
    // Настройки для кнопки
    func setButton(button: UIButton, text: String, background: UIColor, textColor: UIColor) {
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        
        button.backgroundColor = background
        button.layer.borderColor = UIColor.black.cgColor
        
        button.setTitleColor(textColor, for: .normal)
        button.setTitle(text, for: .normal)
        
        button.easy.layout([Height(56)])
    }
    
    // Настройки для пикера времени
    func setDatePickerButton(button: UIButton, picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let nowDate = dateFormatter.string(from: datePicker.date)
        
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = .systemBackground
        
        button.setTitle("Today, \(nowDate)", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.easy.layout([Height(56)])
    }
    
    // Настройки для текстового поля
    func setTextField(textField: UITextField, text: String, background: UIColor, keyboard: UIKeyboardType, default_text: String?) {
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        
        textField.autocorrectionType = .no
        textField.backgroundColor = background
        textField.keyboardType = keyboard
        textField.placeholder = text
        textField.text = default_text
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.easy.layout([Height(56)])
    }
    
    // Настройки для свитчера
    func setSwitchButton(switcher: UISegmentedControl) {
        switcher.layer.cornerRadius = 8
        switcher.easy.layout([Height(32)])
    }
    
    // Настройки для текста
    func setLabel(label: UILabel, text: String) {
        label.text = text
        label.textAlignment = .left
    }
    
    // Настройки для текстового поля с пикером даты
    func setDatePickerTextField(textField: UITextField, picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        textField.inputView = picker
        textField.layer.borderColor = UIColor.gray.cgColor
        let nowDate = dateFormatter.string(from: datePicker.date)
        textField.text = "Today, \(nowDate)"
        textField.placeholder = "Select a date"
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.easy.layout([Height(56)])
        textField.inputAccessoryView = createToolbar()
    }
    
//    func setDatePickerTextField(dateField: UIView, picker: UIDatePicker) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .none
//
////        dateField.inputView = picker
//        dateField.layer.borderColor = UIColor.gray.cgColor
//        let nowDate = dateFormatter.string(from: datePicker.date)
////        dateField.placeholder = "Today, \(nowDate)"
//        dateField.layer.cornerRadius = 8
//        dateField.layer.borderWidth = 1
////        dateField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: dateField.frame.height))
////        dateField.leftViewMode = .always
//        dateField.easy.layout([Height(56)])
////        dateField.inputAccessoryView = createToolbar()
//    }

    // Создание вертикального меню выше пикера времени с кнопками действия
    func createToolbar() -> UIToolbar { // Всплывающий снизу DatePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        toolbar.setItems([doneButton], animated: true)

        return toolbar
    }
    
}
