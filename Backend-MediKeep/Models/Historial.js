class Historial {
  constructor(idUsuario, idMedicamentos, fecha, estado, ) {
    this.idUsuario = idUsuario;
    this.idMedicamentos = idMedicamentos;
    this.fecha = fecha || new Date(); //rear un objeto de fecha con la fecha y hora actual del sistema.
    this.estado = estado; // tomado, omitido, suspendido
    
  }

  set idMongo(id) {
    this.id = id;
  }

  static fromJson(data) {
    return new Historial(
      data.idUsuario,
      data.idMedicamentos,
      data.fecha ? new Date(data.fecha) : new Date(),
      data.estado,
    );
  }

  toJson() {
    return {
      idUsuario: this.idUsuario,
      idMedicamentos: this.idMedicamentos,
      fecha: this.fecha,
      estado: this.estado,
    };
  }
}

module.exports = Historial;
