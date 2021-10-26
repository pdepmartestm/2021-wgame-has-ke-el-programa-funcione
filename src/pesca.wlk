import wollok.game.*

//persona: puntaje, tiempo, vida, 


//peces u objetos que den o quiten vida




/*
 hay que ver que cuando un objeto se genera, al dar una vuelta completa (de izq a der y de der a izq)
 se elimine ya que se van a generar otros iguales durante ese lapso y si no se borra ninguno van a terminar
 llenando la pantalla de esos 
 */


// IDEA PARA IMPLEMENTAR 

//hay que ver el tema de que se generen aleatoreamente tambien en la izquierda
//asi puede salir peces por ambos lados y no solo por la derecha


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
		game.addVisual(contadorVida)


// ver que cantidad de tiempo se quiere para cada uno
		
		game.onTick(5000,"crear pez",{ const objetoFlotante = new Pez()
												game.addVisual(objetoFlotante)
												game.onTick(objetoFlotante.velocidadMov(), objetoFlotante.movimientoMov(), {objetoFlotante.moverse()})
												game.onTick(objetoFlotante.velocidadMov()*ancho, objetoFlotante.movimientoArranque(), {objetoFlotante.posicionOriginal()})
		})
		
		
		game.onTick(2500,"crear basura",{ const objetoFlotante = new Basura()
												game.addVisual(objetoFlotante)
												game.onTick(objetoFlotante.velocidadMov(), objetoFlotante.movimientoMov(), {objetoFlotante.moverse()})
												game.onTick(objetoFlotante.velocidadMov()*ancho, objetoFlotante.movimientoArranque(), {objetoFlotante.posicionOriginal()})
		})
		
		game.onTick(2500,"crear medusa",{ const objetoFlotante = new Medusa()
												game.addVisual(objetoFlotante)
												game.onTick(objetoFlotante.velocidadMov(), objetoFlotante.movimientoMov(), {objetoFlotante.moverse()})
												game.onTick(objetoFlotante.velocidadMov()*ancho, objetoFlotante.movimientoArranque(), {objetoFlotante.posicionOriginal()})
		})
		
		game.onTick(2500,"crear tiburo",{ const objetoFlotante = new Tiburon()
												game.addVisual(objetoFlotante)
												game.onTick(objetoFlotante.velocidadMov(), objetoFlotante.movimientoMov(), {objetoFlotante.moverse()})
												game.onTick(objetoFlotante.velocidadMov()*ancho, objetoFlotante.movimientoArranque(), {objetoFlotante.posicionOriginal()})
		})
		
		game.onTick(2500,"crear Gusano",{ const objetoFlotante = new Gusano()
												game.addVisual(objetoFlotante)
												game.onTick(objetoFlotante.velocidadMov(), objetoFlotante.movimientoMov(), {objetoFlotante.moverse()})
												game.onTick(objetoFlotante.velocidadMov()*ancho, objetoFlotante.movimientoArranque(), {objetoFlotante.posicionOriginal()})
		})
			
		game.onTick(1,"chequear si perdio",{if(persona.perdio())
			                                {
			                                	//sacar todo y poner imagen diciendo que perdio
			                                }
		})	
			
			
		game.addVisual(persona)
		game.addVisual(ansu)
		keyboard.up().onPressDo({ansu.moverseArriba()})
        keyboard.down().onPressDo({ansu.moverseAbajo()})
        
        game.onCollideDo(ansu,{algo => algo.ansuPesco()})
 		
 		game.start()
 		
 	}
 	}


object persona {
	
	var property puntaje = 0
	var property tiempo = 0
	
	var property estaParalizado = false
	
	var property position = game.at(8.15,10.99999455)
	
	var property image = "assets/pinguino.png"
	


	method cambiarImagen() {
		image = "assets/pinguinoElectrocutado2.png"
	}
	method volverNormalidad() {
		image = "assets/pinguino.png" 
	}
	

	method electrucutado() {
		
		if (estaParalizado)
		{
			estaParalizado = false
		}
		else
		{
			estaParalizado = true
		}
		
	}
	method perdio() {
		
		return contadorVida.vidas() <= 0 
	}
}

object contadorVida {
	
	var property vidas = 3
	
	var property image = "assets/contVidas3.png"
	
	var property position = game.at(1,13)
	
	
	method sacarVida(cant) {
		
		vidas = vidas - cant
		image = "assets/contVidas"+ vidas + ".png"
	}
	
		method agregarVida() {
			
		if (vidas < 3){
			
			vidas = vidas + 1
			image = "assets/contVidas"+ vidas + ".png"
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
  	
  	
  	

  	
  	method moverse(){ 
  		
  		
  		if (izquierda)
 		self.moverseIzquierda()
 		else
 		self.moverseDerecha()
  		
  	}
	
  	method velocidadMov() = 500
 	
 	method movimientoMov() = "se mueve"
 	
	method movimientoArranque() = "comienza a moverse"
	

}





class Pez inherits ObjetosFlotantes {
	

	
	 method image() {
	 	return if (izquierda) "assets/pezDer.png" else "assets/pezIzq.png"
	}
	
	method ansuPesco() {
		
	    ansu.cambiarImagen("Pez")
	 	game.removeVisual(self)
	 	
	}
}





class Basura inherits ObjetosFlotantes {
	
	const basuras = ["zapato","barril","botella"]
	
	const objeto = basuras.anyOne()
	
	method image() {
	 	return  "assets/" + objeto + ".png"}
	 	
	 	
	 method ansuPesco() {
	 	
	game.removeVisual(self)
	contadorVida.sacarVida(1)
	
} 	
	 
}






class Medusa inherits ObjetosFlotantes {
	
	
	//fijar despues cuanto tiempo quieren paralizar
	const cantidadParalizar = 2500
	
	method image() {return if (izquierda) "assets/meduzaDer.png" else "assets/meduzaIzq.png"}
	
	method ansuPesco(){
		
		persona.cambiarImagen()
		ansu.cambiarImagen("cañaElectrocutada")
		persona.electrucutado()
	    game.removeVisual(self)
		game.schedule(cantidadParalizar,{ansu.sacarElec() persona.volverNormalidad() persona.electrucutado() })
		

	}
}

class Gusano inherits ObjetosFlotantes {
	
	var property image = "assets/lataDeGusanos.png"
	
	method ansuPesco() {
		
		game.removeVisual(self)
		contadorVida.agregarVida()
	}
	
}


// ver que hacer con este, el cangrejo es muy complicado ya que colicionaria con los hilos
// no con el ansuelo

//class Cangrejo inherits ObjetosFlotantes {
//	
//}


class Tiburon inherits ObjetosFlotantes {
	
	var property image = "assets/tiburon.png"
	
	method ansuPesco() {
		game.removeVisual(self)
		contadorVida.sacarVida(3)
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
		
		if (!persona.estaParalizado())	
	{
			
		if ( self.arribaMaximo() ) {
		position = position.up(1)
		cont += 1 
		}
		else
		{
			self.hayUnPescado()
		}
		
	}
	
}
	method moverseAbajo() {
		
		if (!persona.estaParalizado())
		
		{
		position = position.down(1)
		const nuevo = new Hilo(position = position.up(1))
		game.addVisual(nuevo)
		cont -= 1
		
		}
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




