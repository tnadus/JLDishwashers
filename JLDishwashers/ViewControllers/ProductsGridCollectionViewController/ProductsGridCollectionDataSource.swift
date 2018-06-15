//
//  ProductsGridCollectionDataSource.swift
//  JLDishwashers
//
//  Created by Murat Sudan on 15.06.2018.
//  Copyright © 2018 Tarum Nadus. All rights reserved.
//

import UIKit

/**
 * This ProductsGridCollectionDataSource class provides data to its provider
 */
class ProductsGridCollectionDataSource: NSObject {
    
    //MARK: Properties
    let viewModel: ProductsGridViewModel
    
    init(viewModel: ProductsGridViewModel) {
        self.viewModel = viewModel
    }
}

//MARK: Handling UICollectionViewDataSource callbacks
extension ProductsGridCollectionDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCellId", for: indexPath) as! ProductCell
        
        cell.descriptionLabel.attributedText = viewModel.cellTitle(indexPath: indexPath)
        
        let urlStr = viewModel.products.value[indexPath.row].imageURLPath
        cell.urlString = urlStr
        viewModel.loadImage(urlString: urlStr, completion: { img in
            if let image = img {
                if cell.urlString == urlStr {
                    cell.coverImgView.image = image
                }
            }
        })
        return cell
    }
}
