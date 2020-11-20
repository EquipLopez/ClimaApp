//
//  ClimaManager.swift
//  Clima
//
//  Created by Mac8 on 20/11/20.
//  Copyright © 2020 Arpan. All rights reserved.
//

import Foundation

struct ClimaManager {
    let climaURL = "http://api.openweathermap.org/data/2.5/weather?appid=bcaa596725bf26c710c8cf89b2360c4b&units=metric"
    
    
    func fetchClima(nombreCiudad: String){
        let urlString = "\(climaURL)&q=\(nombreCiudad)"
        print(urlString)
    }
    
    func realizarSolicitud(urlString: String){
        //1. crear la url
        if let url = URL(string: urlString){
            
            // 2- crear obj URLSession
            let session = URLSession(configuration: .default)
                
                // 3- asignar una tarea a la session
            let tarea = session.dataTask(with: url, completionHandler: handle(data:respuesta:error:))
            
            // 4- empezar la tarea
            tarea.resume()
            
        }
    
    }
    
    //metodo para evitar que la app se congele mientras reciba la informacion de la Api
    func handle(data: Data?, respuesta: URLResponse?, error: Error?){
        if error != nil {
            print(error!)
            return
        }
        
        if let datosSeguros = data {
            //necesitamos convertir esa data a tipo string
            let dataString = String(data: datosSeguros, encoding: .utf8)
            print(dataString!)
        }
    }
}
