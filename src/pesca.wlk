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
        
        //keyboard.left().onPressDo({const medu = new Medusa()  medu.ansuPesco()})
        
        game.onCollideDo(ansu,{algo => algo.ansuPesco()})
 		
 		game.start()
 		
 	}
 	}


object persona {
	
	const vida = 100
	var puntaje = 0
	var tiempo = 0
	var property position = game.at(8.15,10.99999455)
	
	var property image = "assets/pinguino.png"
	


	method cambiarImagen() {
		image = "assets/pinguinoElectrocutado2.png"
	}
	method volverNormalidad() {
		image = "assets/pinguino.png" 
	}
}

object contadorVida {
	var property image = "assets/contVidas" + vidas + ".png"
	
	var property position = game.center()
	
	var vidas = 3
	
	method sacarVida() {
		vidas-=1
	}
	
		method agregarVida() {
			
		if (vidas < 3){
			vidas+=1
		}
		
	}
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
  	
  	
  	
  	//hay que ver el tema de que se generen aleatoreamente tambien en la izquierda
  	//asi puede salir peces por ambos lados y no solo por la derecha
  	
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
	
	method ansuPesco() {
		
	    ansu.cambiarImagen("Pez")
	 	game.removeVisual(self)
	 	
	}
}





class Basura inherits ObjetosFlotantes {
	
	const basuras = ["zapato","barril","botella"]
	
	method image() {
	 	return  "assets/" + basuras.anyOne() + ".png"}
	 	
	 	
	 method ansuPesco() {
	 	
	game.removeVisual(self)
	contadorVida.sacarVida()
	
} 	
	 
}





//que van a tener de iguales o distinto los villanos??
//porque habria que hacer una clase para cada villano y si tienen
// todo distinto no hace falta hacer una clase general de villanos
//class Villanos inherits ObjetosFlotantes {
//	
//	method image() {return if (izquierda) "assets/meduzaDer.png" else "assets/meduzaIzq.png"}
//	
//	
//	
//}

class Medusa inherits ObjetosFlotantes {
	
	//fijar despues cuanto tiempo quieren paralizar
	const cantidadParalizar = 5000
	
	method image() {return if (izquierda) "assets/meduzaDer.png" else "assets/meduzaIzq.png"}
	
	method ansuPesco(){
		
		persona.cambiarImagen()
		ansu.cambiarImagen("cañaElectrocutada")
		game.onTick(cantidadParalizar,"pesco medusa",{ansu.sacarElec() persona.volverNormalidad() })
		
		//hay que ver este tema porque tira un mensaje raro con la medusa
		//game.removeVisual(self)
	}
}



object ansu {
	
	var property position = game.at(9,alturaAgua)
	
	var property caniaElec = false
	
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
	

	method cambiarImagen(cosa) {
		if (cosa == "cañaElectrocutada")
		{
			caniaElec = true
		}
		else
		{
		  image =  "assets/ansuCon" + cosa +  ".png"
		}

		
	}
	method sacarElec() {
		caniaElec = false
	}
	
	
}

class Hilo {

	var property position
	
	var image = "assets/hilo.png"
	
	method image() {
		
		if (ansu.caniaElec()){
			 image = "assets/canaElectrocutada.png"
		}
		else
		{
			image = "assets/hilo.png"
		}
		
      return image
	}
	
	method ansuPesco() {
		
				game.removeVisual(self)
			
	}
}




