//
//  ClimaModelo.swift
//  Clima
//
//  Created by Mac8 on 23/11/20.
//  Copyright © 2020 Arpan. All rights reserved.
//

import Foundation

struct ClimaModelo {
    let condicionID: Int
    let nombreCiudad: String
    let descripcionClima: String
    let temperaturaCelcius: Double
    
    //crear propiedad computada
    var condicionClima: String {
        switch condicionID {
        case 200...232:
            return "tormenta.jpg"
        case 300...321:
            return "llovizna.jpg"
        case 500...531:
            return "lluvia.jpg"
        case 600...622:
            return "nieve.jpg"
        case 701...781:
            return ""
        case 800:
            return "climalimpio.jpg"
        case 801...804:
            return "nubes.jpg"
        default:
            return "clima-fondo.jpg"
        }
    }
    
    var temperaturaDecimal: String {
        return String(format: "%.1f", temperaturaCelcius)
    }
}
