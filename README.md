# picka-meet

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)

A personal clone of [LettuceMeet](https://lettucemeet.com/) — a group scheduling tool that helps people find the best time to meet.

## About

LettuceMeet is a web-based group scheduling application where users can:

- Create events with proposed dates and time ranges
- Share a link with participants
- Let participants mark their availability on a visual grid
- Automatically find overlapping available times

**picka-meet** replicates these core features for personal use. This project is non-commercial and is not affiliated with LettuceMeet.

## Tech Stack

| Layer        | Technology                                          |
| ------------ | --------------------------------------------------- |
| Frontend     | [![Blazor Server](https://img.shields.io/badge/Blazor%20Server-512BD4?logo=blazor&logoColor=white)](https://learn.microsoft.com/aspnet/core/blazor/) |
| UI Framework | [![MudBlazor](https://img.shields.io/badge/MudBlazor-594AE2?logoColor=white)](https://mudblazor.com/) |
| Backend      | [![ASP.NET Core](https://img.shields.io/badge/ASP.NET%20Core-512BD4?logo=dotnet&logoColor=white)](https://learn.microsoft.com/aspnet/core/) |
| ORM          | [![EF Core](https://img.shields.io/badge/EF%20Core-512BD4?logo=dotnet&logoColor=white)](https://learn.microsoft.com/ef/core/) |
| Database     | [![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?logo=postgresql&logoColor=white)](https://www.postgresql.org/) |
| DevOps       | [![Podman](https://img.shields.io/badge/Podman-892CA0?logo=podman&logoColor=white)](https://podman.io/) |

## Prerequisites

- [Podman](https://podman.io/) & Podman Compose (Docker & Docker Compose also supported)
- [.NET SDK](https://dotnet.microsoft.com/download) (optional, for local development without containers)
- [PostgreSQL](https://www.postgresql.org/) (optional, for local development without containers)

## Getting Started

```bash
# Clone the repository
git clone https://github.com/<your-username>/picka-meet.git
cd picka-meet

# Create a local environment file
cp .env.example .env

# Run Blazor Server + PostgreSQL with Podman
podman compose up --build -d
# Or with Docker
# docker compose up --build -d

# Access the application
# http://localhost:8080
```

### Container Layout

- `Dockerfile` lives at the repository root and builds `src/PickaMeet.Web/PickaMeet.Web.csproj`.
- `compose.yml` also lives at the repository root and starts:
  - `pickameet-web`
  - `postgres`
- PostgreSQL is only reachable on the internal container network by default.

### Environment Variables

Copy `.env.example` to `.env` and adjust values as needed:

```dotenv
APP_PORT=8080
POSTGRES_DB=pickameet
POSTGRES_USER=pickameet
POSTGRES_PASSWORD=pickameet_dev_password
```

The Blazor app receives its connection string from Compose through `ConnectionStrings__Default`.

### Resetting Local Database State

If you need a clean PostgreSQL volume:

```bash
podman compose down -v
# Or: docker compose down -v
```

### Railway Deployment

- Reuse the same root-level `Dockerfile` for Railway.
- Configure Railway to deploy the app service from this repository using the root `Dockerfile`.
- For production, use Railway-managed PostgreSQL instead of the local `compose.yml` database service.
- Ensure the deployed app binds to Railway's injected `PORT`; the Docker image already supports this at runtime.

## Commit Convention

This project follows [Conventional Commits v1.0.0](https://www.conventionalcommits.org/en/v1.0.0/).

### Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types

| Type       | Description                                               |
| ---------- | --------------------------------------------------------- |
| `feat`     | A new feature                                             |
| `fix`      | A bug fix                                                 |
| `docs`     | Documentation only changes                                |
| `style`    | Changes that do not affect the meaning of the code        |
| `refactor` | A code change that neither fixes a bug nor adds a feature |
| `perf`     | A code change that improves performance                   |
| `test`     | Adding missing tests or correcting existing tests         |
| `build`    | Changes that affect the build system or dependencies      |
| `ci`       | Changes to CI configuration files and scripts             |
| `chore`    | Other changes that don't modify src or test files         |
| `revert`   | Reverts a previous commit                                 |

### Example

```
fix: prevent racing of requests

Introduce a request id and a reference to latest request. Dismiss
incoming responses other than from latest request.

Remove timeouts which were used to mitigate the racing issue but are
obsolete now.

Reviewed-by: Z
Refs: #123
```

## License

This project is for **personal use only** and is not intended for commercial purposes.
