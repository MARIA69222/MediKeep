class Medicamento {
  constructor(idUsuario, nombre, descripcion, dosis, frecuencia, horaInicio, duracion, usoProlongado, estado) {
    this.idUsuario = idUsuario;
    this.nombre = nombre;
    this.descripcion = descripcion;
    this.dosis = dosis;
    this.frecuencia = frecuencia;
    this.horaInicio = horaInicio;
    this.duracion = duracion;
    this.usoProlongado = usoProlongado || false;
    this.estado = estado || "activo";
  }

  set idMongo(id) { this.id = id; }

  static fromJson(data) {
    return new Medicamento(
      data.idUsuario,
      data.nombre,
      data.descripcion,
      data.dosis,
      data.frecuencia,
      data.horaInicio,
      data.duracion,
      data.usoProlongado,
      data.estado
    );
  }

  toJson() {
    return {
      idUsuario: this.idUsuario,
      nombre: this.nombre,
      descripcion: this.descripcion,
      dosis: this.dosis,
      frecuencia: this.frecuencia,
      horaInicio: this.horaInicio,
      duracion: this.duracion,
      usoProlongado: this.usoProlongado,
      estado: this.estado
    };
  }
}

module.exports = Medicamento;

