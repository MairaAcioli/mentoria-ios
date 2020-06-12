//
//  ViewController.swift
//  clean-code-challenger
//
//  Created by Leandro Souza da Silva (P) on 12/06/20.
//  Copyright © 2020 Leandro Souza da Silva (P). All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var campo: UITextField!
    @IBOutlet weak var botao: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        botao.addTarget(self, action: #selector(onClick), for: .touchUpInside)
    }
    
    @objc func onClick() {
        guard testaCPF(strCPF: campo.text ?? "") else {
            showAlert(message: "CPF Inválido")
            return
        }
        showAlert(message: "CPF Válido")
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Aviso", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func testaCPF(strCPF: String) -> Bool {
        var soma: Int
        var resto: Int
        
        soma = 0
        
        if strCPF == "00000000000" {
            return false
        }
        
        for i in 1...9 {
            let start = strCPF.index(strCPF.startIndex, offsetBy: i-1)
            let end = strCPF.index(strCPF.endIndex, offsetBy: -1 * (strCPF.count - i))
            let range = start..<end
            
            if let valor = Int(strCPF[range]) {
                soma += valor * (11 - i)
            }
            
        }
        resto = (soma * 10) % 11
        
        if resto == 10 || resto == 11 {
            resto = 0
        }
        
        let start = strCPF.index(strCPF.startIndex, offsetBy: 9)
        let end = strCPF.index(strCPF.endIndex, offsetBy: -1)
        let range = start..<end
        if let valor = Int(strCPF[range]), valor != resto {
            return false
        }
        
        soma = 0
        
        for i in 1...10 {
            let start = strCPF.index(strCPF.startIndex, offsetBy: i-1)
            let end = strCPF.index(strCPF.endIndex, offsetBy: -1 * (strCPF.count - i))
            let range = start..<end
            
            if let valor = Int(strCPF[range]) {
                soma += valor * (12 - i)
            }
            
        }
        resto = (soma * 10) % 11
        
        if resto == 10 || resto == 11 {
            resto = 0
        }
        
        let start1 = strCPF.index(strCPF.startIndex, offsetBy: 10)
        let end1 = strCPF.index(strCPF.endIndex, offsetBy: 0)
        let range1 = start1..<end1
        if let valor = Int(strCPF[range1]), valor != resto {
            return false
        }
        
        return true
    }


}

