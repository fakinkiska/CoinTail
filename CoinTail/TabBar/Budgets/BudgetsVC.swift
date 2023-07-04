//
//  BudgetsVC.swift
//  CoinTail
//
//  Created by Eugene on 21.06.23.
//

import UIKit


class BudgetsVC: BasicVC {
    
    let budgetCV: UICollectionView = {
        let budgetLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 8
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: budgetLayout)
        cv.backgroundColor = .clear
        cv.register(BudgetCell.self, forCellWithReuseIdentifier: BudgetCell.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.alwaysBounceVertical = true
        cv.delaysContentTouches = true
        return cv
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Budgets"
        
        budgetCV.dataSource = self
        
        budgetCV.delegate = self
        
        budgetSubviews()
        budgetNavBar()
    }
    
}
