//
//  ViewController.swift
//  weather-forecast-1
//
//  Created by Andre Silva on 19/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    private lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.background
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
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
        label.textColor = UIColor.appPrimaryColor
        
        return label
    }()
    
    private lazy var temperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = temperatureValue()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 72, weight: .bold)
        label.textColor = UIColor.appPrimaryColor
        
        return label
    }()

    private lazy var weatherIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = weatherImage()
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        return icon
    }()
    
    private lazy var humidityLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.text = "Umidade"
        
        label.textColor = .white
        
        
        return label
    }()
    
    private lazy var humidityValueLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.text = "1000mm"
        
        label.textColor = .white
        
        
        return label
    }()
    
    
    private lazy var windLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.text = "Vento"
        
        label.textColor = .white
        
        
        return label
    }()
    
    private lazy var windValueLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.text = "10Km/h"
        
        label.textColor = .white
                
        return label
    }()
    
    private lazy var humidityStackview: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false

        
        return stackView
    }()
    
    private lazy var windStackview: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [windLabel, windValueLabel])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false

        
        return stackView
    }()
    
    private lazy var vStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [humidityStackview, windStackview])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 3
        stackView.backgroundColor = UIColor.softGrey
        stackView.layer.cornerRadius = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
        
        return stackView
    }()
    
    private lazy var hourlyForecastLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PREVISÃO POR HORA"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
                
        return label
    }()
    
    private lazy var hourlyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 67, height: 84)
        layout.sectionInset = UIEdgeInsets(
            top: 0, left: 12, bottom: 0, right: 12
        )
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView .translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.register(
            HourlyForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourlyForecastCollectionViewCell.identifier
        )
        return collectionView
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
        view.addSubview(backgroundView)
        view.addSubview(headerView)
        view.addSubview(vStackView)
        view.addSubview(hourlyForecastLabel)
        view.addSubview(hourlyCollectionView)
        
        
        headerView.addSubview(cityLabel)
        headerView.addSubview(temperature)
        headerView.addSubview(weatherIcon)
        
        humidityStackview.addArrangedSubview(humidityLabel)
        humidityStackview.addArrangedSubview(humidityValueLabel)
        windStackview.addArrangedSubview(windLabel)
        windStackview.addArrangedSubview(windValueLabel)
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
           backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
           backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
           backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
            vStackView.widthAnchor.constraint(equalToConstant: 206),
            vStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            hourlyForecastLabel.topAnchor.constraint(equalTo: vStackView.bottomAnchor, constant: 24),
            hourlyForecastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            hourlyCollectionView.topAnchor.constraint(equalTo: hourlyForecastLabel.bottomAnchor, constant: 22),
            hourlyCollectionView.heightAnchor.constraint(equalToConstant: 84),
            hourlyCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hourlyCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
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

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HourlyForecastCollectionViewCell.identifier,
            for: indexPath
        )
        
        return cell
    }
}
