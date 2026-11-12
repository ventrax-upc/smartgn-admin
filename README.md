# SmartGN Admin

## Overview

Provides the operational dashboard for registered services and polls their health endpoints. The dashboard requires the configured local credentials.

**Stack**  Java 21, Spring Boot Admin.

## Run locally

Requirements are Docker Desktop with the Linux engine and PowerShell 7. Keep the SmartGN repositories as siblings for the integrated stack.

```powershell
./scripts/start-local.ps1 -Build
```

Run `./scripts/start-integrated.ps1` from the sibling `smartgn-api-gateway` repository.

| Endpoint | Local URL |
| --- | --- |
| Admin dashboard | [Open](http://localhost:8089/) |
| Health | [Open](http://localhost:8089/actuator/health) |

## Configuration

Standalone settings use the variables in `.env.example`. Copy it to an ignored `.env` when the local startup script requires it. Integrated credentials and generated files are stored under `.local` in the Gateway repository. The integrated username is `smartgn-local` and the password is `SMARTGN_ADMIN_PASSWORD`.

## Verification

```powershell
./scripts/smoke-local.ps1
```

Run the integrated smoke from the Gateway repository to verify cross-service workflows.

## Repository layout

- `src/main` contains the service implementation.
- `docs` contains service documentation.
- `scripts` contains local startup and verification commands.
- `tools` contains verification helpers and supporting assets.
- `fixtures/db.json` defines demo fixtures for local verification.

## Documentation

- [Local development](docs/local-development.md)

## License

Distributed under the [MIT License](LICENSE).
