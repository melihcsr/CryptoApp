//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Melih Cesur on 14.09.2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel : Decodable{
    
    let asset_id_base : String
    let asset_id_quote : String
    let rate : Double
    
}
