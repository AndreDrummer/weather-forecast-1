//
//  ViewController.swift
//  weather-forecast-1
//
//  Created by Andre Silva on 19/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    private var backgroundImageName = "background"
    private var primaryColor = "appPrimaryColor"
    private var sunIcon = "sunIcon"
    
    
    private func cityName() -> String {
        return "Aparecida de Goiânia"
    }
    
    private func temperatureValue() -> String {
        return "\(32)ºC"
    }
    
    private func weatherIconName() -> String {
        return sunIcon
    }
    
    private lazy var customView: UIView = {
        let view = UIView(frame: .zero)
        
        return view
    }()
    
    private lazy var background: UIImageView = {
        let view = UIImageView(image: UIImage(named: backgroundImageName))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = cityName()
        label.textAlignment = .center
        label.textColor = UIColor(named: primaryColor)
        
        return label
    }()
    
    private lazy var temperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = temperatureValue()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 72, weight: .bold)
        label.textColor = UIColor(named: primaryColor)
        
        return label
    }()

    private lazy var weatherIcon: UIImageView = {
        let icon = UIImageView(image: UIImage(named: weatherIconName()))
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        return icon
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    
    private func setHierarchy() {
        view.addSubview(customView)
        customView.addSubview(background)
        customView.addSubview(headerView)
        headerView.addSubview(cityLabel)
        headerView.addSubview(temperature)
        headerView.addSubview(weatherIcon)
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            customView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            customView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            customView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35),
            headerView.heightAnchor.constraint(equalToConstant: 169),
        ])
        
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 16),
            cityLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            cityLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        NSLayoutConstraint.activate([
            temperature.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 21),
            temperature.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 26),
        ])
        
        
        NSLayoutConstraint.activate([
            weatherIcon.heightAnchor.constraint(equalToConstant: 86),
            weatherIcon.widthAnchor.constraint(equalToConstant: 86),
            weatherIcon.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -26),
            weatherIcon.centerYAnchor.constraint(equalTo: temperature.centerYAnchor),
            weatherIcon.leadingAnchor.constraint(equalTo: temperature.trailingAnchor, constant: 15),
            
            
        ])
        
    }
       
    
    // View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    


}

