//
//  CreateCategoryActions.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import RealmSwift


extension CreateCategoryVC {
    
    // Проверка на наличие текста и выбранной иконки, вывод ошибки или закрытие PopVC
    @objc func createCategoryAction() {
        let categoryName = categoryName ?? ""
        let categoryIcon = categoryIcon ?? ""
        let mainCategoryName = mainCategoryName ?? ""

        let isSubcategory = isToggleOn
        let randomColor = UIColor.randomColor().toHex()
                
        categoryValidation(name: categoryName, icon: categoryIcon, mainCategory: mainCategoryName, isSubcategory: isSubcategory) { [weak self] categoryName, categoryIcon in
            guard let strongSelf = self else { return }
            
            //TODO: сделать редактирование подкатегории
                if isSubcategory {
                    let subcategory = SubcategoryClass()
                    subcategory.name = categoryName
                    subcategory.color = randomColor
                    subcategory.image = categoryIcon
                                        
                    guard let categoryID = strongSelf.categoryID else { return }
                    
                    if strongSelf.isEditingSubcategory {
                        guard let parentalCategoryID = Categories.shared.getSubcategory(for: categoryID)?.parentCategory else { return }
                                                
                        subcategory.id = categoryID
                        subcategory.parentCategory = parentalCategoryID
                        
                        Categories.shared.editSubcategory(replacingSubcategory: subcategory)
                    } else {
                        subcategory.parentCategory = categoryID
                        
                        Categories.shared.addNewSubcategory(subcategory: subcategory, for: categoryID)
                    }
                } else {
                    let category = CategoryClass()
                    category.name = categoryName
                    category.color = randomColor
                    category.image = categoryIcon
                    category.type = strongSelf.segmentTitle
                    
                    if let categoryID = strongSelf.categoryID {
                        category.id = categoryID
                        
                        Categories.shared.editCategory(replacingCategory: category)
                    } else {
                        Categories.shared.addNewCategory(category)
                    }
                }

            strongSelf.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func goToSelectCategoryVC() {
        guard let segmentTitle = segmentTitle else { return }
        
        let vc = SelectCategoryVC(segmentTitle: segmentTitle, isParental: false, categoryID: nil)
        vc.categoryDelegate = self
        
        present(vc, animated: true)
    }
    
    @objc func removeCategory(_ sender: UIButton) {
        guard let id = categoryID,
              let categoryOrSubcategory = Categories.shared.getGeneralCategory(for: id) else { return }

        confirmationAlert(
            title: "Delete category".localized(),
            message: "Are you sure?".localized(),
            confirmActionTitle: "Confirm".localized()
        ) { [weak self] in
            if let category = categoryOrSubcategory as? CategoryClass {
                Categories.shared.deleteCategory(for: category.id) { success in
                    if success {
                        self?.navigationController?.popToRootViewController(animated: true)
                    } else { return }
                }
            } else if let subcategory = categoryOrSubcategory as? SubcategoryClass {
                Categories.shared.deleteSubcategory(for: subcategory.id) { success in
                    if success {
                        self?.navigationController?.popToRootViewController(animated: true)
                    } else { return }
                }
            }
        }
    }

}
