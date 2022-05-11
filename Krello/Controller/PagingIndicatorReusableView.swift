//
//  PagingIndicatorReusableView.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/10.
//

import UIKit

class PagingIndicatorReusableView: UICollectionReusableView {

    static let identifier = "PagingIndicatorReusableView"

    let pageSize = 3
    var pageControl: UIPageControl!

    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }

    private func createSubviews() {
        pageControl = UIPageControl(frame: self.bounds)
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.numberOfPages = pageSize
        pageControl.currentPage = 0
        self.addSubview(pageControl)
    }

    func configure(numberOfPages: Int) {
        pageControl.currentPage = numberOfPages
    }
}
