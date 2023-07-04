//
//  CreateCategoryCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


extension CreateCategoryVC: UICollectionViewDataSource {
    
    // Количество ячеек для новых категорий
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CreateCategoryVC.newImages.count
    }
    
    // Ячейки заполняются
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = createCategoryCV.dequeueReusableCell(
            withReuseIdentifier: SelectCategoryCVCell.id,
            for: indexPath
        ) as? SelectCategoryCVCell else {
            fatalError("Unable to dequeue SelectCategoryCVCell.")
        }
        
        cell.categoryImage.image = UIImage(systemName: CreateCategoryVC.newImages[indexPath.row])
        cell.backView.backgroundColor = selectedColor ?? .white
        
        return cell
    }

}