//
//  ViewController.swift
//  Clima
//
//  Created by Mac8 on 12/11/20.
//  Copyright © 2020 Arpan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, ClimaManagerDelegate {
    func atualizarClima(clima: ClimaModelo) {
        
        temperatura.text = clima.temperaturaDecimal
        
        
    }
    
    
    
    
    var climaManager = ClimaManager()
    
    
    @IBOutlet weak var climafondo: UIImageView!
    
    @IBOutlet weak var buscarButton: UIButton!
    
    @IBOutlet weak var buscarTexto: UITextField!
    
    @IBOutlet weak var ciudad: UILabel!
    
    @IBOutlet weak var temperatura: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        climaManager.delegado = self
        
        buscarTexto.delegate = self
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        buscarTexto.text = ""
    }
    
    //activar el codigo del boton buscar en el teclado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(buscarTexto.text!)
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
    
    
    @IBAction func buscarCiudad(_ sender: UIButton) {
        print(buscarTexto.text!)
        ciudad.text = buscarTexto.text
        climaManager.fetchClima(nombreCiudad: buscarTexto.text!)
        
    }
}

