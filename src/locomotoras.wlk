
class Locomotora {
	var peso 			//kgs
	var pesoMaximo 		//kgs
	var velocidadMaxima //kms
	
	method arrastreUtil() =  pesoMaximo-peso
	
	method peso() = peso
	
	method velocidadMaxima() = velocidadMaxima
	
	method esLocomotoraUtil(formacion) = self.arrastreUtil() >= formacion.kgEmpujeRestantes()
}
