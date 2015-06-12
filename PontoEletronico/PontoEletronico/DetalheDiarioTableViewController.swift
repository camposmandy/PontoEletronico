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
    @IBOutlet weak var debitoLbl: UILabel!
    
    var diaTrab : DiaTrabalhado!
    var user : Usuario!
    
    
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
        
        var tempoTrabalhado : Double = 0
        
        tempoTrabalhado = diaTrab.horaSaida.timeIntervalSinceDate(diaTrab.horaEntrada)/3600
        
        var cargaHorariaUsuario = user.cargaHorariaSemanal.doubleValue
        //println(user.cargaHorariaSemanal)
        
        var tempoCredito = tempoTrabalhado - cargaHorariaUsuario
        var tempoDebito = cargaHorariaUsuario - tempoTrabalhado
        println ("Carga Horaria \(tempoTrabalhado)")
        println ("Carga Horaria Semanal \(cargaHorariaUsuario)")
        println ("Diferença \(tempoCredito)")
        
        diaTrabalhado.text = diaTrabalhadoString
        horaEntrada.text = horaEntradaString
        horaSaida.text = horaSaidaString
        horaSaidaAlmoco.text = horaSaidaAlmocoString
        horaVoltaAlmoco.text = horaVoltaAlmocoString
        
        if (tempoTrabalhado > cargaHorariaUsuario) {
            creditoLbl.text = "\(tempoCredito)"
        } else {
            creditoLbl.text = "Sem créditos."
        }
        
        if (tempoTrabalhado < cargaHorariaUsuario) {
            debitoLbl.text = "\(tempoDebito)"
        } else {
            debitoLbl.text = "Sem débitos."
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
