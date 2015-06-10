//
//  DiarioViewController.swift
//  PontoEletronico
//
//  Created by João Marcos on 10/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class DiarioViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var diasTrabalhados: Array<DiaTrabalhado>?
    var auxTempo: Double?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Revisar isso! Acredito ser melhor uma seçao para cada mes ou algo assim
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if diasTrabalhados?.count == 0 {
            return 1
        } else {
            return diasTrabalhados!.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCellWithIdentifier("celulaDiario") as? DiarioTableViewCell
        
        if diasTrabalhados?.count != 0 {
            celula?.imagem.hidden = false
            celula?.totalHoras.hidden = false
            celula?.dataLbl.hidden = false
            celula?.textLabel?.hidden = true
            
            if let dia = diasTrabalhados?[indexPath.row]{
                auxTempo = dia.totalHoras.doubleValue
                
                let horas = Int(auxTempo!/60.0)
                auxTempo = auxTempo! - (NSTimeInterval(horas)*60)
                
                let minutos = UInt8(auxTempo!)
                auxTempo = auxTempo! - NSTimeInterval(minutos)
                
                let strHoras = horas > 9 ? String(horas):"0" + String(horas)
                let strMinutos = minutos > 9 ? String(minutos):"0" + String(minutos)
                
                celula?.totalHoras.text = "\(strHoras):\(strMinutos)"
                celula?.dataLbl.text = "\(dia.horaEntrada)"
            }

            celula?.accessoryType = .DisclosureIndicator
            tableView.userInteractionEnabled = true
        } else {
            celula?.imagem.hidden = true
            celula?.totalHoras.hidden = true
            celula?.dataLbl.hidden = true
            celula?.textLabel?.hidden = false
            
            celula?.textLabel?.text = "Sem Dias Trabalhados"
            celula?.textLabel?.textColor = UIColor .blackColor()
            celula?.textLabel?.textAlignment = NSTextAlignment.Center
            
            celula?.accessoryType = .None
            tableView.userInteractionEnabled = false
        }
        
        return celula!
    }
    
    func reloadData(){
        diasTrabalhados = DiaTrabalhadoManager.sharedInstance.DiasTrabalho()
        tableView.reloadData()
    }
}
