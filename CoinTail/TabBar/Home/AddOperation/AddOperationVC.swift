//
//  AddOperationVC.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import EasyPeasy


class AddOperationVC: BasicVC {
    
    var operationID: Int?
    var categoryID: Int?
    var subcategoryID: Int?
    var account: Account?
    var currency: Currency = Currencies.shared.selectedCurrency
    var currentIndex = 0
    
    let addOperationTypeSwitcher: UISegmentedControl = {
        let switcher = UISegmentedControl(items: [
            RecordType.income.rawValue,
            RecordType.expense.rawValue
        ])
        
        return switcher
    }()
    var addOperationSegment: RecordType = .income
    
    let amountLabel = UILabel(text: "Amount".localized(), alignment: .left)
    let descriptionLabel = UILabel(text: "Description".localized(), alignment: .left)
    let dateLabel = UILabel(text: "Date".localized(), alignment: .left)
    
    static let todayText = "Today".localized()
    
    let amountTF = UITextField(
        defaultText: "0.00",
        background: .lightGray.withAlphaComponent(0.2),
        keyboard: .decimalPad,
        placeholder: "Enter your value".localized()
    )
    let descriptionTF = UITextField(
        background: .clear,
        keyboard: .default,
        placeholder: "For example: Bought in the store".localized()
    )
    let dateTF: UITextField = {
        let todayString = operationDF.string(from: Date())

        let textField  = UITextField(
            defaultText: "\(todayText) \(todayString)",
            background: .clear,
            keyboard: .numberPad,
            placeholder: "Select date".localized()
        )
        textField.inputView = operationDatePicker
        textField.inputAccessoryView = createToolbar()
        textField.tintColor = .clear
        
        return textField
    }()
    
    static let operationDF: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter
    }()
    
    static let operationDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.timeZone = NSTimeZone.local
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        
        return picker
    }()
    
    static let defaultCategory = "Select category".localized()
    static let defaultAccount = "Select account".localized()
    
    let categoryButton = UIButton(
        name: defaultCategory,
        background: .clear,
        textColor: .black
    )
    let accountButton = UIButton(
        name: defaultAccount,
        background: .clear,
        textColor: .black
    )
    let currencyButton = UIButton(
        name: "\(Currencies.shared.selectedCurrency)",
        background: .clear,
        textColor: .black
    )
    let saveOperationButton = UIButton(
        name: "Save operation".localized(),
        background: .black,
        textColor: .white
    )
    
    public required init(segmentIndex: Int) {
        addOperationTypeSwitcher.selectedSegmentIndex = segmentIndex
        addOperationSegment = segmentIndex == 0 ? .income : .expense
        amountTF.text = segmentIndex == 0 ? "0.00" : "-0.00"
        
        super.init(nibName: nil, bundle: nil)
        
        addOperationNavBar()
        
        self.title = "Add new operation".localized()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(operationID: Int) {
        self.operationID = operationID
        
        super.init(nibName: nil, bundle: nil)
        
        // Передаем значения операции из редактируемой ячейки
        guard let record = Records.shared.getRecord(for: operationID) else { return }
        
        categoryID = record.categoryID
        amountTF.text = "\(record.amount)"
        descriptionTF.text = record.descriptionText
        guard let category = Categories.shared.getCategory(for: record.categoryID) else { return }
        categoryButton.setTitle(category.name, for: .normal)
        accountButton.setTitle(record.account?.name ?? AddOperationVC.defaultAccount, for: .normal)
        currencyButton.setTitle("\(record.currency)", for: .normal)
        saveOperationButton.setTitle("Edit operation", for: .normal)
        dateTF.text = Self.operationDF.string(from: record.date)
        addOperationSegment = record.type
        addOperationTypeSwitcher.selectedSegmentIndex = addOperationSegment == .income ? 0 : 1
        addOperationTypeSwitcher.isHidden = true
        
        self.title = "Editing operation".localized()
                
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: #selector (removeOperation)
        )
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountTF.delegate = self
        dateTF.delegate = self
        
        setAddOpStack() // Stack'и для view на экране
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setTargets() // Таргеты для кнопок
    }
    
}
