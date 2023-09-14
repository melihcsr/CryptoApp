

import Foundation

protocol CoinManagerDelegate{
    func didUpdateCoin(_ coinManager : CoinManager , coin : CoinModel)
    func didFailWithError(error : Error)
}

struct CoinManager {
    
    var delegate : CoinManagerDelegate?
    
    var baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "8FEEF5F1-E277-42B6-ABE1-0CDB00EE0D0C"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    

    
    
    mutating func completeUrl(choosenCurreny : Int){
       
        print("choosen Currency : \(choosenCurreny)")
        let urlString = "\(baseURL)/\(currencyArray[choosenCurreny])?apikey=\(apiKey)"
        performRequest(urlString: urlString)
        print(baseURL)
    }
    
   
    
    
    
    func performRequest(urlString : String){
        
        if let url = URL(string: urlString){
          
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let coin = self.parseJSON(coinData: safeData){
                        self.delegate?.didUpdateCoin(self, coin: coin)
                        print(coin)
                    }
                 
                }
                
            }
            task.resume()
        }
        
    }
    
    func parseJSON(coinData : Data) -> CoinModel? {
        
        let decoder = JSONDecoder()
        
        do{
            let decodeData = try decoder.decode(CoinModel.self, from: coinData)
            
            let asset_id_base = decodeData.asset_id_base
            let asset_id_quote = decodeData.asset_id_quote
            let rate = decodeData.rate
            
            let finalModel = CoinModel(asset_id_base: asset_id_base, asset_id_quote: asset_id_quote, rate: rate)
            print(decodeData.rate)
            return finalModel
            
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    }
    
    

    

