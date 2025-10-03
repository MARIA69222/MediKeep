class Usuario {
  constructor(nombre, apellido, fechaNacimiento, tipoDocumento, numeroDocumento, correo, telefono, contrasena, enfermedad, fotoPerfil = null) {
    this.nombre = nombre;
    this.apellido = apellido;
    this.fechaNacimiento = fechaNacimiento;
    this.tipoDocumento = tipoDocumento;
    this.numeroDocumento = numeroDocumento;
    this.correo = correo;
    this.telefono = telefono;
    this.contrasena = contrasena;
    this.enfermedad = enfermedad || null;
    this.fotoPerfil = fotoPerfil; 
  }

  set idMongo(id) { this.id = id; }

  static fromJson(data) {
    return new Usuario(
      data.nombre,
      data.apellido,
      data.fechaNacimiento,
      data.tipoDocumento,
      data.numeroDocumento,
      data.correo,
      data.telefono,
      data.contrasena,
      data.enfermedad,
      data.fotoPerfil
    );
  }

  toJson() {
    return {
      nombre: this.nombre,
      apellido: this.apellido,
      fechaNacimiento: this.fechaNacimiento,
      tipoDocumento: this.tipoDocumento,
      numeroDocumento: this.numeroDocumento,
      correo: this.correo,
      telefono: this.telefono,
      contrasena: this.contrasena,
      enfermedad: this.enfermedad,
      fotoPerfil: this.fotoPerfil
    };
  }
}

module.exports = Usuario;

