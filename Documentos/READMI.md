# Documentación entregable — Backend S.I.G.I

**Hawk Durant · Emilio Jaramillo · Rodrigo Candia**  
Municipalidad Valle del Sol — Duoc UC

---

## Índice de documentos

| Documento | PDF | Descripción |
|-----------|-----|-------------|
| [INFORME_PRUEBAS_UNITARIAS.md](./INFORME_PRUEBAS_UNITARIAS.md) | [PDF](./pdf/INFORME_PRUEBAS_UNITARIAS.pdf) | Métricas JaCoCo, gráficos, ejemplos de pruebas, stack de testing |
| [ARQUITECTURA_MICROSERVICIOS.md](./ARQUITECTURA_MICROSERVICIOS.md) | [PDF](./pdf/ARQUITECTURA_MICROSERVICIOS.pdf) | Diagrama, tecnologías, comunicación Feign/REST, patrones |
| [PERSISTENCIA_DATOS.md](./PERSISTENCIA_DATOS.md) | [PDF](./pdf/PERSISTENCIA_DATOS.pdf) | JPA, MySQL, database per service, transacciones |
| [GUIA_EJECUCION_PRUEBAS.md](./GUIA_EJECUCION_PRUEBAS.md) | [PDF](./pdf/GUIA_EJECUCION_PRUEBAS.pdf) | Cómo correr `mvn verify` y abrir reportes HTML |
| [DEFENSA_ORAL.md](./DEFENSA_ORAL.md) | [PDF](./pdf/DEFENSA_ORAL.pdf) | Guía de exposición, banco de preguntas y respuestas individuales |
| [INFORME_BACKEND_SIGI.md](../INFORME_BACKEND_SIGI.md) | [PDF](./pdf/INFORME_BACKEND_SIGI.pdf) | Informe general del backend |
| [INFORME_BASE_DATOS_DOCKER.md](../INFORME_BASE_DATOS_DOCKER.md) | [PDF](./pdf/INFORME_BASE_DATOS_DOCKER.pdf) | Base de datos y Docker Compose |
| [repositorios.txt](./repositorios.txt) | Enlaces GitHub del proyecto |
| [postman/SIGI-Backend.postman_collection.json](./postman/SIGI-Backend.postman_collection.json) | Colección Postman vía API Gateway |
| [diagramas/arquitectura-microservicios-sigi.png](./diagramas/arquitectura-microservicios-sigi.png) | Diagrama PNG de arquitectura |

---

## Swagger (OpenAPI)

Cada microservicio expone documentación interactiva con **springdoc-openapi**:

```
http://localhost:8081/swagger-ui.html   → servicio-usuario
http://localhost:8082/swagger-ui.html   → servicio-reporte
… (8083 a 8088 según servicio)
```

En producción/demo consumimos la API **solo** por el Gateway (`http://localhost:8080`).

---

## Reportes de cobertura

1. Ejecutar: `mvn verify` en la raíz del backend
2. Copiar HTML: `./docs/scripts/copiar-reportes-cobertura.sh`
3. Abrir: `docs/cobertura/<modulo>/index.html`

## Regenerar PDFs

```bash
./docs/scripts/md-a-pdf.sh
```

Los archivos quedan en `docs/pdf/`.

---

## Repositorios GitHub

- Documentación: https://github.com/Rodri1988/Documentacion-SIGI.git
- Frontend + monorepo: https://github.com/Rodri1988/Proyecto-Municipalidad-Valle-del-Sol
- Backend: https://github.com/Rock14k/Proyecto-SIGI-Backend.git

---

*Última actualización: junio 2026*
