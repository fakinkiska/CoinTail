//
//  AddBudgetUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 03.07.23.
//

import UIKit
import EasyPeasy


extension AddBudgetVC {
    
    func setupUI(with budget: BudgetClass) {
        if let categoryName = Categories.shared.getCategory(for: budget.categoryID)?.name {
            budgetCategory = categoryName
        }
        budgetCategoryID = budget.categoryID
        selectedCurrency = budget.currency
        budgetAmount = "\(budget.amount)"
        
        let calendar = Calendar.current
        let startDate = budget.startDate
        let untilDate = budget.untilDate
        let components = calendar.dateComponents([.day], from: startDate, to: untilDate)
        
        if let days = components.day {
            if days == 7 {
                budgetTimePeriod = "Week".localized()
            } else if days == 30 {
                budgetTimePeriod = "Month".localized()
            } else {
                return
            }
        }
        
        deleteBudgetButton.isHidden = false
    }
    
    func addBudgetSubviews() {
        self.view.addSubview(addBudgetCV)
        self.view.addSubview(deleteBudgetButton)
        
        let height: CGFloat = (budgetID != nil ? 3 : 4) * 48
        addBudgetCV.easy.layout([
            Left(16),
            Right(16),
            Top(32).to(self.view.safeAreaLayoutGuide, .top),
            Height(height)
        ])
        
        deleteBudgetButton.easy.layout([
            Left(16),
            Right(16),
            Top(24).to(addBudgetCV, .bottom),
            Height(52)
        ])
    }
    
    func addBudgetNavBar() {
        let title = budgetID != nil ? "Edit".localized() : "Save".localized()

        let saveButton = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(saveBudgetAction))
            
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    func updateCell(at indexPath: IndexPath, text: String) {
        if let cell = addBudgetCV.cellForItem(at: indexPath) as? AddBudgetCell {
            cell.updateSubMenuLabel(text)
        }
    }
    
}
