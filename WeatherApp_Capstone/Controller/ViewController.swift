//
//  ViewController.swift
//  WeatherApp_Capstone
//
//  Created by Rayan Taj on 17/11/2021.
//

import UIKit
import CoreLocation
class ViewController: UIViewController {
    
    // Design Views for drawings
    @IBOutlet weak var topBarCard: UIView!
    @IBOutlet weak var mainCard: UIView!

    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBOutlet weak var getLocationButton: UIButton!
    @IBOutlet weak var citySearchBar: UISearchBar!
    
    
    // locationManager is CLLocationManager object
    let locationManager = CLLocationManager()
    // Tasks that locationManager do :
    // Get Location
    // Update coordinates
    
    var networkManager = NetworkManagment()
    var weatherData : Weather? = nil
    
    
    
    override func viewDidLoad() {
        // update UI views for design purposes
        topBarCard.layer.cornerRadius = 15
        mainCard.backgroundColor = UIColor(white: 1, alpha: 0.3)
        mainCard.layer.cornerRadius = 15
        getLocationButton.layer.cornerRadius = 25
        citySearchBar.layer.cornerRadius = 15
        super.viewDidLoad()
        
        
       
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
  
    }
    
    
    
    // Get user location manualy
    @IBAction func getLocationButtonClicked(_ sender: Any) {
        locationManager.requestLocation()
        
    }
    
    
    func setupViewElements(weatherData:Weather)  {
        
        
    }
    
    
    
    
    
}


extension ViewController  :  CLLocationManagerDelegate  {
    
    
    
    // This function will be triggred whenever the locationManager update the location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print(latitude, " " , longitude)
            
            
            networkManager.getWeatherData(longitude: String(longitude), latitude: String(latitude))
            networkManager.fetchWeatherData(completion: {  weatherData in
                
                DispatchQueue.main.async { [self] in
                    self.weatherData? = weatherData
                 
                    self.weatherDescriptionLabel.text = weatherData.weather[0].weatherDescription
                    self.cityNameLabel.text = weatherData.name
                }
                
                
            })
     
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
