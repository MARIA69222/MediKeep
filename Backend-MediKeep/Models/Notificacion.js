class Notificacion {
  constructor(idUsuarios, idMedicamento, hora, estado, tipo) {
    this.idUsuarios = idUsuarios;
    this.idMedicamento = idMedicamento;
    this.hora = hora;
    this.estado = estado; // pendiente / enviada / vista
    this.tipo = tipo; // ejemplo: recordatorio / alerta
  }

  set idMongo(id) {
    this.id = id;
  }

  static fromJson(data) {
    return new Notificacion(
      data.idUsuarios,
      data.idMedicamento,
      data.hora ? new Date(data.hora) : new Date(),
      data.estado,
      data.tipo
    );
  }

  toJson() {
    return {
      idUsuarios: this.idUsuarios,
      idMedicamento: this.idMedicamento,
      hora: this.hora,
      estado: this.estado,
      tipo: this.tipo
    };
  }
}

module.exports = Notificacion;
