//
//  WeatherView.swift
//  WeatherDB
//
//  Created by Rithwik Mylavarapu on 3/29/21.
//

import UIKit

class WeatherViewCollectionViewCell: UICollectionViewCell {
    
    var color: UIColor? {
        didSet {
            self.cityName.textColor = self.color
            self.weatherType.textColor = self.color
            self.currentWeather.textColor = self.color
            self.maxTemp.textColor = self.color
            self.minTemp.textColor = self.color
            self.feelTemp.textColor = self.color
            self.pressure.textColor = self.color
            self.humidity.textColor = self.color
        }
    }
    
    static let reuseIdentifier: String = String(describing: WeatherViewCollectionViewCell.self)

    var weather: Weather? {
        didSet {
            guard let weather = weather else {
                print("Couldn't find eventName")
                return
            }
            DispatchQueue.main.async {
                self.cityName.text = String(weather.name)
                self.weatherType.text = weather.condition[0].description
                self.currentWeather.text = "Current Temp: " + String(weather.main.temperature) + " °F"
                self.maxTemp.text = "Max Temp: " + String(weather.main.maxTemperature) + " °F"
                self.minTemp.text = "Min Temp: " + String(weather.main.minTemperature) + " °F"
                self.feelTemp.text = "Feels Like: " + String(weather.main.heatIndex) + " °F"
                self.pressure.text = "Pressure: " + String(weather.main.pressure) + " hPa"
                self.humidity.text = "Humidity: " + String(weather.main.humidity) + "%"
                let iconURL = "https://openweathermap.org/img/wn/" + weather.condition[0].icon + "@2x.png"
                guard let url = URL(string: iconURL) else { return }
                guard let data = try? Data(contentsOf: url) else { return }
                let image: UIImage = UIImage(data: data)!
                self.weatherIcon.image = image
            }
        }
    }
    
    let cityName: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 20.0, weight: .medium)
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let weatherType: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 20.0, weight: .medium)
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let currentWeather: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 20.0, weight: .medium)
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let maxTemp: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 20.0, weight: .medium)
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let minTemp: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 20.0, weight: .medium)
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let feelTemp: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 20.0, weight: .medium)
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let pressure: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 20.0, weight: .medium)
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let humidity: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 20.0, weight: .medium)
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let weatherIcon: UIImageView = {
        let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(cityName)
        contentView.addSubview(weatherType)
        contentView.addSubview(currentWeather)
        contentView.addSubview(maxTemp)
        contentView.addSubview(minTemp)
        contentView.addSubview(feelTemp)
        contentView.addSubview(pressure)
        contentView.addSubview(humidity)
        contentView.addSubview(weatherIcon)
        
        NSLayoutConstraint.activate([
            cityName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cityName.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            weatherIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weatherIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            weatherIcon.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 10),
            weatherIcon.heightAnchor.constraint(equalToConstant: 200),
            
            weatherType.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weatherType.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 20),

            currentWeather.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            currentWeather.topAnchor.constraint(equalTo: weatherType.bottomAnchor, constant: 20),
            
            maxTemp.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            maxTemp.topAnchor.constraint(equalTo: currentWeather.bottomAnchor, constant: 20),
            
            minTemp.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            minTemp.topAnchor.constraint(equalTo: maxTemp.bottomAnchor, constant: 20),
            
            feelTemp.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            feelTemp.topAnchor.constraint(equalTo: minTemp.bottomAnchor, constant: 20),
            
            pressure.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pressure.topAnchor.constraint(equalTo: feelTemp.bottomAnchor, constant: 20),
            
            humidity.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            humidity.topAnchor.constraint(equalTo: pressure.bottomAnchor, constant: 20)
        ])
    }
    
}
