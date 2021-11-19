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
    
    @IBOutlet weak var getLocationButton: UIButton!
    
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
        getLocationButton.layer.cornerRadius = 15
        
        super.viewDidLoad()
        
        
        //
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        networkManager.getWeatherData(cityName: "Riyadh")
        
        networkManager.fetchWeatherData(completion: {  weatherData in
            
            DispatchQueue.main.async {
                self.weatherData? = weatherData
                print("In View controller :   \(weatherData.name)")
            }
            
            
        })
    }
    
    
    
    // Get user location manualy
    @IBAction func getLocationButtonClicked(_ sender: Any) {
        locationManager.requestLocation()
        
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
            
            //            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    
}
