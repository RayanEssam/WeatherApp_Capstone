import Foundation




struct NetworkManagment {
    
    
    let appID = "fc360bc639ae8e2e5f3b1c06887973e3"
    var units = "metric"
    var url = "https://api.openweathermap.org/data/2.5/weather?"
    var preparedUrl = ""
    
    // prepare the url and return the suited string - for fetch by name
    mutating func getWeatherData(cityName : String )  {
         preparedUrl = "\(url)q=\(cityName)&appid=\(appID)"
        
//        fetchWeatherData(urlString: preparedUrl)
        
    }
    
    // prepare the url and return the suited string - for fetch by coords
   mutating func getWeatherData(longitude : String , latitude : String)  {

       preparedUrl = "\(url)lat=\(latitude)&lon=\(longitude)&appid=\(appID)"
    }
    
    
    func fetchWeatherData( completion: @escaping(Weather) -> Void )  {
  

        guard let urlObject = URL(string: preparedUrl ) else{
            print("error")
            return
        }
       
        let request = URLRequest(url: urlObject)

        URLSession.shared.dataTask(with: request) { data, response, error in
            print(preparedUrl)
            if let data = data {
                
                if let decodedResponse = try? JSONDecoder().decode(Weather.self, from: data) {
            
                    DispatchQueue.main.async {
                     
//                        self.results = decodedResponse.results
                        print(decodedResponse.sys.country)
                        completion(decodedResponse)
                    }

                    return
                }else{
                  print("error")
                }
            }
            
            
        }.resume()
        
        
    }
    
    
    
}
