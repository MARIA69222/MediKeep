class Historial {
  constructor(idUsuario, idMedicamentos, fecha, estado) {
    this.idUsuario = idUsuario;
    //  aseguramos que siempre sea array aunque manden solo 1 medicamento
    this.idMedicamentos = Array.isArray(idMedicamentos)
      ? idMedicamentos
      : [idMedicamentos];
    this.fecha = fecha || new Date(); 
    this.estado = estado; // tomado, omitido, suspendido
  }

  set idMongo(id) {
    this.id = id;
  }

  static fromJson(data) {
    return new Historial(
      data.idUsuario,
      Array.isArray(data.idMedicamentos)
        ? data.idMedicamentos
        : [data.idMedicamentos], // 👈 lo normalizamos aquí también
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
