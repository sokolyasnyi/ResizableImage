//
//  ViewController.swift
//  ResizableImage
//
//  Created by Станислав Соколов on 19.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    lazy private var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = contentSize
        return scrollView
    }()
    
    lazy private var contentSize: CGSize = {
        CGSize(width: view.frame.width, height: 1270)
    }()
    
    private var heightImageViewConstraint: NSLayoutConstraint!
    private var lastContentOffset: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
        setupConstraints()

    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        view.addSubview(topImageView)
        
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self
    }
    
    private func setupConstraints() {
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        topImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        topImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        heightImageViewConstraint = topImageView.heightAnchor.constraint(equalToConstant: 270)
        heightImageViewConstraint.isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.scrollIndicatorInsets = .init(top: topImageView.bounds.height - 60,
                                                 left: view.safeAreaInsets.left,
                                                 bottom: view.safeAreaInsets.bottom,
                                                 right: view.safeAreaInsets.right)
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension ViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        let newHeight = max(270 - yOffset, 0)
        topImageView.removeConstraint(heightImageViewConstraint)
        heightImageViewConstraint = topImageView.heightAnchor.constraint(equalToConstant: newHeight)
        heightImageViewConstraint.isActive = true
    }
}

