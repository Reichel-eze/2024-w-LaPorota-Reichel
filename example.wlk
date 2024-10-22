// -- CLASE EXCEPCIONES --

// 1) Hacer que la porota venda una cantidad de gramos de porotos a un cliente. 
// Al hacerlo, debe disminuir el stock y el cliente pagar lo correspondiente.

object laPorota {
  var stock = 100
  var precioPorGramo = 2

  method stock() = stock    // para consultar el stock de la porota

  method precioPorGramo() = precioPorGramo  // para consultar el precio por gramo de la porota

  method vender(cantidadDeGramos, comprador){
    if(cantidadDeGramos > stock) throw new DomainException(message="No hay stock suficiente")   // EXCEPCION!!!
    comprador.pagar(cantidadDeGramos * precioPorGramo)    // RESPETAR ESTE ORDEN PARA LOS TEST (1ERO se lo mando al pagar, para ver si se produce una excepcion, si se produce NO pasaria al siguiente paso de actualizar el stock)
    stock = stock - cantidadDeGramos
  }

}

class Comprador {
  var medioDePago // var medioDePago = TarjetaDeCredito

  method cambiarMedioDePago(otro){
    medioDePago = otro
  }

  method pagar(monto){
    medioDePago.pagar(monto)
  } 

}

class TarjetaDeCredito {
  var deuda = 0

  method deuda() = deuda  // para consultar la deuda de la tarjeta de credito

  method pagar(monto){
    deuda = deuda + monto
  } 

}

class TarjetaDeDebito {
  var saldoDisponible 

  method saldoDisponible() = saldoDisponible  // para consultar el saldo disponible de la tarjeta de debito

  method pagar(monto){
    if(saldoDisponible < monto) throw new DomainException(message="No hay saldo") // EXCEPCION!!!
    saldoDisponible = saldoDisponible - monto
  }
}

// Ejemplito 
const debitoDeEze = new TarjetaDeDebito (saldoDisponible = 100)
const ezequiel = new Comprador (medioDePago = debitoDeEze)