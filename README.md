# Eko Messenger

An E2EE messaging application.

## Installation

### Linux (x86/64)

#### Using Nix (Recommended)

##### Prerequisites

1. Install Nix with flakes enabled.

2. **(Optional) Configure Cachix for faster builds:**

   To avoid rebuilding dependencies from source, you can use the Eko Network binary cache.

   **For non-NixOS users**, add to your `~/.config/nix/nix.conf` (create if it doesn't exist):
   ```
   extra-substituters = https://eko-network.cachix.org
   extra-trusted-public-keys = eko-network.cachix.org-1:1xHfovoNlydsTCzXxr5AstUoJUmGR/tRq0PQSCyPab8=
   ```

   **For NixOS users**, add to your `/etc/nixos/configuration.nix`:
   ```nix
   nix.settings = {
     extra-substituters = [
       "https://eko-network.cachix.org"
     ];
     extra-trusted-public-keys = [
       "eko-network.cachix.org-1:1xHfovoNlydsTCzXxr5AstUoJUmGR/tRq0PQSCyPab8="
     ];
   };
   ```
   Then rebuild your system.


##### Installing

Run the application:
```bash
nix run
```
To avoid cloning the repo, you can run:
```bash
nix run https://github.com/eko-network/eko-messenger-client
```

##### Development Environment

Enter the development shell with all required dependencies:
```bash
nix develop
```
