import wollok.game.*

//persona: puntaje, tiempo, vida, 


//peces u objetos que den o quiten vida
const objetoFlotante = new ObjetosFlotantes()
const ancho = 12
const alto = 6
const alturaAgua = 4

object pantalla{
	
	
	
	method iniciar(){
		
		game.title("Juego comida")
		game.height(alto)
		game.width(ancho)
		
					
		game.addVisual(movimiento)
		
		game.onTick(movimiento.velocidadCaida(), movimiento.movimientoCaida(), {movimiento.moverse()})
		game.onTick(movimiento.velocidadCaida()*ancho, movimiento.movimientoArranque(), {movimiento.posicionOriginal()})		 
		
		
 		
 		game.start()
 		
 	}
 	}

object persona {
	
	const vida = 100
	var puntaje = 0
	var tiempo = 0
	
	method image() {return "assets/persona.png"}
}




object heladeraConPeces {
	
	var property capacidad = 0
	
	method image() {
		
		return "assets/heladera" + self.capacidad() + ".png"
	}
	
	method pesco() {
		capacidad = capacidad + 1
	}
}
	
//que los objetosFlotantes siempre vayan en linea recta
//que empiecen desde la izquierda o derecha
//que desaparezca el objeto una vez que se vaya de la pantalla 
//que desaparezca si choca
//que se mantenga en el recuadro


class ObjetosFlotantes {
	
	
	method movimiento() {

		
	}
	
	method aparecerObjetoIzquierda() {
		
	}
	
	method aparecerObjetoDerecha() {
		
	}
	
}

object pez inherits ObjetosFlotantes {
	
	
	
	method image() {
		// por derecha es una imagen por izquierda otra
		
	}
}

class Basura inherits ObjetosFlotantes {
	
	
	
}

class Villanos inherits ObjetosFlotantes {
	
}

object cania {
	
	
}


object movimiento {
	
	var izquierda = true
	
	
	var posicionIzquierda = game.at(ancho,alturaAgua)
	var posicionDerecha =  game.at(1,alturaAgua)
	
	method position() = return if (izquierda) posicionIzquierda else posicionDerecha
  	
  	
  	method posicionOriginalIzq(){
  		const vertical = (0..alturaAgua).anyOne()
  		posicionIzquierda = game.at(ancho,vertical)
  		izquierda = false
 		
  	}
  	
  	method posicionOriginalDer(){
  		const vertical = (0..alturaAgua).anyOne()
  		posicionDerecha = game.at(0,vertical)
  		izquierda = true
 	
   	}
  	
  	
  	method posicionOriginal(){
  		
 		if (izquierda)
 		self.posicionOriginalIzq()
 		else
 		self.posicionOriginalDer()
 	}
  	
  	method moverseIzquierda () { 
  		posicionIzquierda = posicionIzquierda.left(1)
  		
  	}
  	method moverseDerecha (){ 
  		posicionDerecha = posicionDerecha.right(1)
  		
  	}
  	
  	method moverse(){ 
  		if (izquierda)
 		self.moverseIzquierda()
 		else
 		self.moverseDerecha()
  		
  	}
  	/* 
  	method encuentroCon(){
  		CaniaDePescar.NombreDeAccionAlChocarConCania()
  		const vertical = (0..alturaAgua).anyOne()
  		posicion = game.at(0,vertical)
	}*/
	
	method image() = return if (izquierda) "FOTO DEL PEZ MOVIENDOSE A IZQUIERDA " else "FOTO DEL PEZ MOVIENDOSE A DERECHA"
  	
  	method velocidadCaida() = 500
 	
 	method movimientoCaida() = "cae comida"
 	
	method movimientoArranque() = "comienza caida comida"
 	
}
	
	




