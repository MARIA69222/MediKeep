class Historial {
  constructor(idUsuario, idMedicamentos, fecha, estado, tipoHistorial) {
    this.idUsuario = idUsuario;
    this.idMedicamentos = idMedicamentos;
    this.fecha = fecha;
    this.estado = estado; // ejemplo: tomado / no tomado
    this.tipoHistorial = tipoHistorial; // ejemplo: diario / mensual
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
      data.tipoHistorial
    );
  }

  toJson() {
    return {
      idUsuario: this.idUsuario,
      idMedicamentos: this.idMedicamentos,
      fecha: this.fecha,
      estado: this.estado,
      tipoHistorial: this.tipoHistorial
    };
  }
}

module.exports = Historial;
