class Usuario {
  constructor(nombre, edad, enfermedade, fechaNacimiento, contraseña) {
    this.nombre = nombre;
    this.edad = edad;
    this.enfermedade = enfermedade;
    this.fechaNacimiento = fechaNacimiento;
    this.contraseña = contraseña;
  }

  set idMongo(id) {
    this.id = id;
  }

  static fromJson(data) {
    return new Usuario(
      data.nombre,
      data.edad,
      data.enfermedade,
      data.fechaNacimiento,
      data.contraseña
    );
  }

  toJson() {
    return {
      nombre: this.nombre,
      edad: this.edad,
      enfermedade: this.enfermedade,
      fechaNacimiento: this.fechaNacimiento,
      contraseña: this.contraseña,
    };
  }
}

module.exports = Usuario;
