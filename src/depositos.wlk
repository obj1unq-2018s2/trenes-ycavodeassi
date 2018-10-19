import formaciones.*

class Deposito {
	const formaciones 		 = #{}
	const locomotorasSueltas = #{}
	var   locomotoraSueltaUtil = null
	
	method agregarFormacion(formacion) { formaciones.add(formacion) }
	
	method eliminarFormacion(formacion) { formaciones.remove(formacion)} 
	
	method agregarLocomotoraSueltaAFormacionSi(formacion) { 
		if (not formacion.puedeMoverse() && self.hayLocomotoraSueltaUtil(formacion)) {
			locomotoraSueltaUtil = self.obtenerLocomotoraSueltaUtil(formacion) //Me guardo la locomotora
			formacion.agregarLocomotora(locomotoraSueltaUtil) //Agrego la locomotora a una formacion
			locomotorasSueltas.remove(locomotoraSueltaUtil) //saco la locomotora del conjunto, ya no esta mas suelta.
		}
	}
	
	method hayLocomotoraSuelta() = not locomotorasSueltas.isEmpty()
	
	method hayLocomotoraSueltaUtil(formacion) = locomotorasSueltas.any{ locomotora => locomotora.esLocomotoraUtil(formacion) }
	
	method obtenerLocomotoraSueltaUtil(formacion) = locomotorasSueltas.find{ locomotora => locomotora.esLocomotoraUtil(formacion) }
		
	method vagonesMasPesados() = formaciones.map{ formacion => formacion.vagonMasPesado() }.asSet()
	
	method necesitaConductorExperimentado() = formaciones.any{ formacion => formacion.esCompleja() }
}




