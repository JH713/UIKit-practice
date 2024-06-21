//
//  SelfSizingScrollView.swift
//  SelfSizingScrollView
//
//  Created by 이지현 on 6/21/24.
//

import UIKit

class SelfSizingScrollView: UIScrollView {
    
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        contentSize
    }
    
}
