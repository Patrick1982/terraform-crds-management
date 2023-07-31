# terraform-crds-management

## Manejo de CRDs de forma dinamica

Casos:

### example-1

- v1: 1 manifiesto
- v2: se edita ese manifiesto "labels"

valor esperado: tener solo 1 manifiesto editado

### example-2

- v1: 2 manifiestos
- v2: se editan los 2 manifiestos

valor esperado: tener solo 2 manifiestos editados 

### example-3

- v1: 1 manifiesto
- v2: se cambia a un manifiesto completamente distinto 

valor esperado: que respete el manifiesto antiguo y se agregue el nuevo

### example-4

- v1: 2 manifiestos
- v2: se cambia a 2 manifiestos completamente distintos

valor esperado: tener 4 manifiestos 
