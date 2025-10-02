class Usuario {
  constructor(nombre,apellido,edad, enfermedad, fechaNacimiento, contraseña,email) {
    this.nombre = nombre;
    this.apellido = apellido;
    this.edad = edad;
    this.enfermedad = enfermedad;
    this.fechaNacimiento = fechaNacimiento;
    this.contraseña = contraseña;
    this.email = email;
  }

  set idMongo(id) {
    this.id = id;
  }

  static fromJson(data) {
    return new Usuario(
      data.nombre,
      data.apellido,
      data.edad,
      data.enfermedad,
      data.fechaNacimiento,
      data.contraseña,
      data.email
    );
  }

  toJson() {
    return {
      nombre: this.nombre,
      apellido: this.apellido,
      edad: this.edad,
      enfermedade: this.enfermedad,
      fechaNacimiento: this.fechaNacimiento,
      contraseña: this.contraseña,
      email: this.email
    };
  }
}

module.exports = Usuario;
