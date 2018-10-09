class Deposito {
	const formaciones = #{}
	
	method agregarFormacion(formacion) = formaciones.add(formacion) 
	method vagonesMasPesados() = formaciones.forEach{ formacion => formacion.vagonMasPesado() }
	method necesitaConductorExperimentado() = formaciones.any{ formacion => formacion.esCompleja() }
	//falta el ejercicio 8.
}

class Formacion {
	const locomotoras = #{}
	const vagones = #{}

	method agregarLocomotora(locomotora) = locomotoras.add(locomotora)
	method agregarVagon(vagon) = vagones.add(vagon)
	method vagonesLivianos() = vagones.count{ vagon => vagon.esLiviano() }
	method velocidadMaxima() = locomotoras.min{ locomotora => locomotora.velocidadMaxima() }
	method esEficiente() = locomotoras.all{ locomotora => locomotora.arrastreUtil() >= locomotora.peso()*5 }
	method puedeMoverse()= self.arrastreUtilLocomotoras() >= self.pesoTotalVagones()
	method arrastreUtilLocomotoras()= locomotoras.sum{ locomotora => locomotora.arrastreUtil() }
	method pesoTotalVagones()= vagones.sum{ vagon => vagon.pesoMaximo() }
	method kgEmpujeRestantesParaMoverse() = if (self.puedeMoverse()) 0 else self.kgEmujeRestantes()
	method kgEmujeRestantes() = self.pesoTotalVagones()-self.arrastreUtilLocomotoras()
	method vagonMasPesado() = vagones.max({ vagon => vagon.pesoMaximo() }) 
	method esCompleja() = self.cantidadUnidades() > 20 //falta peso total
	method cantidadUnidades() = locomotoras.size() + vagones.size()
}

class Locomotora {
	var peso
	var pesoMaximo
	var velocidadMaxima
	
	method arrastreUtil() =  pesoMaximo-peso
	method peso() = peso
	method velocidadMaxima() = velocidadMaxima
}

class VagonDePasajeros {
	var metrosLargo //mts
	var metrosAncho //mts
	
	method cantidadPasajeros() = if (metrosAncho <= 2.5) metrosLargo*8 else metrosLargo*10
	method pesoMaximo() = self.cantidadPasajeros()*80
	method esLiviano() = self.pesoMaximo() < 2500
}

class VagonDeCarga {
	var cargaMaxima //kgs
	
	method cantidadPasajeros() = 0
	method pesoMaximo() = cargaMaxima+160
	 
	
}




