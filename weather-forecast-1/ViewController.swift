//
//  ViewController.swift
//  weather-forecast-1
//
//  Created by Andre Silva on 19/08/24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    private var locationManager: CLLocationManager!
    private var activityIndicator: UIActivityIndicatorView!
    private var forecastResponse: ForecastResponse?
    private var location: CLLocation!
    private var currentPlace: Place!
    private let service = Service()
    
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        
        // Start the activity indicator
        activityIndicator.startAnimating()
        getCurrentLocation()
    }
    
    private func getCurrentLocation() {
        // Initialize the locationManager
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Request authorization from the user
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Delegate method called when the authorization status changes
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        
        print("Status \(manager.authorizationStatus)")
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            // Start updating location only if authorized
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            // Handle the case where the user has denied location access
            print("Location services are not available.")
        case .notDetermined:
            // Still waiting for authorization
            break
        @unknown default:
            break
        }
    }
    
    // Delegate method called when the location is updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coreLocation = locations.first {
            location = coreLocation
            fetchData()
            locationManager.stopUpdatingLocation()
        }
    }
    
    // Handle errors
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
    
    private func fetchCityAndState(completion: @escaping (_ latLng: LatLng?, _ city: String, _ state: String) -> Void) {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Error with reverse geocoding: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                let state = placemark.administrativeArea ?? "Unknown state"
                let city = placemark.locality ?? "Unknown city"
                let latLng = LatLng(
                    lat: "\(self.location.coordinate.latitude)",
                    lng: "\(self.location.coordinate.longitude)"
                )
                
                completion(latLng, city, state)
            } else {
                completion(nil, "Unknown city", "Unknown state")
            }
        }
    }
    
    private func getPlace(completion: @escaping (Place) -> Void) {
        
        fetchCityAndState { latLng, city, state in
            let place = Place(
                latLng: latLng ?? LatLng(lat: "\(self.location.coordinate.latitude)", lng: "\(self.location.coordinate.longitude)"),
                state: state,
                city: city
            )
            
            completion(place)
        }
    }
    
    private func fetchData() {
        getPlace { place in
            self.currentPlace = place
            self.service.fecthData(place: place) { [weak self] response in
                
                self?.forecastResponse = response
                DispatchQueue.main.async {
                    self?.loadData()
                    self?.setupView()
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    private func loadData() {
        placeLabel.text = "\(currentPlace.city), \(currentPlace.state)"
        
        temperatureLabel.text = forecastResponse?.current.temp.toCelsius()
        humidityValueLabel.text = "\(Int(forecastResponse?.current.humidity ?? 0))mm"
        windValueLabel.text = "\(Int(forecastResponse?.current.windSpeed ?? 0))km/h"
        
        weatherIcon.image = UIImage(named: forecastResponse?.current.weather.first?.icon ?? "")
        
        if(forecastResponse?.current.dt.isDayTime() ?? true) {
            backgroundView.image = UIImage.background
        } else {
            backgroundView.image = UIImage.backgroundDark
        }
        
        hourlyCollectionView.reloadData()
        dailyForecastTableView.reloadData()
    }
    
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
    
    private lazy var placeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = UIColor.appPrimary
        
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 56, weight: .bold)
        label.textColor = UIColor.appPrimary
        
        return label
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let icon = UIImageView()
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
    
    private lazy var dailyForecastLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PRÓXIMOS DIAS"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        
        return label
    }()
    
    private lazy var dailyForecastTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(DailyForecastTableViewCell.self,
                           forCellReuseIdentifier: DailyForecastTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .white
        return tableView
    }()
    
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
        view.addSubview(dailyForecastLabel)
        view.addSubview(dailyForecastTableView)
        
        
        headerView.addSubview(placeLabel)
        headerView.addSubview(temperatureLabel)
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
            headerView.heightAnchor.constraint(equalToConstant: 152),
        ])
        
        
        NSLayoutConstraint.activate([
            placeLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 16),
            placeLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            placeLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            placeLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 21),
            temperatureLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 26),
        ])
        
        
        NSLayoutConstraint.activate([
            weatherIcon.heightAnchor.constraint(equalToConstant: 104),
            weatherIcon.widthAnchor.constraint(equalToConstant: 104),
            weatherIcon.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -26),
            weatherIcon.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
            weatherIcon.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 15),
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
        
        NSLayoutConstraint.activate([
            dailyForecastLabel.topAnchor.constraint(equalTo: hourlyCollectionView.bottomAnchor, constant: 29),
            dailyForecastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dailyForecastTableView.topAnchor.constraint(equalTo: dailyForecastLabel.bottomAnchor, constant: 16),
            dailyForecastTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dailyForecastTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dailyForecastTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
        return forecastResponse?.hourly.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HourlyForecastCollectionViewCell.identifier,
            for: indexPath
        ) as? HourlyForecastCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let forecast = forecastResponse?.hourly[indexPath.row]
        
        cell.loadData(hour: forecast?.dt.toHourFormat(), icon: UIImage(named: forecast?.weather.first?.icon ?? "sunIcon"), temp: forecast?.temp.toCelsius())
        
        return cell
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastResponse?.daily.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DailyForecastTableViewCell.identifier,
            for: indexPath
        ) as? DailyForecastTableViewCell else {
            return UITableViewCell()
        }
        
        let forecast = forecastResponse?.daily[indexPath.row]
        
        cell.loadData(
            weekDay: forecast?.dt.toWeekdayName(),
            icon: UIImage(named: forecast?.weather.first?.icon ?? "sunIcon"),
            minTemp: forecast?.temp.min.toCelsius(),
            maxTemp: forecast?.temp.max.toCelsius()
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        72
    }
}
