# Powershell utilities for temporary files

This module provides tools to work with temporary files in Powershell. The `New-TemporaryFiles` builtin creates short names guessable names and performs no cleanup, leading to poor tempfile hygiene. Additionally, there is no builtin for creating temporary directories.

All temporary files and directories uses `[System.IO.Path]::GetTempPath()` as a base. Temporary names are based on UUIDs.

This module provides these functions:

- **Get-TemporaryPath**: Returns the full path to a uniquely named temporary file. The file is not created.
- **Use-TemporaryDirectory**: Create a temporary directory and expose as psitem to the provided scriptblock.
