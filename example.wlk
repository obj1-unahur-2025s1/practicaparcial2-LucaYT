class Personaje{
  const property fuerza
  const property inteligencia
  var property rol
  method potencialOfensivo(){return fuerza * 10 + rol.extra()}
  method esGroso(){return self.esInteligente() || self.esGrosoEnSuRol()}
  method esInteligente()
  method esGrosoEnSuRol(){return rol.esGroso(self)}
}

class Humano inherits Personaje{
  override method esInteligente(){return inteligencia > 50}
}

class Orco inherits Personaje{
  override method potencialOfensivo(){
    return 
    if(rol==brujo) super()*1.1 else super()
  }
  override method esInteligente(){return false}
}

object guerrero{
  method extra(){return 100}
  method esGroso(unPersonaje){return unPersonaje.fuerza() > 50}
}

class Cazador{
  const property mascota
  method extra(){return mascota.potencialMascota()}
  method esGroso(unPersonaje){return mascota.esLongeva()}
}

object brujo{
  method extra(){return 0}
  method esGroso(unPersonaje){return true}
}

class Mascota{
  const property fuerza
  const property tieneGarras
  var edad
  method cumplirAños(){edad +=1}
  method potencialMascota(){return if(tieneGarras) fuerza * 2 else fuerza}
  method esLongeva(){return edad > 10}
}

class Localidad{
  var ejercito
  method ejercito(){return ejercito}
  method poderDefensivo(){return ejercito.potencialOfensivo()}
  method ocupar(unEjercito)
}

class Ciudad inherits Localidad{
  override method ocupar(unEjercito){ejercito = unEjercito}
  override method poderDefensivo(){return super() + 300}
}

class Aldea inherits Localidad{
  const cantidadMaximaHabitantes
  override method ocupar(unEjercito){
    if(unEjercito.tamañoEjercito() > cantidadMaximaHabitantes){
      ejercito = unEjercito.masPoderosos()
    }
    else{
      ejercito = unEjercito
    }
  }
}

class Ejercito{
  const personajes = []
  method invadir(unaLocalidad){
    if(self.puedeTomarLocalidad(unaLocalidad)){
      unaLocalidad.ocupar(self)
    }
  }
  method potencialOfensivo(){return personajes.sum({p=>p.potencialOfensivo()})}
  method puedeTomarLocalidad(unaLocalidad){return self.potencialOfensivo() > unaLocalidad.potencialDefensivo()}
  method ejercitoMasFuerte(){return self.masPoderosos().take(10)}
  method masPoderosos(){return personajes.sortBy({p1,p2=>p1.potencialOfensivo()>p2.potencialOfensivo()})}

  method tamañoEjercito(){return personajes.size()}
}