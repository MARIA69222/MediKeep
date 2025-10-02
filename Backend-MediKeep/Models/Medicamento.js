class Medicamento {
  constructor(nombre, motivo, duracion, frecuencia, estado) {
    this.nombre = nombre;
    this.motivo = motivo;
    this.duracion = duracion;   // días
    this.frecuencia = frecuencia; // cada X horas
    this.estado = estado;       // activo / inactivo
  }

  set idMongo(id) {
    this.id = id;
  }

  static fromJson(data) {
    return new Medicamento(
      data.nombre,
      data.motivo,
      data.duracion,
      data.frecuencia,
      data.estado
    );
  }

  toJson() {
    return {
      nombre: this.nombre,
      motivo: this.motivo,
      duracion: this.duracion,
      frecuencia: this.frecuencia,
      estado: this.estado
    };
  }
}

module.exports = Medicamento;
