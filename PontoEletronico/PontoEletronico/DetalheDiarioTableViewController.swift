//
//  DetalheDiarioTableViewController.swift
//  PontoEletronico
//
//  Created by Amanda Guimaraes Campos on 03/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit


class DetalheDiarioTableViewController: UITableViewController {
    
    @IBOutlet weak var diaTrabalhado: UILabel!
    @IBOutlet weak var horaEntrada: UILabel!
    @IBOutlet weak var horaSaida: UILabel!
    @IBOutlet weak var horaSaidaAlmoco: UILabel!
    @IBOutlet weak var horaVoltaAlmoco: UILabel!
    @IBOutlet weak var creditoLbl: UILabel!
    
    var diaTrab : DiaTrabalhado!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preencherLabels()
    }
    
    
    func preencherLabels(){
        
        //////////// Formatação do dia Trabalhado ////////////
        var dayFormatter = NSDateFormatter()
        dayFormatter.dateFormat = "dd/MM/yyyy"
        
        var hourFormatter = NSDateFormatter()
        hourFormatter.dateFormat = "HH:mm:ss"
        
        var diaTrabalhadoString = dayFormatter.stringFromDate(diaTrab.horaEntrada)
        
        var horaEntradaString = hourFormatter.stringFromDate(diaTrab.horaEntrada)
        
        var horaSaidaString = hourFormatter.stringFromDate(diaTrab.horaSaida)
        
        var horaSaidaAlmocoString = hourFormatter.stringFromDate(diaTrab.horaSaidaAlmoco)
        
        var horaVoltaAlmocoString = hourFormatter.stringFromDate(diaTrab.horaVoltaAlmoco)
        
        diaTrabalhado.text = diaTrabalhadoString
        horaEntrada.text = horaEntradaString
        horaSaida.text = horaSaidaString
        horaSaidaAlmoco.text = horaSaidaAlmocoString
        horaVoltaAlmoco.text = horaVoltaAlmocoString
        creditoLbl.text = "\(diaTrab.horaEntrada)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
