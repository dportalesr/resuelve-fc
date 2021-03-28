# Prueba Resuelve FC

## Requerimientos

- Ruby 2.7.2

## Instalación

Desde la raíz del proyecto ejecutar:

```bash
bundle install
```
## Iniciar la aplicación

```bash
bundle exec rackup -p 4000
```

## Desarrollo

El siguiente comando vigilará por cambios para reiniciar el servidor:

```bash
$ bundle exec guard
```

## Tests

```bash
bundle exec rspec
```

Los tests hacen uso de [rspec_api_documentation](https://github.com/zipmark/rspec_api_documentation) para generar la [documentación](#docs).

## Docs

Para visualizar la documentación de la API, visite la ruta raíz en el navegador.

Para actualizar la documentación:

```bash
bundle exec rake docs:generate
```

## Producción

Una instancia de la aplicación se encuentra [corriendo en Heroku](https://arcane-lake-18056.herokuapp.com/)
