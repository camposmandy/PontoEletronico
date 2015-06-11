//
//  PrincipalViewController.swift
//  PontoEletronico
//
//  Created by Amanda Guimaraes Campos on 03/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class PrincipalViewController: UIViewController {
    
    var usuario: Usuario?
    var usuarios: Array<Usuario>?
    var diaTrabalhado: DiaTrabalhado?

    var tempoTotal = NSTimer()
    var tempoAlm = NSTimer()
    var inicioTempo = NSTimeInterval()
    var inicioTempoAlmoco = NSTimeInterval()
    var tempoDeAlmoco = NSTimeInterval()
    var tempoTrabalhado = NSTimeInterval()
    
    var horaEntrada = NSDate()
    var horaSaida = NSDate()
    var horaSaidaAlmoco = NSDate()
    var horaVoltaAlmoco = NSDate()
    
    var entradas = ["Entrada", "Saída Almoço", "Volta Almoço", "Saída"]
    var e = 0
    
    @IBOutlet weak var tempoLabel: UILabel!
    @IBOutlet weak var tempoAlmoco: UILabel!
    @IBOutlet weak var entrada: UIButton!
    @IBOutlet weak var ViewPizza: ViewCustomizada!
    
    @IBAction func entrada(sender: AnyObject) {

        switch e {
        case 0:
            e++
            horaEntrada = NSDate()
            tempoTotal = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "atualizaTempoTotal", userInfo: nil, repeats: true)
            inicioTempo = horaEntrada.timeIntervalSinceReferenceDate
            
        case 1:
            e++
            horaSaidaAlmoco = NSDate()
            tempoTotal.invalidate()
            tempoAlm = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "atualizaTempoAlmoco", userInfo: nil, repeats: true)
            inicioTempoAlmoco = horaSaidaAlmoco.timeIntervalSinceReferenceDate
        
        case 2:
            e++
            horaVoltaAlmoco = NSDate()
            tempoAlm.invalidate()
            tempoTotal = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "atualizaTempoTotal", userInfo: nil, repeats: true)
            inicioTempo = horaEntrada.timeIntervalSinceReferenceDate - (horaSaidaAlmoco.timeIntervalSinceReferenceDate - horaVoltaAlmoco.timeIntervalSinceReferenceDate)
        case 3:
            e = 0
            horaSaida = NSDate()
            tempoTotal.invalidate()
            
            diaTrabalhado = DiaTrabalhadoManager.sharedInstance.novoDiaTrabalho()
            
            diaTrabalhado?.horaEntrada = horaEntrada
            diaTrabalhado?.horaSaidaAlmoco = horaSaidaAlmoco
            diaTrabalhado?.horaVoltaAlmoco = horaVoltaAlmoco
            diaTrabalhado?.horaSaida = horaSaida
            diaTrabalhado?.tempoAlmoco = tempoDeAlmoco/60
            diaTrabalhado?.totalHoras = tempoTrabalhado/60
            
            DiaTrabalhadoManager.sharedInstance.salvar()
            
            tempoAlmoco.text = "00:00:00:00"
            tempoLabel.text = "00:00:00:00"

            let alerta = UIAlertController(title: "Fim", message: "...", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
                self.navigationController?.popViewControllerAnimated(true)
            }
            
            alerta.addAction(ok)
            self.presentViewController(alerta, animated: true, completion: nil)
        default:
            break
        }

        entrada.setTitle(entradas[e], forState: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        verificaPrimeiroAcesso()
        usuarios = UsuarioManager.sharedInstance.Usuario()
    }
    
    override func viewWillAppear(animated: Bool) {
        if usuarios?.count == 0 {
            usuario = usuarios?[0]
        }
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func verificaPrimeiroAcesso() {
        var userDefault = NSUserDefaults()
        var acesso = userDefault.objectForKey("Acesso") as? String
        if acesso == nil {
            var domingo: Semana
            domingo = SemanaManager.sharedInstance.novaSemana()
            domingo.nomeDIa = "Domingo"
            SemanaManager.sharedInstance.salvar()
            
            var segunda: Semana
            segunda = SemanaManager.sharedInstance.novaSemana()
            segunda.nomeDIa = "Segunda"
            SemanaManager.sharedInstance.salvar()
            
            var terca: Semana
            terca = SemanaManager.sharedInstance.novaSemana()
            terca.nomeDIa = "Terça"
            SemanaManager.sharedInstance.salvar()
            
            var quarta: Semana
            quarta = SemanaManager.sharedInstance.novaSemana()
            quarta.nomeDIa = "Quarta"
            SemanaManager.sharedInstance.salvar()
            
            var quinta: Semana
            quinta = SemanaManager.sharedInstance.novaSemana()
            quinta.nomeDIa = "Quinta"
            SemanaManager.sharedInstance.salvar()
            
            var sexta: Semana
            sexta = SemanaManager.sharedInstance.novaSemana()
            sexta.nomeDIa = "Sexta"
            SemanaManager.sharedInstance.salvar()
            
            var sabado: Semana
            sabado = SemanaManager.sharedInstance.novaSemana()
            sabado.nomeDIa = "Sábado"
            SemanaManager.sharedInstance.salvar()
            
            let VCEdit = self.storyboard?.instantiateViewControllerWithIdentifier("editarView") as? EditarPerfilTableViewController
            VCEdit?.btnCancelar.enabled = false
            self.navigationController?.pushViewController(VCEdit!, animated: false)
            
            userDefault.setObject("JaAcessou", forKey: "Acesso")
        }
    }
    
    func atualizaTempoTotal(){
        var tempoAtual = NSDate.timeIntervalSinceReferenceDate() as NSTimeInterval
        tempoTrabalhado = tempoAtual - inicioTempo
        var cargaHoraria = usuario!.cargaHorariaSemanal.doubleValue * 3600
        var auxTempoTrabalhado = cargaHoraria - tempoTrabalhado
        
        let horas = UInt8(auxTempoTrabalhado/3600.0)
        auxTempoTrabalhado -= (NSTimeInterval(horas)*3600)
        
        let minutos = UInt8(auxTempoTrabalhado/60.0)
        auxTempoTrabalhado -= (NSTimeInterval(minutos)*60)
        
        let segundos = UInt8(auxTempoTrabalhado)
        auxTempoTrabalhado -= NSTimeInterval(segundos)
        
        let fracao = UInt8(auxTempoTrabalhado*100)
        
        let strHoras = horas > 9 ? String(horas):"0" + String(horas)
        let strMinutos = minutos > 9 ? String(minutos):"0" + String(minutos)
        let strSegundos = segundos > 9 ? String(segundos): "0" + String(segundos)
        let strFracao = fracao > 9 ? String(fracao): "0" + String(fracao)
        
        var percPizza = (tempoTrabalhado*100)/cargaHoraria
        ViewPizza.piePercent = percPizza
        
        tempoLabel.text = "\(strHoras):\(strMinutos):\(strSegundos):\(strFracao)"
    }
    
    func atualizaTempoAlmoco(){
        var tempoAtual = NSDate.timeIntervalSinceReferenceDate() as NSTimeInterval
        tempoDeAlmoco = tempoAtual - inicioTempoAlmoco
        var tA = usuario!.tempoAlmoco.doubleValue * 60
        var auxTempoDeAlmoco = tA - tempoDeAlmoco
    
        let horas = UInt8(auxTempoDeAlmoco/3600.0)
        auxTempoDeAlmoco -= (NSTimeInterval(horas)*3600)
        
        let minutos = UInt8(auxTempoDeAlmoco/60.0)
        auxTempoDeAlmoco -= (NSTimeInterval(minutos)*60)
        
        let segundos = UInt8(auxTempoDeAlmoco)
        auxTempoDeAlmoco -= NSTimeInterval(segundos)
        
        let fracao = UInt8(auxTempoDeAlmoco*100)
        
        let strHoras = horas > 9 ? String(horas):"0" + String(horas)
        let strMinutos = minutos > 9 ? String(minutos):"0" + String(minutos)
        let strSegundos = segundos > 9 ? String(segundos): "0" + String(segundos)
        let strFracao = fracao > 9 ? String(fracao): "0" + String(fracao)
        
        tempoAlmoco.text = "\(strHoras):\(strMinutos):\(strSegundos):\(strFracao)"
    }
}
