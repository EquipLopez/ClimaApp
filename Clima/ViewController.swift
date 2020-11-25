//
//  ViewController.swift
//  Clima
//
//  Created by Mac8 on 12/11/20.
//  Copyright © 2020 Arpan. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate, ClimaManagerDelegate {
    func huboError(cualError: Error) {
        
        DispatchQueue.main.async {
            self.ciudad.text = cualError.localizedDescription
            
        }
            print(cualError.localizedDescription)
     
    }
    
    func actualizaClima(clima: ClimaModelo) {
        
        DispatchQueue.main.async {
            self.temperatura.text = clima.temperaturaDecimal
            self.ciudad.text = clima.descripcionClima
            self.climafondo.image = UIImage(named: clima.condicionClima)
            
        }
        
        
        
        
        print(clima.temperaturaCelcius)
        print(clima.condicionID)
        print()
        
    }
    
 
    
    
    var locationManager = CLLocationManager()
    
    var climaManager = ClimaManager()
    
    
    @IBOutlet weak var climafondo: UIImageView!
    
    @IBOutlet weak var buscarButton: UIButton!
    
    @IBOutlet weak var buscarTexto: UITextField!
    
    @IBOutlet weak var ciudad: UILabel!
    
    @IBOutlet weak var temperatura: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        
        climaManager.delegado = self
        
        buscarTexto.delegate = self
        
    }

    @IBAction func buscarCiudad(_ sender: UIButton) {
        print(buscarTexto.text!)
        ciudad.text = buscarTexto.text
        climaManager.fetchClima(nombreCiudad: buscarTexto.text!)
        
    }
}


///extension ViewController: ClimaManagerDelegate {
    
//}


extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: ) {
        <#function body#>
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
