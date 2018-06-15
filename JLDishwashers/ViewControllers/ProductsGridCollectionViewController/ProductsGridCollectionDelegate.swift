//
//  ProductsGridCollectionDelegate.swift
//  JLDishwashers
//
//  Created by Murat Sudan on 15.06.2018.
//  Copyright © 2018 Tarum Nadus. All rights reserved.
//

import UIKit

/**
 * This ProductsGridCollectionDelegate class handles UICollectionViewDelegate protocol methods
 */
class ProductsGridCollectionDelegate: NSObject {
    let viewModel: ProductsGridViewModel
    
    init(viewModel: ProductsGridViewModel) {
        self.viewModel = viewModel
    }
}

//MARK: - UICollectionViewDelegate
extension ProductsGridCollectionDelegate: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition(rawValue: 0))
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

//MARK: - UIViewCollectionFlowLayoutDelegate
extension ProductsGridCollectionDelegate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.cellSize(width: 240.0, height: 330.0)
    }
}
