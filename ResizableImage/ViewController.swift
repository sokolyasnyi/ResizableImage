//
//  ViewController.swift
//  ResizableImage
//
//  Created by Станислав Соколов on 19.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    lazy private var imageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var topImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 270))
        imageView.image = UIImage(named: "background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy private var emptyContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        scrollView.scrollsToTop = true
        return scrollView
    }()
    
    lazy private var contentSize: CGSize = {
        CGSize(width: view.frame.width, height: 1000)
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
        
        scrollView.addSubview(imageContainer)
        scrollView.addSubview(emptyContainer)
        
        imageContainer.addSubview(topImageView)
        
        
        scrollView.delegate = self
    }
    
    private func setupConstraints() {
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        imageContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        imageContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageContainer.heightAnchor.constraint(equalTo: imageContainer.widthAnchor, multiplier: 0.7).isActive = true
        
        topImageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor).isActive = true
        let topImageViewTopAnchor = topImageView.topAnchor.constraint(equalTo: view.topAnchor)
        topImageViewTopAnchor.priority = .defaultHigh
        topImageViewTopAnchor.isActive = true
        
        topImageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor).isActive = true
        topImageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor).isActive = true
        heightImageViewConstraint = topImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: imageContainer.frame.height)
        heightImageViewConstraint.priority = .required
        heightImageViewConstraint.isActive = true
        
        
        emptyContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        emptyContainer.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 0).isActive = true
        emptyContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        emptyContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        
//        scrollView.scrollIndicatorInsets = view.safeAreaInsets
//        scrollView.contentInset = .init(top: 0, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
    }
}

extension ViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y

        if (self.lastContentOffset > y) {
            print("Move up \(y)")
        } else if (self.lastContentOffset < y) {
            print("Move down \(y)")
        }
        
        self.lastContentOffset = scrollView.contentOffset.y
        print(lastContentOffset)

//        let h: CGFloat
                
//        let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: h)
//        topImageView.frame = rect
//        heightImageViewConstraint = topImageView.heightAnchor.constraint(equalToConstant: h)
//        heightImageViewConstraint.isActive = true
    }
}

