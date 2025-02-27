//
//  SplashViewController.swift
//  WalmartAsessment
//
//  Created by David Mottle on 2/26/25.
//


import UIKit

//MARK: - SplashViewController
class SplashViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Globe"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Countries List"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.alpha = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .gray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        animateSplashScreen()
    }
    
    private func setupUI() {
        view.addSubview(logoImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            
            welcomeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            activityIndicator.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 30),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    //MARK: - Animation
    private func animateSplashScreen() {
        activityIndicator.startAnimating()
        
        UIView.animate(withDuration: 1.5, delay: 0.3, options: .curveEaseInOut, animations: {
            self.welcomeLabel.alpha = 1
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.navigateToMainScreen()
            }
        }
    }
    
    //MARK: - Navigation to the Countries View Controller
    private func navigateToMainScreen() {
        let apiClient = APIClient.shared
        let viewModel = CountryViewModel(apiClient: apiClient)
        let mainVC = CountryViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: mainVC)
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            UIView.transition(with: sceneDelegate.window!,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                sceneDelegate.window?.rootViewController = navigationController
            })
        }
    }
}
