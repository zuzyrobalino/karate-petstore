  #• Añadir una mascota a la tienda
  #• Consultar la mascota ingresada previamente (Búsqueda por ID)
  #• Actualizar el nombre de la mascota y el estatus de la mascota a “sold”
  #• Consultar la mascota modificada por estatus (Búsqueda por estatus)

  Feature: PetStore API Tests

    Background:
      * url 'https://petstore.swagger.io/v2'
      * def pet =
    """
    {
      "id": 12345,
      "category": {
        "id": 1,
        "name": "dogs"
      },
      "name": "doggie",
      "photoUrls": [
        "string"
      ],
      "tags": [
        {
          "id": 0,
          "name": "string"
        }
      ],
      "status": "available"
    }
    """

    Scenario: Añadir una mascota a la tienda
      Given path '/pet'
      And request pet
      When method POST
      Then status 200
      And match response contains { id: 12345, name: 'doggie', status: 'available' }

    Scenario: Consultar la mascota ingresada previamente (Búsqueda por ID)
      Given path '/pet/12345'
      When method GET
      Then status 200
      And match response contains { id: 12345, name: 'doggie', status: 'available' }

    Scenario: Actualizar el nombre de la mascota y el estatus de la mascota a “sold”
      * def updatedPet =
    """
    {
      "id": 12345,
      "category": {
        "id": 1,
        "name": "dogs"
      },
      "name": "updatedDoggie",
      "photoUrls": [
        "string"
      ],
      "tags": [
        {
          "id": 0,
          "name": "string"
        }
      ],
      "status": "sold"
    }
    """
      Given path '/pet'
      And request updatedPet
      When method PUT
      Then status 200
      And match response contains { id: 12345, name: 'updatedDoggie', status: 'sold' }

    Scenario: Consultar la mascota modificada por estatus (Búsqueda por estatus)
      Given path '/pet/findByStatus'
      And param status = 'sold'
      When method GET
      Then status 200
      #And match response contains { id: '#(12345)', name: 'updatedDoggie', status: 'sold' }
      And match response[*].name contains 'updatedDoggie'
