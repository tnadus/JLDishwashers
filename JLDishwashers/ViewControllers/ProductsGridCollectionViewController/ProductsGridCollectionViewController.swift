//
//  ProductsGridCollectionViewController.swift
//  JLDishwashers
//
//  Created by Murat Sudan on 15.06.2018.
//  Copyright © 2018 Tarum Nadus. All rights reserved.
//

import UIKit

/**
 *
 * This CollectionViewController shows dishwasher products in a grid of cells
 * Initialization of the ProductsGridCollectionViewController is done via Storyboard
 *
 */
class ProductsGridCollectionViewController: UICollectionViewController {
    
    //MARK: properties
    let viewModel = ProductsGridViewModel(productsAPI: JLProductsNetworkAPI())
    var spinner: UIActivityIndicatorView?
    
    lazy var dataSource: ProductsGridCollectionDataSource = {
        return ProductsGridCollectionDataSource(viewModel: viewModel)
    }()
    
    lazy var delegate: ProductsGridCollectionDelegate = {
        return ProductsGridCollectionDelegate(viewModel: viewModel)
    }()
    
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViews()
    }

    //MARK: Subviews methods
    func setupViews() {
        self.title = viewModel.title
        self.collectionView?.dataSource = dataSource
        self.collectionView?.delegate = delegate
        setupBarButton()
    }
    
    func setupBarButton() {
        self.spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        spinner?.backgroundColor = .darkGray
        spinner?.isOpaque = true
        spinner?.layer.cornerRadius = (spinner?.frame.width)!/2.0
        spinner?.layer.borderColor = UIColor.black.cgColor
        spinner?.layer.borderWidth = 1.0
        spinner?.hidesWhenStopped = true
        spinner?.startAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner!)
    }
    
    func bindViews() {
        viewModel.products.bind { [unowned self] _ in
            self.title = self.viewModel.title
            self.collectionView?.reloadData()
            self.spinner?.stopAnimating()
        }
    }
    
    //MARK: Memory management
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
