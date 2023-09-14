

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,CoinManagerDelegate {
   

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var moneyType: UILabel!
    @IBOutlet weak var currenyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        self.currenyPicker.delegate = self
        self.currenyPicker.dataSource = self
        currenyPicker.dataSource = self
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        coinManager.completeUrl(choosenCurreny: row)
        
       
        
    }
    
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel) {
        
        DispatchQueue.main.async {
            self.price.text = String(format:"%.2f",coin.rate)
            self.moneyType.text = coin.asset_id_quote
        }
      
    }
    
    func didFailWithError(error: Error) {
        print("error")
    }
    


}

