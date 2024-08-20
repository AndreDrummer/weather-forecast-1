//
//  HourlyForecastCollectionViewCell.swift
//  weather-forecast-1
//
//  Created by Andre Silva on 20/08/24.
//

import UIKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {
    static let identifier = "HourlyForecast"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private lazy var hourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "16:00"
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let imageIcon = UIImageView()
        imageIcon.image = weatherImage()
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        imageIcon.contentMode = .scaleAspectFit
        
        return imageIcon
    }()
    
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "32ºC"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [hourLabel, weatherIcon, temperatureLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 4
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8,
                                                                 leading: 8,
                                                                 bottom: 8,
                                                                 trailing: 8)
        stack.layer.borderWidth = 1
        stack.layer.cornerRadius = 20
        stack.layer.borderColor = UIColor.white.cgColor
        stack.axis = .vertical
        
       return stack
    }()
    
    private func setupView() {
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy() {
        contentView.addSubview(vStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            weatherIcon.heightAnchor.constraint(equalToConstant: 33)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
