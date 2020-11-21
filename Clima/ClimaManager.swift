//
//  ClimaManager.swift
//  Clima
//
//  Created by Mac8 on 20/11/20.
//  Copyright © 2020 Arpan. All rights reserved.
//

import Foundation

struct ClimaManager {
    let climaURL = "https://api.openweathermap.org/data/2.5/weather?appid=bcaa596725bf26c710c8cf89b2360c4b&units=metric&lang=es"
    
    
    func fetchClima(nombreCiudad: String){
        let urlString = "\(climaURL)&q=\(nombreCiudad)"
        print(urlString)
        
        realizarSolicitud(urlString: urlString)
    }
    
    func realizarSolicitud(urlString: String){
        //1. crear la url
        if let url = URL(string: urlString){
            
            // 2- crear obj URLSession
            let session = URLSession(configuration: .default)
                
                // 3- asignar una tarea a la session
            //let tarea = session.dataTask(with: url, completionHandler: handle(data:respuesta:error:))
            let tarea = session.dataTask(with: url) { (data, respuesta, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let datosSeguros = data {
                    //necesitamos convertir esa data a tipo string
                    //let dataString = String(data: datosSeguros, encoding: .utf8)
                    //print(dataString!)
                    
                    //Decodificar el obj JSON de la Api
                    self.parseJSON(climaData: datosSeguros)
                }
            }
            
            // 4- empezar la tarea
            tarea.resume()
        }
    }
    
    
    func parseJSON(climaData: Data){
        let decoder = JSONDecoder()
        
        do {
        let dataDecodificada = try decoder.decode(ClimaData.self, from: climaData)
            print(dataDecodificada.name)
            print(dataDecodificada.cod)
            print(dataDecodificada.main.temp)
            print(dataDecodificada.main.humidity)
            print(dataDecodificada.weather[0].description)
            print("latitud: \(dataDecodificada.coord.lat)")
            print("longuitud: \(dataDecodificada.coord.lon)")
        }catch{
            print(error)
        }
    }
}
