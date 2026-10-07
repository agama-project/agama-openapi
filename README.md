# Agama OpenAPI & Schemas

This repository hosts versioned OpenAPI specifications and JSON schemas for the [Agama installer](https://github.com/openSUSE/agama).

> **Important:** All specifications and schemas in this repository are **automatically generated** from the main Agama codebase.
>
> This repository is a distribution mirror and does not accept direct contributions. All changes, bug fixes, or improvements to the OpenAPI definitions, JSON schemas, or documentation must be made upstream in the main [Agama repository](https://github.com/openSUSE/agama).

## Directory Structure

Specifications and schemas are organized by version or release branch:

* **`/nightly/`**: Generated from the latest `master` branch of Agama.
* **`/<version>/`** (e.g., `16.1`): Specifications and schemas corresponding to stable release branches.

### Contents per Version

Each version directory contains:

* **`openapi.json` / `openapi.yaml`**: The primary OpenAPI 3.1 specification, referencing extracted standalone schemas in `schemas/`.
* **`openapi_full.json` / `openapi_full.yaml`**: Fully resolved, monolithic OpenAPI 3.1 specification containing all component schemas inline with no external file references.
* **`schemas/`**: Standalone JSON schemas (Draft 2019-09) extracted for validation targets:
  * **`config.schema.json`**: Schema for Agama autoinstallation profiles.
  * **`proposal.schema.json`**: Schema for installation proposals.
  * **`system.schema.json`**: Schema for system information.

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
