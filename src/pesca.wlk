import wollok.game.*

//persona: puntaje, tiempo, vida, 


//peces u objetos que den o quiten vida


const ancho = 20 //12
const alto = 15 //6
const alturaAgua = 9 //4

object pantalla{
	
	
	
	method iniciar(){
		
		game.title("Juego comida")
		game.height(alto)
		game.width(ancho)
		game.boardGround("assets/fondo1.png")
		game.addVisual(heladeraConPeces)
		
		//const cosas = [new Pez()]
		
		
		//aca hay que ver si quieren que se genere aleatoreamente una cosa
		// o ir hacindo varios game.onTick para cada cosa asi controlamos que cantidad se genera de cada
		
		//el game.onTick hecho es para peces pero se puede copiar y pegar para hacer para otros ya que solo hay que cambiar el tiempo el y el new COSA()
		
		
		game.onTick(5000,"crear pez",{ const objetoFlotante = new Pez()
												game.addVisual(objetoFlotante)
												game.onTick(objetoFlotante.velocidadMov(), objetoFlotante.movimientoMov(), {objetoFlotante.moverse()})
												game.onTick(objetoFlotante.velocidadMov()*ancho, objetoFlotante.movimientoArranque(), {objetoFlotante.posicionOriginal()})
		})
		
			
		
		game.addVisual(persona)
		game.addVisual(ansu)
		keyboard.up().onPressDo({ansu.moverseArriba()})
        keyboard.down().onPressDo({ansu.moverseAbajo()})
        
        
        
        game.onCollideDo(ansu,{algo => ansu.ansuPesco(algo)})
 		
 		game.start()
 		
 	}
 	}


object persona {
	
	const vida = 100
	var puntaje = 0
	var tiempo = 0
	var electrocutado = false
	var property position = game.at(8.15,10.99999455)
	
	var property image = "assets/pinguino.png"
	
/* 	
	method cambiarImagen() {
		if (electrocutado) {
			game.onTick(300, "imagen", { image = ["assets/pinguinoElectrocutado2.png","assets/pinguinoElectrocutado1.png"].anyOne()})
			game.onTick(1200, "imagen", { image = "assets/pinguino.png"})
			electrocutado = false	
			}
		
		else image = "assets/pinguino.png"		
	}
	
	method cambiarEstado() {
		electrocutado = true 
	}
	
*/	
	
	
}




object heladeraConPeces {
	
	var property position = game.at(5,11)
	
	var property capacidad = 0
	
	method image() {
		
		return "assets/pez" + self.capacidad() + ".png"
	}
	
	method pesco() {
		capacidad = capacidad + 1
	}
	
	method aumentarCantidad() {
		capacidad += 1
	}
}
	



class ObjetosFlotantes {

	
	var izquierda = true
	
	const vertical = (0..alturaAgua).anyOne()
	
	var posicionIzquierda = game.at(ancho,vertical)
	var posicionDerecha =  game.at(-1,vertical)
	
	
	
	method position() {
		var posicion 
		
		if (izquierda) posicion = posicionIzquierda 
		else posicion = posicionDerecha
		
		return posicion
	} 
  	
  	
  	method posicionOriginalIzq(){
  		
  		posicionIzquierda = game.at(ancho,vertical)
  		izquierda = false
 		
  	}
  	
  	method posicionOriginalDer(){
  		
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
	
  	method velocidadMov() = 500
 	
 	method movimientoMov() = "se mueve"
 	
	method movimientoArranque() = "comienza a moverse"
	

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
	
	method image() {return if (izquierda) "assets/meduzaDer.png" else "assets/meduzaIzq.png"}
	
	
	
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
		else
		{
			self.hayUnPescado()
		}
	}
	method moverseAbajo() {
		position = position.down(1)
		const nuevo = new Hilo(position = position.up(1))
		game.addVisual(nuevo)
		cont -= 1
	}
	
 	method hayUnPescado() {		
		if (self.image() == "assets/ansuConPez.png")
		{
			image = "assets/ansu.png"
			heladeraConPeces.aumentarCantidad()
		}
		
		
	}
	
	method ansuPesco(algo) {
		if(algo.image() == "assets/pezDer.png" || algo.image() == "assets/pezIzq.png")
		{
			image = "assets/ansuConPez.png"
			//self.hayUnPescado()
			game.removeVisual(algo)
		}
		/*if(self.chocoMedusa(algo)){
			image = "assets/cañaElectrocutada.png"
			//new Hilo(position = position.up(1)).cambiarImagen(algo)
			persona.cambiarEstado()
			persona.cambiarImagen()
			
			game.removeVisual(algo)
			
		}*/
		else 
		{
			if(algo.image() == "assets/hilo.png")
			{
				game.removeVisual(algo)
			}
		}
		
	}
	method chocoMedusa(algo) {
		return algo.image() == "assets/meduzaDer.png" || algo.image() == "assets/meduzaIzq.png"
	}
	
	
}

class Hilo {

	var property position
	
	var property image = "assets/hilo.png"
	
	
}




