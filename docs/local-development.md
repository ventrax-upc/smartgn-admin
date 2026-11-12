# Local development

## Start

From this repository, prepare the local environment and start the Admin Server:

```powershell
./scripts/start-local.ps1 -Build
```

The script copies `.env.example` to `.env` only when `.env` does not already exist. Edit the local username and password before starting if needed. Keep `.env` private. The standalone Compose publishes the dashboard on `http://127.0.0.1:8089` and does not start Config Server; Config Server import is optional for this application.

When using the complete platform, start the 11-service composition from `../smartgn-api-gateway` with `./scripts/start-integrated.ps1`. The integrated environment is generated under that repository's ignored `.local` directory and supplies the shared Admin credentials to Config and all service registrations. See [integrated local SmartGN](../../smartgn-api-gateway/docs/integrated-local.md).

## Verify

```powershell
./scripts/smoke-local.ps1
```

The runtime verification checks the authenticated Actuator health response and requires `status: UP`. It reads the credentials from the current PowerShell environment, then `.env`, then the Compose defaults. The Admin Server has no application API contract, so this check does not use Swagger or OpenAPI.

To stop the standalone container while preserving its state:

```powershell
docker compose down
```
