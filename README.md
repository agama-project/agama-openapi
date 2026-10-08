# Agama OpenAPI & Schemas

This repository hosts versioned OpenAPI specifications and JSON schemas for the [Agama installer](https://github.com/openSUSE/agama).

> **Important:** All specifications and schemas in this repository are generated from the main Agama codebase (either automatically for `nightly` or from maintenance branches for stable releases).
>
> This repository is a distribution mirror and does not accept direct contributions. All changes, bug fixes, or improvements to the OpenAPI definitions, JSON schemas, or documentation must be made upstream in the main [Agama repository](https://github.com/openSUSE/agama).

## Directory Structure

Specifications and schemas are organized by version or release branch:

* **`/nightly/`**: Generated from the latest `master` branch of Agama.
* **`/<version>/`** (e.g., `16.1`): Specifications and schemas corresponding to stable release branches (reflecting the latest officially released QU).

### Contents per Version

Each version directory contains:

* **`openapi.json` / `openapi.yaml`**: The primary OpenAPI 3.1 specification, referencing extracted standalone schemas in `schemas/`.
* **`openapi-full.json` / `openapi-full.yaml`**: Fully resolved, monolithic OpenAPI 3.1 specification containing all component schemas inline with no external file references.
* **`schemas/`**: Standalone JSON schemas (Draft 2019-09) extracted for validation targets:
  * **`config.schema.json`**: Schema for Agama autoinstallation profiles.
  * **`proposal.schema.json`**: Schema for installation proposals.
  * **`system.schema.json`**: Schema for system information.

## How Specifications Are Generated

### Nightly (`/nightly/`)

Nightly specifications are **automatically generated** from the `master` branch of the [Agama repository](https://github.com/openSUSE/agama). On every push that modifies relevant files in `master`, a GitHub Actions workflow generates the specifications via `cargo xtask openapi` and automatically pushes updates to the `/nightly/` directory in this repository.

### Stable Releases (`/<version>/`, e.g., `16.1`)

Stable specifications reflect the latest officially released QU (Quarterly Update) for a given code stream. They are **manually updated** when the product is officially released from its respective maintenance branch:

1. Check out the corresponding maintenance branch in the [Agama repository](https://github.com/openSUSE/agama).
2. Generate the OpenAPI specifications and schemas:
   ```sh
   cd rust
   cargo xtask openapi
   ```
3. Copy the whole content of `out/` to the target version directory in this repository:
   ```sh
   cp -r rust/out/* /path/to/agama-openapi/<version>/
   ```
4. If adding a new stable version, update `package/agama-openapi.spec` to include the new version directory under `%files`.
5. Commit and push the changes. The GitHub Actions workflow will automatically submit the update to OBS.

## RPM Packages

* **`agama-openapi`** (built from this repository):
  Provides OpenAPI specifications and schemas for **stable releases** (e.g. `16.1`). Files are installed under `/usr/share/agama/openapi/<version>/`.
* **`agama-openapi-nightly`** (built from the main [Agama repository](https://github.com/openSUSE/agama)):
  Provides nightly OpenAPI specifications and schemas generated during Agama development builds. Files are installed under `/usr/share/agama/openapi/nightly/`.

## Using the Schemas

### Autoinstallation Profiles

You can reference the JSON Schema directly in your Agama profile (JSON or YAML) for editor auto-completion and validation:

```json
{
  "$schema": "https://agama-project.github.io/openapi/nightly/schemas/config.schema.json",
  "product": {
    "id": "Tumbleweed"
  }
}
```

### Validating OpenAPI Specifications

You can validate the OpenAPI specifications using tools such as `openapi-spec-validator`:

```sh
openapi-spec-validator nightly/openapi.json
openapi-spec-validator nightly/openapi-full.json
```
