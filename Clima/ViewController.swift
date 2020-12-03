//
//  ViewController.swift
//  Clima
//
//  Created by Mac8 on 12/11/20.
//  Copyright © 2020 Arpan. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController{
    
    var locationManager = CLLocationManager()
    
    var climaManager = ClimaManager()
    
    
    @IBOutlet weak var climafondo: UIImageView!
    
    @IBOutlet weak var buscarButton: UIButton!
    
    @IBOutlet weak var buscarTexto: UITextField!
    
    @IBOutlet weak var ciudad: UILabel!
    
    @IBOutlet weak var temperatura: UILabel!
    
    
    @IBOutlet weak var viento: UILabel!
    
    @IBOutlet weak var humedad: UILabel!
    @IBOutlet weak var tempmax: UILabel!
    
    @IBOutlet weak var tempmin: UILabel!
    
    @IBOutlet weak var liconoc: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation() //obtener la ubicacion
        
        climaManager.delegado = self
        
        buscarTexto.delegate = self
        
    }

    @IBAction func buscarCiudad(_ sender: UIButton) {
        print(buscarTexto.text!)
        ciudad.text = buscarTexto.text
        climaManager.fetchClima(nombreCiudad: buscarTexto.text!)
        
    }
    
    
    @IBAction func obtenerUbicacion(_ sender: UIButton) {
        
        locationManager.requestLocation()
    }
    
}



// MARK: - Hacer la peticion a la API
extension ViewController: ClimaManagerDelegate {
 
    
    func huboError(cualError: Error) {
        
        DispatchQueue.main.async {
            self.ciudad.text = cualError.localizedDescription
            
        }
        print(cualError.localizedDescription)
        
    }
    
    func actualizaClima(clima: ClimaModelo) {
        
        DispatchQueue.main.async {
            //self.liconoc.image = UIImage(named: clima.icono)
            self.temperatura.text = clima.temperaturaDecimal
            self.ciudad.text = "En \(clima.nombreCiudad), hay \(clima.descripcionClima)"
            self.climafondo.image = UIImage(named: clima.condicionClima)
            self.viento.text = "velocidad de viento: \(String(clima.velclima)) Km/h"
            self.humedad.text = "humedad: \(String(clima.humedad)) % "
            self.tempmax.text = "temperatura maxima: \(String(clima.tempmax)) °C"
            self.tempmin.text = "temperatura minima: \(String(clima.tempmin)) °C"
            
        }
        
        print(clima.temperaturaCelcius)
        print(clima.condicionID)
        
    }
}

//MARK: - obtener la ubicacion del usuario
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("ubicacion obtenida")
        if  let ubicacion = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = ubicacion.coordinate.latitude
            let lon = ubicacion.coordinate.longitude
            print("lat: \(lat), lon: \(lon)")
            
            climaManager.fechtClima(lat: lat, lon: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}


//MARK: - Delegado del TextField
extension ViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField){
        buscarTexto.text = ""
    }
    
    //activar el codigo del boton buscar en el teclado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //print(buscarTexto.text!)
        climaManager.fetchClima(nombreCiudad: buscarTexto.text!)
        return true
    }
    
    //validar si el usuario escribio algo en el textfield
    func textfieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if buscarTexto.text != "" {
            return true
        } else {
            buscarTexto.placeholder = "escribe una ciudad"
            print("Por Favor escribe algo...")
            return false
        }
    }
    
}
