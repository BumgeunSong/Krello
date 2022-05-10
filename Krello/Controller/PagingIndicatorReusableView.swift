//
//  PagingIndicatorReusableView.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/10.
//

import UIKit

class PagingIndicatorReusableView: UICollectionReusableView {

    static let identifier = "PagingIndicatorReusableView"

    // Define the number of pages.
    let pageSize = 3
    var pageControl: UIPageControl!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
//        setupView()
    }

    private func configure() {
        pageControl = UIPageControl(frame: self.bounds)
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.numberOfPages = pageSize
        pageControl.currentPage = 0
        self.addSubview(pageControl)
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    private func setupView() {

          addSubview(pageControl)

      }

    func configure(with numberOfPages: Int) {
            pageControl.currentPage = numberOfPages
    }
}
