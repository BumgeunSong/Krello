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
    private lazy var pageControl: UIPageControl = {
            let control = UIPageControl()
            control.translatesAutoresizingMaskIntoConstraints = false
            control.isUserInteractionEnabled = true
            control.currentPageIndicatorTintColor = UIColor.black
//            control.pageIndicatorTintColor = .systemGray5
        control.numberOfPages = pageSize
        control.currentPage = 0
            return control
        }()

    override init(frame: CGRect) {
        super.init(frame: frame)
//        configure()
        setupView()
    }

    private func configure() {
        self.pageControl.frame = self.bounds
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
//          pageControl.numberOfPages = pageSize
//          pageControl.currentPage = 0
          addSubview(pageControl)

//          NSLayoutConstraint.activate([
//              pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
//              pageControl.centerYAnchor.constraint(equalTo: centerYAnchor)
//          ])
      }

    func configure(with numberOfPages: Int) {
            pageControl.numberOfPages = numberOfPages
    }
}
