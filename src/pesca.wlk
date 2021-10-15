import wollok.game.*

//persona: puntaje, tiempo, vida, 


//peces u objetos que den o quiten vida
const objetoFlotante = new ObjetosFlotantes()
const ancho = 20 //12
const alto = 15 //6
const alturaAgua = 9 //4

object pantalla{
	
	
	
	method iniciar(){
		
		game.title("Juego comida")
		game.height(alto)
		game.width(ancho)
		game.boardGround("assets/fondo.png")
		
					
		//game.addVisual(movimiento)
		
		//game.onTick(movimiento.velocidadCaida(), movimiento.movimientoCaida(), {movimiento.moverse()})
		//game.onTick(movimiento.velocidadCaida()*ancho, movimiento.movimientoArranque(), {movimiento.posicionOriginal()})		 
		
		//game.addVisual(ansu)
		keyboard.up().onPressDo({ansu.moverseArriba()})
        keyboard.down().onPressDo({ansu.moverseAbajo()})
        
        game.onCollideDo(ansu,{hilo => hilo.sacarHilo(hilo)})
 		
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
		
		return "assets/pez" + self.capacidad() + ".png"
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
	
  	method velocidadCaida() = 500
 	
 	method movimientoCaida() = "se mueve"
 	
	method movimientoArranque() = "comienza a moverse"
	
//	method movimiento() {
//
//		
//	}
//	
//	method aparecerObjetoIzquierda() {
//		
//	}
//	
//	method aparecerObjetoDerecha() {
//		
//	}
	
}

class Pez inherits ObjetosFlotantes {
	
	
	
	
	
	 method image() {
	 	return if (izquierda) "assets/pezDer.png" else "assets/pezIzq.png"
		// por derecha es una imagen por izquierda otra
		
	}
}

class Basura inherits ObjetosFlotantes {
	
	const basuras = ["zapato","barril","botella"]
	
	method image() {
	 	return  "assets/" + basuras.anyOne() + ".png"}
	
}

class Villanos inherits ObjetosFlotantes {
	
	method image() {return if (izquierda) "assets/pezDer.png" else "assets/pezIzq.png"}
	
}


object ansu {
	
	var property position = game.at(9,alturaAgua)
	
	var property image = "assets/ansu.png"
	
	var property cont = 0
	
	method arribaMaximo() {
		
	return cont < 0
	}
	
	method moverseArriba() {
		
		if ( self.arribaMaximo() ) {
		position = position.up(1)
		cont += 1 
		}
	}
	method moverseAbajo() {
		position = position.down(1)
		const nuevo = new Hilo(position = position.up(1))
		game.addVisual(nuevo)
		cont -= 1
	}
	
}

class Hilo {

	var property position
	
	var property image = "assets/hilo.png"
	
	method sacarHilo(hilo) {
		
		game.removeVisual(hilo)
	}
		
}




