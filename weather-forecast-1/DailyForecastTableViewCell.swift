//
//  DailyForecastTableViewCell.swift
//  weather-forecast-1
//
//  Created by Andre Silva on 21/08/24.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {
    
    static let identifier = "DailyForecast"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        setupView()
    }
    
    private lazy var weekDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private lazy var weatherIcon: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private lazy var minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private lazy var maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    
    private lazy var tableRow: UIStackView = {
        let view = UIStackView(arrangedSubviews: [weekDayLabel, weatherIcon, minTemperatureLabel, maxTemperatureLabel])
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.isLayoutMarginsRelativeArrangement = true
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 16,
            leading: 16,
            bottom: 16,
            trailing: 16
        )
        view.spacing = 15
        return view
    }()
    
    func loadData(weekDay: String?, icon: UIImage?, minTemp: String?, maxTemp: String?) {
        weekDayLabel.text = weekDay
        weatherIcon.image = icon
        minTemperatureLabel.text = "min \(minTemp ?? "")"
        maxTemperatureLabel.text = "max \(maxTemp ?? "")"
    }
    
    private func setupView() {
        backgroundColor = UIColor.clear
        selectionStyle = .none
        
        setHierarchy()
        setConstrainsts()
    }
    
    private func setHierarchy() {
        contentView.addSubview(tableRow)
    }
    
    private func setConstrainsts() {
        tableRow.setConstraintsToParent(contentView)
        
        NSLayoutConstraint.activate([
            weekDayLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 50),            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
