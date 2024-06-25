//
//  CollectionViewController.swift
//  SelfSizingScrollView
//
//  Created by 이지현 on 6/21/24.
//

import UIKit

class CollectionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
    }
    
}

extension UICollectionView {
    open override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    open override var intrinsicContentSize: CGSize {
        contentSize
    }
}
