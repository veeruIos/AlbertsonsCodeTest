//
//  InitialViewController.swift
//  AlbertsonsCodeVeeru
//
//  Created by Suthari, Veerabrahmam on 1/20/23.
//

import UIKit

class InitialViewController: UIViewController {
    private lazy var homeView = HomeView()
    private let errorMessage = "Something went wrong. Please try again"

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.resetRandomNumber(isPortrait: UIWindow.isPortrait)
        getData()
        setUpUI()
        addGestureRecognizer()
        view.backgroundColor = .systemGray3
    }
    
    func addGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.getData))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
    }

    func setUpUI() {
        view.addSubview(homeView)
        let guild = view.safeAreaLayoutGuide
        homeView.topAnchor.constraint(equalTo: guild.topAnchor, constant: 20).isActive = true
        homeView.leftAnchor.constraint(equalTo: guild.leftAnchor, constant: 20).isActive = true
        homeView.rightAnchor.constraint(equalTo: guild.rightAnchor, constant: -20).isActive = true
        homeView.bottomAnchor.constraint(equalTo: guild.bottomAnchor, constant: -20).isActive = true
        homeView.changeAxis(isPortrait: UIWindow.isPortrait)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        NetworkManager.resetRandomNumber(isPortrait: UIDevice.current.orientation.isPortrait)
        homeView.changeAxis(isPortrait: UIDevice.current.orientation.isPortrait)
    }
}

extension InitialViewController {
    @objc func getData () {
        view.isUserInteractionEnabled = false
        NetworkManager.getRandomFact { fact in
            DispatchQueue.main.async {
                self.homeView.updateLabel(title: fact.isEmpty ? self.errorMessage : fact)
                self.view.isUserInteractionEnabled = true
            }
        }
        
        guard let urlValue = URL(string: NetworkManager.randomImageUrl()) else {return}
        self.homeView.updateImage(urlValue: urlValue)
    }
}


