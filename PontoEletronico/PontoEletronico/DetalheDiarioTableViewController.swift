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
    var usuarios : Array<Usuario>!
    var usuario: Usuario!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usuarios = UsuarioManager.sharedInstance.Usuario()
        usuario = usuarios[0]
        
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
        
        var tempoTrabalhado = diaTrab.totalHoras.doubleValue
        var cargaHorariaUsuario = usuario.cargaHorariaSemanal.doubleValue * 60
        
        if  cargaHorariaUsuario > tempoTrabalhado {
            var auxTempoTrabalhado = cargaHorariaUsuario - tempoTrabalhado
            
            let horas = UInt8(auxTempoTrabalhado/60.0)
            auxTempoTrabalhado -= (NSTimeInterval(horas)*60)
            
            let minutos = UInt8(auxTempoTrabalhado)
            auxTempoTrabalhado -= (NSTimeInterval(minutos))
            
            let strHoras = horas > 9 ? String(horas):"0" + String(horas)
            let strMinutos = minutos > 9 ? String(minutos):"0" + String(minutos)
            
            creditoLbl.text = "-\(strHoras):\(strMinutos)"
            creditoLbl.textColor = UIColor .redColor()
        } else {
            var auxTempoTrabalhado = tempoTrabalhado - cargaHorariaUsuario
            
            let horas = UInt8(auxTempoTrabalhado/60.0)
            auxTempoTrabalhado -= (NSTimeInterval(horas)*60)
            
            let minutos = UInt8(auxTempoTrabalhado)
            auxTempoTrabalhado -= (NSTimeInterval(minutos))
            
            let strHoras = horas > 9 ? String(horas):"0" + String(horas)
            let strMinutos = minutos > 9 ? String(minutos):"0" + String(minutos)
            
            creditoLbl.text = "\(strHoras):\(strMinutos)"
            creditoLbl.textColor = UIColor .greenColor()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
